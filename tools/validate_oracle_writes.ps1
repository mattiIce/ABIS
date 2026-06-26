<#
.SYNOPSIS
  Live-validates the ABIS API write + lookup endpoints against the real Oracle DB.

.DESCRIPTION
  Runs the API in Oracle mode locally (no proxy in the way), then exercises every
  write endpoint added in the modernization, creating clearly-named ZZ_WRITE_TEST
  rows. Prints the created ids and ready-to-run DELETE statements for cleanup.

  Run this from a machine that can reach the Oracle listener directly
  (e.g. 192.168.1.230:1521). Requires the .NET 8 SDK and this repo checked out.

.EXAMPLE
  # Service name form (try this first):
  ./tools/validate_oracle_writes.ps1 -ConnectionString "Data Source=192.168.1.230:1521/abc11;User Id=dbo;Password=YOURPW;"

  # SID form (if the service-name form gives ORA-12514):
  ./tools/validate_oracle_writes.ps1 -ConnectionString "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.1.230)(PORT=1521))(CONNECT_DATA=(SID=abc11)));User Id=dbo;Password=YOURPW;"
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)][string]$ConnectionString,
    [string]$BaseUrl = "http://127.0.0.1:5230",
    [switch]$NoRun   # skip launching the API (use if it is already running)
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$proj = Join-Path $repoRoot "api/src/ABIS.Api/ABIS.Api.csproj"
$created = [ordered]@{}

function Step($m) { Write-Host "`n=== $m ===" -ForegroundColor Cyan }
function Post($path, $body) {
    return Invoke-RestMethod -Method Post -Uri "$BaseUrl$path" -ContentType 'application/json' -Body ($body | ConvertTo-Json -Depth 6)
}
function Get-($path) { return Invoke-RestMethod -Method Get -Uri "$BaseUrl$path" }

# --- Configure + launch the API in Oracle mode ---------------------------------
$env:Database__Provider = "Oracle"
$env:Database__ConnectionString = $ConnectionString
$env:Database__Seed = "false"
$env:ApiKeys__Enabled = "false"      # local validation only; no key needed
$env:Audit__Enabled = "false"        # opc_action_log may not exist in DBO
$env:ASPNETCORE_URLS = $BaseUrl
$env:ASPNETCORE_ENVIRONMENT = "Development"

$apiProc = $null
if (-not $NoRun) {
    Step "Building + launching the API in Oracle mode"
    & dotnet build $proj -c Release | Out-Host
    $apiProc = Start-Process dotnet -ArgumentList "run --no-build --project `"$proj`" -c Release" -PassThru -NoNewWindow
}

try {
    # --- Readiness (proves the DB connection) ---------------------------------
    Step "Waiting for /health/ready (live DB connectivity)"
    $ready = $false
    for ($i = 0; $i -lt 40; $i++) {
        try { if ((Get- "/health/ready").status -eq "ready") { $ready = $true; break } } catch { }
        Start-Sleep -Seconds 2
    }
    if (-not $ready) { throw "API never became ready - check the connection string / listener." }
    Write-Host "DB reachable." -ForegroundColor Green

    # --- Grab real ids the writes can reference -------------------------------
    Step "Fetching a real customerId and abJobNum to reference"
    # customer_id 0 is the legacy "SELECT CUSTOMER" sentinel row; skip it and pick a real customer.
    $custId = ((Get- "/api/customers?pageSize=5").items | Where-Object { $_.customerId -gt 0 } | Select-Object -First 1).customerId
    $jobNum = (Get- "/api/jobs?pageSize=1").items[0].abJobNum
    Write-Host "customerId=$custId  abJobNum=$jobNum"
    if ($null -eq $custId) { throw "No customers found - cannot test FK-bearing writes." }

    # --- Writes (each tagged ZZ_WRITE_TEST) -----------------------------------
    Step "POST /api/dies"
    $r = Post "/api/dies" @{ dieName = "ZZ_WRITE_TEST die"; status = 0; toolNum = "ZZT-1" }
    $created["die (die_id)"] = $r.dieId; Write-Host "  die_id=$($r.dieId)"

    Step "POST /api/sketches"
    # sketch_name is VARCHAR2(16); keep the tag within the column width.
    $r = Post "/api/sketches" @{ sketchName = "ZZ_WRITE_TEST"; sketchNotes = "ZZ_WRITE_TEST probe"; sketchStatus = 0 }
    $created["sketch (sketch_id)"] = $r.sketchId; Write-Host "  sketch_id=$($r.sketchId)"

    Step "POST /api/customers/$custId/contacts"
    $r = Post "/api/customers/$custId/contacts" @{ firstName = "ZZ"; lastName = "WRITE_TEST"; department = "QA" }
    $created["customer_contact (contact_id)"] = $r.contactId; Write-Host "  contact_id=$($r.contactId)"

    Step "POST /api/shipments  (dual sequence: packing_list_num_seq + bill_of_lading_seq)"
    $r = Post "/api/shipments" @{ customerId = $custId; carrierId = $null; shipmentStatus = 0; shipmentNotes = "ZZ_WRITE_TEST" }
    $created["shipment (packing_list)"] = $r.packingList; Write-Host "  packing_list=$($r.packingList)  bill_of_lading=$($r.billOfLading)"

    Step "POST /api/receiving-bols"
    $r = Post "/api/receiving-bols" @{ bol = "ZZ_WRITE_TEST-BOL"; customerId = $custId; createdBy = "zztest"; status = 0 }
    $created["receiving_bol (receiving_bol_id)"] = $r.receivingBolId; Write-Host "  receiving_bol_id=$($r.receivingBolId)"

    Step "POST /api/scan-logs"
    $r = Post "/api/scan-logs" @{ abJobNum = $jobNum; scanStation = "ZZTEST"; note = "ZZ_WRITE_TEST scan" }
    $created["scan_log (scan_id)"] = $r.scanId; Write-Host "  scan_id=$($r.scanId)"

    Step "POST /api/maint-logs  (MAX+1 id - no sequence)"
    # maint_log_status is FK-constrained to MAINT_LOG_STATUS; "Completed" is a verified-valid value.
    $r = Post "/api/maint-logs" @{ maintLogStatus = "Completed"; probDateTime = (Get-Date).ToString("s"); probDetails = "ZZ_WRITE_TEST fault"; author = "zztest" }
    $created["maint_log (maint_log_id)"] = $r.maintLogId; Write-Host "  maint_log_id=$($r.maintLogId)"

    Step "POST /api/shifts"
    $r = Post "/api/shifts" @{ startTime = (Get-Date).ToString("s"); lineNum = $null; operatorInitial = "ZZ"; note = "ZZ_WRITE_TEST" }
    $created["shift (shift_num)"] = $r.shiftNum; Write-Host "  shift_num=$($r.shiftNum)"

    Step "POST /api/downtime"
    $r = Post "/api/downtime" @{ abJobNum = $jobNum; startingTime = (Get-Date).ToString("s"); note = "ZZ_WRITE_TEST" }
    $created["dt_instance (instance_num)"] = $r.instanceNum; Write-Host "  instance_num=$($r.instanceNum)"

    # --- Lookup reads (verify the new columns exist in the real schema) -------
    Step "GET the 6 new lookup endpoints (verifies columns resolve against live schema)"
    foreach ($lk in "lines", "groupdepartments", "downtime-causes", "transportation-methods", "equipment-types", "customer-types") {
        $rows = Get- "/api/lookups/$lk"
        Write-Host ("  /lookups/{0,-22} -> {1} rows" -f $lk, $rows.Count)
    }

    # --- Summary + cleanup SQL ------------------------------------------------
    Step "DONE - all writes + lookup reads succeeded against live Oracle"
    Write-Host "`nCreated test rows:" -ForegroundColor Green
    $created.GetEnumerator() | ForEach-Object { Write-Host ("  {0,-34} = {1}" -f $_.Key, $_.Value) }

    # Tag-based cleanup: every write above stamps a ZZ_WRITE_TEST marker into a text column,
    # so deleting by tag also sweeps up orphan rows left by any earlier *partial* (failed) run,
    # which an id-only cleanup would miss.
    Write-Host "`n--- Cleanup SQL (run in SQL Developer, then COMMIT) ---" -ForegroundColor Yellow
    Write-Host "DELETE FROM die             WHERE die_name       = 'ZZ_WRITE_TEST die';"
    Write-Host "DELETE FROM sketch          WHERE sketch_name    = 'ZZ_WRITE_TEST';"
    Write-Host "DELETE FROM customer_contact WHERE first_name    = 'ZZ' AND last_name = 'WRITE_TEST';"
    Write-Host "DELETE FROM shipment        WHERE shipment_notes = 'ZZ_WRITE_TEST';"
    Write-Host "DELETE FROM receiving_bol   WHERE bol            = 'ZZ_WRITE_TEST-BOL';"
    Write-Host "DELETE FROM scan_log        WHERE note           = 'ZZ_WRITE_TEST scan';"
    Write-Host "DELETE FROM maint_log       WHERE prob_details   = 'ZZ_WRITE_TEST fault';"
    Write-Host "DELETE FROM shift           WHERE note           = 'ZZ_WRITE_TEST';"
    Write-Host "DELETE FROM dt_instance     WHERE note           = 'ZZ_WRITE_TEST';"
    Write-Host "COMMIT;"
}
finally {
    if ($apiProc -and -not $apiProc.HasExited) {
        Step "Stopping the API"
        Stop-Process -Id $apiProc.Id -Force -ErrorAction SilentlyContinue
    }
}
