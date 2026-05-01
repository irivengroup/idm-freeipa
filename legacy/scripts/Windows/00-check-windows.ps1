$ErrorActionPreference='Stop'
. "$PSScriptRoot\lib.ps1"
Read-DotEnv
Invoke-Step 'docker version' { docker version }
Invoke-Step 'docker compose version' { docker compose version }
Invoke-Step 'docker compose config --quiet' { docker compose config --quiet }
Write-Host 'OK - Windows/Docker prerequisites look valid.' -ForegroundColor Green
