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

if ( -not ( Test-Path $profile )) {
    $profile_path = Split-Path -Parent $profile
    if ( -not ( Test-Path $profile_path )) {
        New-Item -ItemType directory -Path $profile_path
    }
    New-Item -ItemType file -Path $profile
}

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
