# On-prem Active Directory sign-in (LDAP bind)

Let ABIS users sign in with their **existing AD (ADUC) username + password**, validated by an
**LDAP simple-bind** to a domain controller. No Entra/Azure, no AD FS, no domain-join of the Linux
host — the app just binds to a DC over LDAP(S). Off by default; when `Auth:Ldap` isn't configured,
`/auth/login` uses the local PBKDF2 credential store as before.

## How it works
1. The login screen posts `{username, password}` to `POST /auth/login`.
2. ABIS looks up the `security_user` row by the username (identity + RBAC come from ABIS).
3. It **binds to the DC** with that credential. Bind OK → issue the bearer JWT that drives RBAC;
   bind rejected → `401`. An **empty password is rejected before binding** (an LDAP simple-bind with
   an empty password is an "unauthenticated bind" that succeeds — so we never attempt it).

**Requirement:** the AD **sAMAccountName must equal the ABIS `security_user.login_id`** (both
`jsmith`-style). `DOMAIN\user` and `user@domain` inputs are normalised to the bare name. If your AD
usernames differ from the ABIS logins, we need a mapping step — tell me and I'll add it.

## Configure (server `appsettings`, e.g. `/etc/abis/abis.env` or `appsettings.json`)
```jsonc
"Auth": {
  "Ldap": {
    "Enabled": true,
    "Hosts": [ "192.168.1.22", "192.168.1.23" ],  // DCs tried in order (primary first) — failover
    "UseSsl": true,                    // LDAPS on 636 — recommended (the password travels to the DC)
    "Port": 0,                         // 0 = default (636 if UseSsl else 389)
    "UserBindFormat": "ALBL\\{0}",     // NetBIOS DOMAIN\user  ({0} = the username; \\ escapes in JSON)
    "AcceptAnyCertificate": false      // set true only for an internal self-signed/private-CA DC on a trusted LAN
  },
  "Jwt": {
    "SigningKey": "<32+ char persistent secret>"   // so bearer sessions survive an app restart
  }
}
```
As env vars (double-underscore + array indices):

```ini
Auth__Ldap__Enabled=true
Auth__Ldap__Hosts__0=ALBL-PDC1.albl.com
Auth__Ldap__Hosts__1=ALBL-SDC1.albl.com
Auth__Ldap__UseSsl=true
Auth__Ldap__UserBindFormat=ALBL\\{0}      # NOTE THE DOUBLE BACKSLASH
```

> ### The double backslash is not a typo, and getting it wrong costs a morning
>
> **systemd interprets backslash escapes in an `EnvironmentFile`**, including inside double
> quotes. A single `\` is consumed. So `Auth__Ldap__UserBindFormat=ALBL\{0}` — which is what this
> document used to show — arrives at the app as **`ALBL{0}`**, and every sign-in binds as
> `ALBLsomeone` instead of `ALBL\someone`.
>
> AD refuses that, and the login page says **"the username or password is incorrect"** — so the
> person signing in checks the one thing that is not wrong. This happened on 2026-08-21.
>
> Verify what the SERVICE received, not what the file says:
>
> ```bash
> tr '\0' '\n' < /proc/$(systemctl show -p MainPID --value abis)/environ | grep UserBindFormat
> ```
>
> That must print exactly one backslash. Since 2026-08-21 the app also logs a startup warning
> when the bind format has no `@` or `\` separator, because such a format can never
> authenticate anyone.
>
> **Or sidestep it entirely:** the UPN form `{0}@albl.com` contains no backslash, so nothing can
> eat it. Prefer it unless your UPN suffix differs from the AD domain.

In `appsettings.json` the JSON escaping is separate and unrelated — there `\\` is simply how JSON
spells one backslash. The doubling above is systemd's, on top of nothing.

**Failover:** the DCs are tried in order. A DC that's unreachable is skipped (→ next DC); a reachable
DC that *rejects* the password is authoritative (no point trying the other). A single `Host` still
works if you prefer (`Hosts` wins when both are set).

## LDAPS needs the DC's CA in the HOST trust store

With `UseSsl: true` the app opens LDAPS on 636 and **validates the DC's certificate chain**. AD
domain controllers are normally issued certificates by an internal enterprise CA, and a Linux host
does not trust that CA out of the box. When it cannot, the bind never happens:

```
LDAP error on ALBL-PDC1.albl.com:636 ... The remote certificate was rejected by the
provided RemoteCertificateValidationCallback.
```

Every DC fails the same way, so no password can be verified — and before 2026-08-21 that surfaced
as "the username or password is incorrect", which is the wrong thing to look at. It now answers
**503 Directory unavailable**, saying plainly that this is not a problem with the account.

**Fix it by trusting the CA** (the DC sends only its own leaf, so the CA cannot be scraped off the
wire). Export the root from any domain-joined Windows machine:

```
certutil -config "ALBL-PDC1.albl.com\albl-ALBL-PDC1-CA" -ca.cert C:\temp\pdc1-root.cer
```

> Check what you exported. Plain `certutil -ca.cert` returns the CA **that machine** is enrolled
> with, which in a two-tier PKI is the *subordinate* — on 2026-08-21 it returned
> `albl-ALBL-SDC1-CA`, which would have installed cleanly and fixed nothing. Confirm with
> `openssl x509 -noout -subject -issuer`: for a root they are identical, and the subject must match
> the `issuer` of the DC's own certificate.

Then on the app host — the `.crt` extension is required, and `update-ca-certificates` silently
ignores anything else:

```bash
sudo cp pdc1-root.cer /usr/local/share/ca-certificates/albl-root-ca.crt
sudo update-ca-certificates          # must report: 1 added
sudo systemctl restart abis
```

Verify against **every** DC before declaring it fixed:

```bash
for H in ALBL-PDC1 ALBL-SDC1; do printf '%s: ' $H; \
  openssl s_client -connect $H.albl.com:636 </dev/null 2>/dev/null | grep -i 'verify return code'; done
```

Both must read `0 (ok)`. `AcceptAnyCertificate: true` also silences the error, but it drops the
chain check entirely — the connection stays encrypted and stops proving *who* it is talking to. Use
it as a stopgap, not a fix.

**The certificate expires.** The one installed on 2026-08-21 is valid to **May 2030**. When it
lapses this recurs — at which point, with no break-glass password set, nobody can sign in to fix
it. Which is the next section.

## Break-glass local admin
When AD is on, if a bind is rejected **or every DC is unreachable**, sign-in falls back to a **local
password** — but **only** for an account that has an admin-set credential (never passwordless; the
blank-password guard stays). So set a local password on one admin account (Security admin → set
password) and that admin can still get in if AD/the DCs are down. Everyone else is AD-only.

> **With no local password on any account, an AD or certificate problem locks out every human.** On
> 2026-08-21 both DCs failed their TLS handshake, `abis_user_credential` held zero rows, and the only
> way into the system was the service API key. The app now logs a warning at startup when AD is
> enabled and no account has a local credential — but a warning is not a password. Set one.

### Notes
- **`UserBindFormat`** — most AD accepts the UPN `{0}@abc.local`. If your UPN suffix differs from the
  AD domain, use the NetBIOS form `ABC\{0}` instead.
- **LDAPS certificate** — for a real chain check, trust the DC's issuing CA on the ABIS host. Only
  flip `AcceptAnyCertificate` to skip validation for an internal self-signed DC on a trusted LAN.
- **Persistent signing key** — set `Auth:Jwt:SigningKey` (32+ chars) in prod so sessions aren't
  invalidated on every restart (otherwise an ephemeral key is used).
- **No enrollment needed** — passwords live in AD. Users just need a matching `security_user` row
  with grants (managed in the ABIS Security admin). The **API key** stays as the machine / break-glass
  path (it bypasses user auth), so you can't lock yourself out.

## Hardening that ships with this
- **Empty-password bind is rejected** up front — closes the blank-password sign-in.
- **`/auth/login` is rate-limited** to 10 attempts/min per client IP (brute-force protection *and*
  to avoid tripping AD account lockouts). Active when `RateLimiting:Enabled` is on (recommended in prod).

## Verify after enabling
```sh
# a real AD user with a security_user row + a correct password → 200 + a token
curl -s -X POST http://127.0.0.1:8080/auth/login -H 'Content-Type: application/json' \
  -d '{"login":"jsmith","password":"<their AD password>"}'

# wrong password → 401 ; blank password → 401 (never binds)
curl -s -o /dev/null -w '%{http_code}\n' -X POST http://127.0.0.1:8080/auth/login \
  -H 'Content-Type: application/json' -d '{"login":"jsmith","password":""}'
```
