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

# system level
choco install -y vcredist-all

# tools level
# sysinternals installation needs to be done on a safe path
Set-Location C:\ | Out-Null
choco install -y sysinternals
Set-Location $myExecDir | Out-Null
choco install -y 7zip

# apps level
choco install -y googlechrome
choco install -y git --params '"/GitAndUnixToolsOnPath /WindowsTerminal /NoAutoCrlf /NoShellIntegration /SChannel /NoCredentialManager"'
