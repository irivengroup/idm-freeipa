$ErrorActionPreference='Stop'
. "$PSScriptRoot\lib.ps1"
Read-DotEnv
Invoke-Step 'start replica container' { docker compose up -d idmreplicab }
Wait-ContainerRunning idmreplicab 300
$cmd = "ipa-replica-install -U --server $env:IDM_PRIMARY_FQDN --domain $env:DOMAIN --realm $env:REALM -p $env:IPA_ADMIN_USER -w '$env:IPA_ADMIN_PASSWORD' --setup-dns --forwarder=$env:DNS_FORWARDER_1 --forwarder=$env:DNS_FORWARDER_2 --forward-policy=$env:DNS_FORWARD_POLICY --no-reverse --no-ntp --no-ssh --no-sshd --no-dns-sshfp --skip-mem-check"
Invoke-Step 'install replica B' { docker exec idmreplicab bash -lc $cmd }
