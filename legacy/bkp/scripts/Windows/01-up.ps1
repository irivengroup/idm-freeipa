$ErrorActionPreference = "Stop"
docker compose build
docker compose up -d idm-primary
Write-Host "Suivre l'installation: docker logs -f idm-primary"
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
Write-Host "Quand idm-primary est prêt: .\scripts\Windows\02-install-replica-b.ps1"
