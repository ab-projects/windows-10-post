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
    "Microsoft.3DBuilder*",
    "Microsoft.BingWeather*",
    "Microsoft.GetHelp*",
    "Microsoft.Getstarted*",
    "Microsoft.Messaging*",
    "Microsoft.Microsoft3DViewer*",
    "Microsoft.MicrosoftOfficeHub*",
    "Microsoft.MicrosoftSolitaireCollection*",
    "Microsoft.MixedReality.Portal*",
    "Microsoft.Office.OneNote*",
    "Microsoft.OneConnect*",
    "Microsoft.People*",
    "Microsoft.Print3D*",
    "Microsoft.Services.Store.Engagement*",
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
    "microsoft.windowscommunicationsapps*",
    "4DF9E0F8.Netflix*",
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
