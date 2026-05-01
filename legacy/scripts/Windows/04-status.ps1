$ErrorActionPreference='Continue'
. "$PSScriptRoot\lib.ps1"
Read-DotEnv
Write-Host "Containers:" -ForegroundColor Cyan
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
Write-Host "`nPrimary status:" -ForegroundColor Cyan
docker exec idmprimarya bash -lc 'ipactl status; echo; kinit admin <<< "$IPA_ADMIN_PASSWORD" >/dev/null 2>&1 || true; ipa config-show 2>/dev/null | head -40 || true'
