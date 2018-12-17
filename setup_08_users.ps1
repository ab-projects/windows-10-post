#Requires -Version 3.0
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

# Easy HKU access
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS

# Get default user profile path
$default_userprofile = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" -Name Default).Default
# Load default user hive
reg load 'HKU\DEFAULT' (Join-Path $default_userprofile 'NTUSER.DAT')

New-ItemProperty -Path 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'PreInstalledAppsEnabled' -Value 0 -Force
New-ItemProperty -Path 'HKU:\DEFAULT\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'OemPreInstalledAppsEnabled' -Value 0 -Force

# unload default user hive
reg unload 'HKU\DEFAULT'
Remove-PSDrive -Name HKU

# Privacy: Let apps use my advertising ID: Disable
$adv_info = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo"
if ( -not ( Test-Path $adv_info ) ) {
    New-Item -Path $adv_info | Out-Null
}
Set-ItemProperty -Path $adv_info -Name Enabled -Type DWORD -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWORD -Value 0

# These make "Quick Access" behave much closer to the old "Favorites"
$exp = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer"
# Disable Quick Access: Recent Files
Set-ItemProperty -Path $exp -Name ShowRecent -Type DWORD -Value 0
# Disable Quick Access: Frequent Folders
Set-ItemProperty -Path $exp -Name ShowFrequent -Type DWORD -Value 0

# Better File Explorer
$exp_adv = Join-Path $exp "Advanced"
if ( -not ( Test-Path $exp_adv ) ) {
    New-Item -Path $exp_adv | Out-Null
}
Set-ItemProperty -Path $exp_adv -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path $exp_adv -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path $exp_adv -Name MMTaskbarMode -Value 2

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWORD -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWORD -Value 0

# Turn off People in Taskbar
$people = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People"
if ( -not ( Test-Path $people ) ) {
    New-Item -Path $people | Out-Null
}
Set-ItemProperty -Path $people -Name PeopleBand -Type DWORD -Value 0

Remove-Item -Recurse -Force $env:USERPROFILE"\3D Objects"
