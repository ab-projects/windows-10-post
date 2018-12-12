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

$to_disable = @(
    "App.Support.QuickAssist~~~~0.0.1.0",
    "Browser.InternetExplorer~~~~0.0.11.0",
    "Hello.Face.17658~~~~0.0.1.0",
    "Hello.Face.Migration.17658~~~~0.0.1.0",
    "Media.WindowsMediaPlayer~~~~0.0.12.0"
)
foreach ($capability in $to_disable) {
    if ( (Get-WindowsCapability -Name $capability -Online).Name -ne $capability ) {
        throw "Can't find '${capability}'"
    }
    Write-Output "Removing Windows Capability '${capability}'"
    Remove-WindowsCapability -Name $capability -Online
}

$to_enable = @(
)
foreach ($capability in $to_enable) {
    Write-Output "Adding Windows Capability '${capability}'"
    Add-WindowsCapability -Name $capability -Online
}
