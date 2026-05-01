$ErrorActionPreference = "Stop"
Write-Host "[CHECK] Docker"
docker version | Out-Host
docker compose version | Out-Host
Write-Host "[CHECK] WSL"
wsl --status | Out-Host
Write-Host "[CHECK] Compose syntax"
docker compose config | Out-Null
Write-Host "OK - prérequis Windows/Docker valides."
