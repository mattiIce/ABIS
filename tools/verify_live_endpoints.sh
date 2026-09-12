#!/usr/bin/env bash
# Verify a DEPLOYED ABIS build against the real database.
#
# Why this exists: the test suite runs on the SQLite fixture, so a whole class of defect survives a green
# suite — NULL ordering, tie-broken paging, date arithmetic, numeric mapping. Two real ones were found this
# way (2026-09-12): COIL_TRACK's location columns are never written, and the default ORDER BY never received
# its tie-breaker, so tied rows came back unordered on Oracle while every test passed.
#
# It asserts INVARIANTS, not figures — the data moves, the relationships do not. Read-only: every call is a
# GET, nothing is written, and nothing is transmitted.
#
# Usage, on the server (reads the API key from the service env, so the secret never leaves the box):
#   bash tools/verify_live_endpoints.sh
# Or against another host:
#   BASE_URL=http://host:8080 API_KEY=... bash tools/verify_live_endpoints.sh
set -uo pipefail

BASE_URL="${BASE_URL:-http://127.0.0.1:8080}"
if [ -z "${API_KEY:-}" ] && [ -r /etc/abis/abis.env ]; then
  # NB: the value is quoted in the env file; the quotes are not part of the key.
  API_KEY=$(grep -E '^ApiKeys__Keys__0=' /etc/abis/abis.env | cut -d= -f2- | tr -d '"'"'"'')
fi
: "${API_KEY:?set API_KEY, or run this on a host with /etc/abis/abis.env}"

pass=0; fail=0
check() {  # check <name> <url> <python-expression-over-d>
  local name="$1" url="$2" expr="$3" body code tmp
  # The HTTP status is checked separately: an error payload (401, 500) is still JSON, and an expression like
  # `all(... for r in d)` is vacuously TRUE over it — which reported three false PASSes the first time this
  # script was pointed at a wrong key. A check that cannot fail is worse than no check.
  tmp=$(mktemp)
  code=$(curl -s -o "$tmp" -w '%{http_code}' -H "X-Api-Key: $API_KEY" "$BASE_URL$url")
  body=$(cat "$tmp"); rm -f "$tmp"
  if [ "$code" != "200" ]; then
    echo "  FAIL  $name — HTTP $code"; fail=$((fail+1)); return
  fi
  if result=$(printf '%s' "$body" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
except Exception as e:
    print('not JSON: %s' % e); raise SystemExit(1)
ok, detail = ($expr)
print(detail)
raise SystemExit(0 if ok else 1)
" 2>&1); then
    echo "  PASS  $name — $result"; pass=$((pass+1))
  else
    echo "  FAIL  $name — $result"; fail=$((fail+1))
  fi
}

echo "Verifying $BASE_URL against its real database"

# Health first: everything below is meaningless if the database is not reachable.
check "health/ready reports ready" "/health/ready" \
  "(d.get('status') == 'ready', 'status=%s' % d.get('status'))"

# The invoice's scrap rows must add up to the scrap weight printed above them. This is the money path that
# deliberately departs from legacy (a plain sum, not SUM(DISTINCT)), so the reconciliation is the whole claim.
check "invoice scrap rows reconcile to the total" "/api/accounting/invoices/124500/computation" \
  "(abs(sum(r['netWt'] for r in d.get('scrapByType', [])) + (d.get('scrapNotOnSkidWt') or 0) - (d.get('scrapWt') or 0)) < 0.01,
    'rows+unskidded=%s scrapWt=%s' % (sum(r['netWt'] for r in d.get('scrapByType', [])) + (d.get('scrapNotOnSkidWt') or 0), d.get('scrapWt')))"

# Every named scrap type must be named: an unmapped code printed a blank status before the map was extended.
check "every scrap type on that invoice has a name" "/api/accounting/invoices/124500/computation" \
  "(all(r.get('scrapTypeName') for r in d.get('scrapByType', [])), '%d types, all named' % len(d.get('scrapByType', [])))"

# ALPH: a line's own hours and weight must produce its own rate, and uptime cannot exceed what was scheduled.
check "lbs-per-hour rows are self-consistent" "/api/reporting/lbs-per-hour?lineNum=7&groupBy=month" \
  "(all(r['lbsPerHour'] is None or r['hours'] in (None, 0) or abs(r['lbsPerHour'] - r['processedWt']/r['hours']) < 1.0 for r in d),
    '%d monthly rows' % len(d))"
check "uptime never exceeds scheduled time" "/api/reporting/uptime?groupBy=line" \
  "(all(r['uptimeHours'] <= r['scheduledHours'] + 0.01 and (r['uptimePct'] is None or 0 <= r['uptimePct'] <= 100) for r in d),
    '%d lines' % len(d))"

# Paging: tied sort keys must not leave the page boundary undefined. Two pages of the same list must not
# share a row — the defect that survived a green suite until it was run against Oracle.
check "paged test results do not repeat a row across pages" "/api/test-results?page=1&pageSize=25" \
  "(len({(r['coilAbcNum'], r['position'], r['createdDate'], r['sourceId']) for r in d['items']}) == len(d['items']),
    'page 1 holds %d distinct rows' % len(d['items']))"

# Archived ASN BOLs: newest received first, with the undated ones last (Oracle sorts NULLs FIRST on DESC).
check "archived BOLs are newest-first with undated last" "/api/inbound-asns?customerId=1153&pageSize=50" \
  "((lambda ts: (all(a >= b for a, b in zip([t for t in ts if t], [t for t in ts if t][1:]))
                 and [t for t in ts if t is None] == ts[len([t for t in ts if t]):],
                 '%d BOLs, %d undated' % (len(ts), len([t for t in ts if t is None]))))
    ([b['receivedTime'] for b in d['items']]))"

# Coil history: a coil that has left inventory reads 0 days, never its age on the floor.
check "a shipped coil reports no sitting time" "/api/coils/235684/history" \
  "(d.get('durationDays') == 0, 'durationDays=%s status-driven' % d.get('durationDays'))"

# On-hand weight must exclude the statuses that have left inventory, so a balance can never be negative.
check "weight on hand has no negative balance" "/api/coils/summary?groupBy=alloy" \
  "(all((r.get('totalBalance') or 0) >= 0 for r in d), '%d alloy groups' % len(d))"

echo
echo "passed $pass, failed $fail"
[ "$fail" -eq 0 ]
