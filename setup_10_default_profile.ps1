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

# Get default user profile path
$default_userprofile = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name 'Default').Default

# Modify default startmenu and remove all tiles which will be downloaded later
$xml_path = Join-Path $default_userprofile 'AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml'
$xml = New-Object xml
$xml.PreserveWhitespace = $true
$xml.Load(xml_path)
$ns = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
$ns.AddNamespace("start", "http://schemas.microsoft.com/Start/2014/StartLayout")
$xml.SelectNodes("//start:SecondaryTile", $ns) | % { $_.ParentNode.RemoveChild($_) | Out-Null }
$xml.Save(xml_path)

# Easy HKU access
New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
# Load default user hive
reg load 'HKU\DEFAULT' (Join-Path $default_userprofile 'NTUSER.DAT')

$run_once_path_folder = Join-Path $env:PROGRAMDATA 'ab-projects'
if ( -not ( Test-Path $run_once_path_folder ) ) {
    New-Item $run_once_path_folder -ItemType Directory
}

$run_once_file = 'run_once.ps1'
$run_once_path_src = Join-Path $myParentDir $run_once_file
$run_once_path_dst = Join-Path $run_once_path_folder $run_once_file
Copy-Item -Path $run_once_path_src -Destination $run_once_path_dst -Force

$run_once = 'HKU:\DEFAULT\Software\Microsoft\Windows\CurrentVersion\RunOnce'
New-Item -Path $run_once -Force | Out-Null
New-ItemProperty -Path $run_once -Force -Name '!run_once' -Value "powershell -NoProfile -WindowStyle Hidden -File $run_once_path_dst"

# unload default user hive
[System.GC]::Collect()
reg unload 'HKU\DEFAULT'

Remove-PSDrive -Name HKU
