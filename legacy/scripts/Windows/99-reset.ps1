$ErrorActionPreference='Stop'
docker compose down -v --remove-orphans
Write-Host 'IDMCluster reset complete.' -ForegroundColor Green
