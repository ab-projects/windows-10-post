#Requires -Version 3.0
#Requires -RunAsAdministrator
# -*- coding: utf-8 -*-

param(
    # Name the new PC
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string] $Computername
)

$ErrorActionPreference = "Stop"

[string] $myName = $MyInvocation.MyCommand.Name
[string] $myParentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
[string] $myExecDir = Get-Location

# Any throw comes through here
trap {
    Set-Location $myExecDir | Out-Null
    $oldForegroundColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "Red"
    $line = $_.InvocationInfo.ScriptLineNumber
    Write-Output "${myName}: ERROR: ${line}: $_"
    $host.ui.RawUI.ForegroundColor = $oldForegroundColor
    exit 1
}

# Completely uninstall OneDrive
taskkill /f /im OneDrive.exe
$one_drive_setup = Join-Path $env:SystemRoot "SysWOW64\OneDriveSetup.exe"
if ( Test-Path $one_drive_setup ) {
    & $one_drive_setup /uninstall
}

# Disable some services
# Telemetry
Get-Service DiagTrack, Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled
# Microsoft Account Sign-in Assistant
Get-Service wlidsvc | Stop-Service | Set-Service -StartupType Disabled
# Windows Error Reporting Service
Get-Service WerSvc | Stop-Service | Set-Service -StartupType Disabled
# Xbox Live Auth Manager
Get-Service XblAuthManager | Stop-Service | Set-Service -StartupType Disabled
# Xbox Live Game Save
Get-Service XblGameSave | Stop-Service | Set-Service -StartupType Disabled
# Xbox Live Networking Service
Get-Service XboxNetApiSvc | Stop-Service | Set-Service -StartupType Disabled
# Xbox Accessory Management
Get-Service XboxGipSvc | Stop-Service | Set-Service -StartupType Disabled

# Unregister some scheduled tasks
Get-ScheduledTask -TaskPath '\Microsoft\XblGameSave\' -TaskName 'XblGameSaveTask' | Unregister-ScheduledTask -Confirm:$false

# Delete some scheduled tasks folders
$ssO = New-Object -ComObject schedule.service
$ssO.connect()
try {
    $ssO.GetFolder("\Microsoft").DeleteFolder("XblGameSave", $null)
} catch [System.IO.FileNotFoundException] {
    # do nothing
}

# Disable some scheduled tasks
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\ProgramDataUpdater"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Application Experience\StartupAppTask"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Autochk\Proxy"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\CloudExperienceHost\CreateObjectTask"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticResolver"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Feedback\Siuf\DmClient"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Maps\MapsToastTask"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Maps\MapsUpdateTask"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyMonitor"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Shell\FamilySafetyRefreshTask"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\WDI\ResolutionHost"
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Windows Error Reporting\QueueReporting"

#--- Rename the Computer ---
# Requires restart, or add the -Restart flag
if ( $env:computername -ne $Computername ) {
    Rename-Computer -NewName $Computername
}
