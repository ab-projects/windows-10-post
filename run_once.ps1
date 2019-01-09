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

$three_d_obj = Join-Path $env:USERPROFILE '3D Objects'
if ( Test-Path $three_d_obj ) {
    Remove-Item -Recurse -Force $three_d_obj
}

$desktop_edge_lnk = Join-Path $env:USERPROFILE 'Desktop\Microsoft Edge.lnk'
if ( Test-Path $desktop_edge_lnk ) {
    Remove-Item -Recurse -Force $desktop_edge_lnk
}
