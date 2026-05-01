$ErrorActionPreference='Stop'
. "$PSScriptRoot\lib.ps1"
Read-DotEnv
Invoke-Step 'docker compose config --quiet' { docker compose config --quiet }
Invoke-Step 'docker compose build clients' { docker compose build idmclient1a idmclient2a idmclient1b idmclient2b idmnode1a idmnode1b }
Invoke-Step 'docker compose up -d idmprimarya' { docker compose up -d idmprimarya }
Write-Host 'Follow primary install: docker logs -f idmprimarya' -ForegroundColor Yellow
Write-Host 'Validate when finished: .\scripts\Windows\04-status.ps1' -ForegroundColor Yellow
