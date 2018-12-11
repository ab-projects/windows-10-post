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

# Fix online provisioned apps
# https://docs.microsoft.com/en-US/windows/application-management/apps-in-windows-10#provisioned-windows-apps
# Prevent specific apps from re-downloading themselves after uninstallation

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
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.WebMediaExtensions" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "Microsoft.WebpImageExtension" } | Remove-AppxProvisionedPackage -Online
Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like "microsoft.windowscommunicationsapps" } | Remove-AppxProvisionedPackage -Online
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
