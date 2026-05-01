function Read-DotEnv {
  param([string]$Path = ".env")
  Get-Content $Path | ForEach-Object {
    if ($_ -match '^\s*#' -or $_ -match '^\s*$') { return }
    $pair = $_ -split '=', 2
    if ($pair.Count -eq 2) {
      [Environment]::SetEnvironmentVariable($pair[0].Trim(), $pair[1].Trim(), 'Process')
    }
  }
}
function Invoke-Step {
  param([string]$Title, [scriptblock]$Block)
  Write-Host "`n> $Title" -ForegroundColor Cyan
  & $Block
  if ($LASTEXITCODE -ne 0) { throw "Step failed: $Title" }
}
function Wait-ContainerRunning {
  param([string]$Name,[int]$TimeoutSec=900)
  $deadline=(Get-Date).AddSeconds($TimeoutSec)
  while((Get-Date) -lt $deadline){
    $status = docker inspect $Name --format '{{.State.Status}}' 2>$null
    if($status -eq 'running'){ return }
    Start-Sleep -Seconds 2
  }
  throw "Container $Name is not running after $TimeoutSec seconds"
}
