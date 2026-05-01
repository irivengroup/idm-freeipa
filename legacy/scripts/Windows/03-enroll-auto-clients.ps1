$ErrorActionPreference='Stop'
. "$PSScriptRoot\lib.ps1"
Read-DotEnv
Invoke-Step 'start clients' { docker compose up -d idmclient1a idmclient2a idmclient1b idmclient2b idmnode1a idmnode1b }
$clients = @($env:IDMCLIENT1A_HOST,$env:IDMCLIENT2A_HOST,$env:IDMCLIENT1B_HOST,$env:IDMCLIENT2B_HOST)
foreach($c in $clients){
  Wait-ContainerRunning $c 300
  $fqdn = docker inspect $c --format '{{.Config.Hostname}}'
  $cmd = "ipa-client-install -U --server=$env:IDM_PRIMARY_FQDN --domain=$env:DOMAIN --realm=$env:REALM --hostname=$fqdn -p $env:IPA_ADMIN_USER -w '$env:IPA_ADMIN_PASSWORD' --mkhomedir --no-ntp --force-join"
  Invoke-Step "enroll $c" { docker exec $c bash -lc $cmd }
}
Write-Host 'Manual nodes are running but intentionally not enrolled.' -ForegroundColor Yellow
