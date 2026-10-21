@'
param(
  [Parameter(Mandatory)][string]$Action,
  [string[]]$VMs
)
$vbm = $env:ProgramFiles + '/Oracle/VirtualBox/VBoxManage.exe'

foreach ($vm in $VMs) {
  switch ($Action) {
    'start'  { & $vbm startvm $vm --type headless }
    'gui'    { & $vbm startvm $vm }
    'stop'   { & $vbm controlvm $vm acpipowerbutton }
    'kill'   { & $vbm controlvm $vm poweroff }
    'snap'   { & $vbm snapshot $vm take ('snap-' + (Get-Date -Format 'yyyyMMdd-HHmm')) }
    'revert' { & $vbm snapshot $vm restorecurrent }
    default  { Write-Host 'Use: start | gui | stop | kill | snap | revert' }
  }
}
Write-Host 'Running VMs:'
& $vbm list runningvms
'@ | Set-Content C:/VMLab/scripts/lab.ps1