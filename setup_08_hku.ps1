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
    reg unload 'HKU\DEFAULT'
    Remove-PSDrive -Name HKU
    Set-Location $myExecDir | Out-Null
    $oldForegroundColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "Red"
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
    Write-Output "Create $Path\$PropertyName = $Value"
    if ( -not ( Test-Path $Path ) ) {
        New-Item -Path $Path -Force | Out-Null
    }
    New-ItemProperty -Path $Path -Name $PropertyName -PropertyType DWORD -Value $Value -Force | Out-Null
}

# Easy HKU access
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS

# Get default user profile path
$default_userprofile = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name 'Default').Default
# Load default user hive
reg load 'HKU\DEFAULT' (Join-Path $default_userprofile 'NTUSER.DAT')

Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' 'NoTileApplicationNotification' 1
Add-RegDWord 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' 'NoTileApplicationNotification' 1

Add-RegDWord 'HKU:\DEFAULT\Software\Microsoft\Personalization\Settings' 'AcceptedPrivacyPolicy' 0
Add-RegDWord 'HKCU:\Software\Microsoft\Personalization\Settings' 'AcceptedPrivacyPolicy' 0

Add-RegDWord 'HKU:\DEFAULT\Software\Microsoft\InputPersonalization\TrainedDataStore' 'HarvestContacts' 0
Add-RegDWord 'HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore' 'HarvestContacts' 0

Add-RegDWord 'HKU:\DEFAULT\Software\Microsoft\Siuf\Rules' 'PeriodInNanoSeconds' 0
Add-RegDWord 'HKCU:\Software\Microsoft\Siuf\Rules' 'PeriodInNanoSeconds' 0

Add-RegDWord 'HKU:\DEFAULT\Software\Microsoft\Siuf\Rules' 'NumberOfSIUFInPeriod' 0
Add-RegDWord 'HKCU:\Software\Microsoft\Siuf\Rules' 'NumberOfSIUFInPeriod' 0

Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Microsoft\Messaging' 'CloudServiceSyncEnabled' 0
Add-RegDWord 'HKCU:\SOFTWARE\Microsoft\Messaging' 'CloudServiceSyncEnabled' 0

Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Policies\Microsoft\Windows\CloudContent' 'DisableWindowsSpotlightFeatures' 1
Add-RegDWord 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' 'DisableWindowsSpotlightFeatures' 1

Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SystemPaneSuggestionsEnabled' 0
Add-RegDWord 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'SystemPaneSuggestionsEnabled' 0

Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'PreInstalledAppsEnabled' 0
Add-RegDWord 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'PreInstalledAppsEnabled' 0

Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'OemPreInstalledAppsEnabled' 0
Add-RegDWord 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' 'OemPreInstalledAppsEnabled' 0

# Privacy: Let apps use my advertising ID: Disable
Add-RegDWord "HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0
Add-RegDWord "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0

# Start Menu: Disable Bing Search Results
Add-RegDWord 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' 'BingSearchEnabled' 0
Add-RegDWord 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' 'BingSearchEnabled' 0

# These make "Quick Access" behave much closer to the old "Favorites"
$explorer_hku = "HKU:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer"
$explorer_hkcu = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
# Disable Quick Access: Recent Files
Add-RegDWord $explorer_hku 'ShowRecent' 0
Add-RegDWord $explorer_hkcu 'ShowRecent' 0
# Disable Quick Access: Frequent Folders
Add-RegDWord $explorer_hku 'ShowFrequent' 0
Add-RegDWord $explorer_hkcu 'ShowFrequent' 0

# Better File Explorer
$advanced_hku = Join-Path $explorer_hku "Advanced"
$advanced_hkcu = Join-Path $explorer_hkcu "Advanced"

Add-RegDWord $advanced_hku 'NavPaneExpandToCurrentFolder' 1
Add-RegDWord $advanced_hkcu 'NavPaneExpandToCurrentFolder' 1
Add-RegDWord $advanced_hku 'NavPaneShowAllFolders' 1
Add-RegDWord $advanced_hkcu 'NavPaneShowAllFolders' 1
Add-RegDWord $advanced_hku 'MMTaskbarMode' 2
Add-RegDWord $advanced_hkcu 'MMTaskbarMode' 2
# Change Explorer home screen back to "This PC"
Add-RegDWord $advanced_hku 'LaunchTo' 1
Add-RegDWord $advanced_hkcu 'LaunchTo' 1

# Disable Xbox Gamebar
Add-RegDWord "HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" 'AppCaptureEnabled' 0
Add-RegDWord "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" 'AppCaptureEnabled' 0

Add-RegDWord "HKU:\DEFAULT\System\GameConfigStore" 'GameDVR_Enabled' 0
Add-RegDWord "HKCU:\System\GameConfigStore" 'GameDVR_Enabled' 0

# Turn off People in Taskbar
Add-RegDWord "HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" 'PeopleBand' 0
Add-RegDWord "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" 'PeopleBand' 0

# unload default user hive
[System.GC]::Collect()
reg unload 'HKU\DEFAULT'

Remove-PSDrive -Name HKU
