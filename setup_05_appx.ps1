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

# Main documentantion:
# https://docs.microsoft.com/en-US/windows/application-management/apps-in-windows-10

# order matters because of dependencies
$to_remove = @(
    "*.FitbitCoach",
    "*.Minecraft*"
    "*.Netflix*",
    "*.PhototasticCollage*",
    "*.Twitter*",
    "*.XING*",
    "Microsoft.3DBuilder*",
    "Microsoft.BingFinance*",
    "Microsoft.BingNews*",
    "Microsoft.BingSports*",
    "Microsoft.BingWeather*",
    "Microsoft.GetHelp*",
    "Microsoft.Getstarted*",
    "Microsoft.Messaging*",
    "Microsoft.Microsoft3DViewer*",
    "Microsoft.MicrosoftOfficeHub*",
    "Microsoft.MicrosoftSolitaireCollection*",
    "Microsoft.MixedReality.Portal*",
    "Microsoft.Office.OneNote*",
    "Microsoft.Office.Sway*",
    "Microsoft.OneConnect*",
    "Microsoft.People*",
    "Microsoft.Print3D*",
    "Microsoft.SkypeApp*",
    "Microsoft.Wallet*",
    "Microsoft.WindowsFeedbackHub*",
    "Microsoft.WindowsMaps*",
    "Microsoft.WindowsSoundRecorder*",
    "Microsoft.Xbox.TCUI*",
    "Microsoft.XboxApp*",
    "Microsoft.XboxGameOverlay*",
    "Microsoft.XboxGamingOverlay*",
    "Microsoft.XboxIdentityProvider*",
    "Microsoft.XboxSpeechToTextOverlay*",
    "Microsoft.YourPhone*",
    "Microsoft.ZuneMusic*",
    "Microsoft.ZuneVideo*",
    "king.com.*",
    "microsoft.windowscommunicationsapps*",
    "Microsoft.Advertising.Xaml*"
)

foreach ($appx_package_glob in $to_remove) {
    Write-Output "Removing Appx packages based on glob '${appx_package_glob}'"

    # Removing provisioning for new users
    $provision_appx_packages = Get-AppxProvisionedPackage -Online | ? { $_.PackageName -like $appx_package_glob } 
    Write-Output "Removing provisioning of Appx packages:"
    foreach ($pkg in $provision_appx_packages) {
        $name = $pkg.PackageName
        Write-Output "* $name"
    }
    $provision_appx_packages | Remove-AppxProvisionedPackage -Online

    # Remove package for all users
    $appx_packages = Get-AppxPackage -AllUsers $appx_package_glob
    Write-Output "Removing of Appx packages:"
    foreach ($pkg in $appx_packages) {
        $name = $pkg.PackageFullName
        Write-Output "* $name"
    }
    $appx_packages | Remove-AppxPackage
}

$to_add = @(
    "Microsoft.DesktopAppInstaller*",
    "Microsoft.HEIFImageExtension*",
    "Microsoft.MSPaint*",
    "Microsoft.MicrosoftStickyNotes*",
    "Microsoft.ScreenSketch*",
    "Microsoft.StorePurchaseApp*",
    "Microsoft.VP9VideoExtensions*",
    "Microsoft.WebMediaExtensions*",
    "Microsoft.WebpImageExtension*",
    "Microsoft.Windows.Photos*",
    "Microsoft.WindowsAlarms*",
    "Microsoft.WindowsCalculator*",
    "Microsoft.WindowsCamera*",
    "Microsoft.WindowsStore*"
)

foreach ($appx_package_glob in $to_add) {
    if ((Get-AppxPackage -AllUsers $appx_package_glob).Name -notlike $appx_package_glob) {
        throw "Can't find '${appx_package_glob}'"
    }
    Write-Output "Confirmed '${appx_package_glob}' is available"
}
