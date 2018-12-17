#Requires -Version 3.0
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

# TODO: Test this

# Completely uninstall OneDrive
taskkill /f /im OneDrive.exe
$one_drive_setup = Join-Path $env:SystemRoot "SysWOW64\OneDriveSetup.exe"
if ( Test-Path $one_drive_setup ) {
    & $one_drive_setup /uninstall
}

$consumer_features = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent'
if ( -not ( Test-Path $consumer_features ) ) {
    New-Item -Path $consumer_features | Out-Null
}
New-ItemProperty -Path $consumer_features -Name DisableWindowsConsumerFeatures -PropertyType DWORD -Value '1' -Force

# Disabling Microsoft Edge desktop icon creation
$exp = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer'
New-ItemProperty -Path $exp -Name 'Explorer' -PropertyType DWORD -Value '1' -Force
New-ItemProperty -Path $exp -Name 'DisableEdgeDesktopShortcutCreation' -PropertyType DWORD -Value '1' -Force

# Disabling New Network Dialog
New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Network' -Name 'NewNetworkWindowOff' -Force

# WiFi Sense: HotSpot Sharing: Disable
$wifi_sense = "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting"
if ( -not ( Test-Path $wifi_sense ) ) {
    New-Item -Path $wifi_sense | Out-Null
}
Set-ItemProperty -Path $wifi_sense -Name value -Type DWORD -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name value -Type DWORD -Value 0

# Disable all feedback notifications
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name DoNotShowFeedbackNotifications -PropertyType DWORD -Value '1' -Force

# Disable telemetry (requires a reboot to take effect)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name AllowTelemetry -Type DWORD -Value 0
Get-Service DiagTrack, Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# Disable some services
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
Disable-ScheduledTask -TaskName "\Microsoft\Windows\Windows Media Sharing\UpdateLibrary"

#--- Rename the Computer ---
# Requires restart, or add the -Restart flag
if ( $env:computername -ne $Computername ) {
    Rename-Computer -NewName $Computername
}
