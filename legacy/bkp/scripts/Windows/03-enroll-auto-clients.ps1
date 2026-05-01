$ErrorActionPreference = "Stop"
Get-Content .env | Where-Object {$_ -match '^[A-Za-z_].*='} | ForEach-Object { $n,$v=$_.Split('=',2); [Environment]::SetEnvironmentVariable($n,$v,'Process') }
docker compose up -d client-a1 client-a2 client-b1 client-b2 node-a node-b
$clients = @('client-a1','client-a2','client-b1','client-b2')
foreach ($c in $clients) {
  Write-Host "[ENROLL] $c"
  docker exec $c bash -lc "ipa-client-install -U --domain='$env:DOMAIN' --realm='$env:REALM' --server='idm-primary.$env:DOMAIN' --principal=admin --password='$env:IPA_ADMIN_PASSWORD' --mkhomedir --no-ntp || true"
}
