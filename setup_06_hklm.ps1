#Requires -Version 3.0
# -*- coding: utf-8 -*-

param(
)

$ErrorActionPreference = 'Stop'

[string] $myName = $MyInvocation.MyCommand.Name
[string] $myParentDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
[string] $myExecDir = Get-Location

# Any throw comes through here
trap {
    Set-Location $myExecDir | Out-Null
    $oldForegroundColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = 'Red'
    $line = $_.InvocationInfo.ScriptLineNumber
    Write-Output "${myName}: ERROR: ${line}: $_"
    $host.ui.RawUI.ForegroundColor = $oldForegroundColor
    exit 1
}

function Add-RegDWord {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $Path,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $PropertyName,
        [Parameter(Mandatory=$false)]
        [int] $Value = 1
    )
    if ( -not ( Test-Path $Path ) ) {
        $Path
        New-Item -Path $Path -Force | Out-Null
    }
    New-ItemProperty -Path $Path -Name $PropertyName -PropertyType DWORD -Value $Value -Force
}

# Disable Live Tiles
Add-RegDWord 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications' 'NoCloudApplicationNotification'

# Disable Cortana
$s = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search'
Add-RegDWord $s 'AllowCortana' 1
Add-RegDWord $s 'AllowSearchToUseLocation' 0
Add-RegDWord $s 'ConnectedSearchPrivacy' 3
Add-RegDWord $s 'ConnectedSearchUseWeb' 0
Add-RegDWord $s 'DisableWebSearch' 1

# Disabling Microsoft Edge desktop icon creation
Add-RegDWord 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' 'DisableEdgeDesktopShortcutCreation'

# Disabling New Network Dialog
New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Network' -Name 'NewNetworkWindowOff' -Force

# Wifi sense
$wifi = 'HKLM:\Software\Microsoft\PolicyManager\default\WiFi'
# Disable HotSpot Sharing
Add-RegDWord (Join-Path $wifi 'AllowWiFiHotSpotReporting') 'value' 0
# Disable Shared HotSpot Auto-Connect
Add-RegDWord (Join-Path $wifi 'AllowAutoConnectToWiFiSenseHotspots') 'value' 0

# Disabling the Microsoft Account Sign-In Assistant
Add-RegDWord 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' 'NoConnectedUser' 3

$data = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
# Disable all feedback notifications
Add-RegDWord $data 'DoNotShowFeedbackNotifications'
# Disable telemetry (requires a reboot to take effect)
Add-RegDWord $data 'AllowTelemetry' 0

# Lock screen
$pers = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'
# Disable camera
Add-RegDWord $pers 'NoLockScreenCamera'
# Disable slideshow
Add-RegDWord $pers 'NoLockScreenSlideshow'
# No changes
Add-RegDWord $pers 'NoChangingLockScreen'

# Disable FindMyDevice
Add-RegDWord 'HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice' 'AllowFindMyDevice' 0

# Offline maps
$maps = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps'
# Turn off unsolicited network traffic on the Offline Maps settings page
Add-RegDWord $maps 'AllowUntriggeredNetworkTrafficOnSettingsPage' 0
# Turn off Automatic Download and Update of Map Data
Add-RegDWord $maps 'AutoDownloadAndUpdateMapData' 0

# App Privacy
$priv = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy'
Add-RegDWord $priv 'LetAppsAccessAccountInfo' 2
Add-RegDWord $priv 'LetAppsAccessLocation' 0
Add-RegDWord $priv 'LetAppsGetDiagnosticInfo' 2
Add-RegDWord $priv 'LetAppsSyncWithDevices' 2

# Location
$loc = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors'
Add-RegDWord $loc 'DisableLocation' 1
Add-RegDWord $loc 'DisableLocationScripting' 1

# Turn off the advertising ID
Add-RegDWord 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo' 'Enabled' 0

# Microsoft Edge
$edge = 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge'
# Configure Do Not Track
Add-RegDWord (Join-Path $edge 'Main') 'DoNotTrack'
# Configure Autofill
New-ItemProperty -Path (Join-Path $edge 'Main') -Name 'Use FormSuggest' -Value 'no' -Force
# Configure Password Manager
New-ItemProperty -Path (Join-Path $edge 'Main') -Name 'FormSuggest Passwords' -Value 'no' -Force
# Configure search suggestions in Address bar
Add-RegDWord (Join-Path $edge 'SearchScopes') 'ShowSearchSuggestionsGlobal' 0
# Allow web content on New Tab page
Add-RegDWord (Join-Path $edge 'SearchScopes') 'AllowWebContentOnNewTabPage' 0
# Configure corporate Home pages
Add-RegDWord (Join-Path $edge 'ServiceUI') 'ProvisionedHomePages' 0
