#Requires -Version 3.0
#Requires -RunAsAdministrator
# -*- coding: utf-8 -*-

param(
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

function Add-ToReg {
    param (
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $Path,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string] $PropertyName,
        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        $Value
    )
    Write-Output "Create $Path\$PropertyName = $Value"
    if ( -not ( Test-Path $Path ) ) {
        New-Item -Path $Path -Force | Out-Null
    }
    New-ItemProperty -Path $Path -Name $PropertyName -Value $Value -Force | Out-Null
}

# Main documentantion:
# https://docs.microsoft.com/en-us/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services#how-to-configure-each-setting

# Disable Cortana
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' 'AllowCortana' 0
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' 'AllowSearchToUseLocation' 0
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' 'DisableWebSearch' 1
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' 'ConnectedSearchUseWeb' 0
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' 'ConnectedSearchPrivacy' 3

# Disallow FindMyDevice
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\FindMyDevice' 'AllowFindMyDevice' 0

# Disable Live tiles
# Changed from HKCU (from docs above) to HKLM because it is derived from there for the user
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications' 'NoCloudApplicationNotification' 1

 # Disable the Microsoft Account Sign-In Assistant
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' 'NoConnectedUser' 3
# TODO: Make clearer this is a service stop and disable
Add-ToReg 'HKLM:\System\CurrentControlSet\Services' 'wlidsvc' 4 

# Microsoft Edge
# Allow Address Bar drop-down list suggestions
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\ServiceUI' 'ShowOneBox' 0
# Allow configuration updates for the Books Library
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\BooksLibrary' 'AllowConfigurationUpdateForBooksLibrary' 0
# Configure Autofill
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main' 'Use FormSuggest' 'no'
# Configure Do Not Track
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main' 'DoNotTrack' 1
# Configure Password Manager
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main' 'FormSuggest Passwords' 'no'
# Configure search suggestions in Address Bar
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\SearchScopes' 'ShowSearchSuggestionsGlobal' 0
# Allow web content on New Tab page
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\SearchScopes' 'AllowWebContentOnNewTabPage' 0
# Configure corporate Home pages
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\ServiceUI' 'ProvisionedHomePages' 0

# Disable Network Connection Status Indicator
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator' 'NoActiveProbe' 1

# Disable Offline maps
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps' 'AutoDownloadAndUpdateMapData' 0
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Maps' 'AllowUntriggeredNetworkTrafficOnSettingsPage' 0

# Disable OneDrive
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' 'DisableFileSyncNGSC' 1
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive' 'PreventNetworkTrafficPreUserSignIn' 1

# Disable advertising ID
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo' 'Enabled' 0

# Disable apps on my other devices open apps and continue experiences on this devices
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\System' 'EnableCdp' 0

# Disable location for this device
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\AppPrivacy' 'LetAppsAccessLocation' 2

# Disable location
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\LocationAndSensors' 'DisableLocation' 1

# Stop getting to know me
Add-ToReg 'HKLM:\Software\Policies\Microsoft\InputPersonalization' 'RestrictImplicitInkCollection' 1

# Apps access
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessAccountInfo' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessCalendar' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessCallHistory' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessContacts' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessEmail' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessMessaging' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessMotion' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessPhone' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsAccessRadios' 2
Add-ToReg 'HKLM:\SOFTWARE\Microsoft\Windows\AppPrivacy' 'LetAppsSyncWithDevices' 2

# Feedback frequency
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection' 'DoNotShowFeedbackNotifications' 1

# Disable telemetry
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection' 'AllowTelemetry' 0

# Disable sync your settings
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\SettingSync' 'DisableSettingSync' 2 
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows\SettingSync' 'DisableSettingSyncUserOverride' 1

# Disable sending file samples back to Microsoft
Add-ToReg 'HKLM:\Software\Policies\Microsoft\Windows Defender\Spynet' 'SubmitSamplesConsent' 2

# Use BITS for Windows Updates instead of P2P 
Add-ToReg 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization' 'DODownloadMode' 100
