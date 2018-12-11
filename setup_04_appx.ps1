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
    $oldForegroundColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "Red"
    $line = $_.InvocationInfo.ScriptLineNumber
    Write-Output "${myName}: ERROR: ${line}: $_"
    $host.ui.RawUI.ForegroundColor = $oldForegroundColor
    exit 1
}

# Main documentantion:
# https://docs.microsoft.com/en-US/windows/application-management/apps-in-windows-10

# Prevent online provisioned AppxPackages from re-downloading themselves after uninstallation

Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.BingWeather*" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.GetHelp" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.Getstarted" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.HEIFImageExtension" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.Messaging" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.MicrosoftOfficeHub" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.MicrosoftSolitaireCollection" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.MixedReality.Portal" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.Office.OneNote" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.OneConnect" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.People" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.Print3D" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.ScreenSketch" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.SkypeApp" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.VP9VideoExtensions" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.Wallet*" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.WebMediaExtensions" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.WebpImageExtension" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.WindowsMaps" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.WindowsSoundRecorder" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.Xbox.TCUI" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.XboxApp" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.XboxGameOverlay" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.XboxGamingOverlay" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.XboxIdentityProvider" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.XboxSpeechToTextOverlay" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.YourPhone" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.ZuneMusic" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.ZuneVideo" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "microsoft.windowscommunicationsapps" } | Remove-AppxProvisionedPackage -Online

# Actually uninstall the AppxPackages (order matters because of dependencies)

Get-AppxPackage -AllUsers "Microsoft.BingWeather*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftSolitaireCollection*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "microsoft.windowscommunicationsapps*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Advertising.Xaml*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.GetHelp*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Getstarted*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.HEIFImageExtension*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Messaging*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MicrosoftOfficeHub*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.MixedReality.Portal*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Office.OneNote*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.OneConnect*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.People*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Print3D*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ScreenSketch*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Services.Store.Engagement*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Services.Store.Engagement*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.SkypeApp*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.VP9VideoExtensions*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Wallet*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WebMediaExtensions*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WebpImageExtension*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsMaps*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.WindowsSoundRecorder*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.Xbox.TCUI*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.XboxApp*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.XboxGameOverlay*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.XboxGamingOverlay*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.XboxIdentityProvider*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.XboxSpeechToTextOverlay*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.YourPhone*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ZuneMusic*" | Remove-AppxPackage
Get-AppxPackage -AllUsers "Microsoft.ZuneVideo*" | Remove-AppxPackage
