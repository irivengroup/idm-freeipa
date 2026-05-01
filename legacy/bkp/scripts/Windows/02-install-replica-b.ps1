$ErrorActionPreference = "Stop"
. .\.env.ps1 2>$null
if (-not $env:DOMAIN) { Get-Content .env | Where-Object {$_ -match '^[A-Za-z_].*='} | ForEach-Object { $n,$v=$_.Split('=',2); [Environment]::SetEnvironmentVariable($n,$v,'Process') } }

docker compose up -d idm-replica
Start-Sleep -Seconds 15

docker exec idm-replica bash -lc "echo '$env:IPA_ADMIN_PASSWORD' | kinit admin"
docker exec idm-replica bash -lc "ipa-client-install -U --domain='$env:DOMAIN' --realm='$env:REALM' --server='idm-primary.$env:DOMAIN' --principal=admin --password='$env:IPA_ADMIN_PASSWORD' --mkhomedir --no-ntp"
docker exec idm-replica bash -lc "ipa-replica-install -U --setup-dns --forwarder='$env:DNS_FORWARDER_1' --forwarder='$env:DNS_FORWARDER_2' --admin-password='$env:IPA_ADMIN_PASSWORD' --no-ntp --skip-mem-check || tail -n 120 /var/log/ipareplica-install.log"
Write-Host "Replica demandée. Vérifier: docker exec idm-primary ipa topologysegment-find domain"
