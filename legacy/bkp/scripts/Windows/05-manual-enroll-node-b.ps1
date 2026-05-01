$ErrorActionPreference = "Stop"
Get-Content .env | Where-Object {$_ -match '^[A-Za-z_].*='} | ForEach-Object { $n,$v=$_.Split('=',2); [Environment]::SetEnvironmentVariable($n,$v,'Process') }
docker exec -it node-b bash -lc "ipa-client-install --domain='$env:DOMAIN' --realm='$env:REALM' --server='idm-replica.$env:DOMAIN' --principal=admin --mkhomedir --no-ntp"
