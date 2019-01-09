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

# Load xml and preserve whitespace
$xml = New-Object xml
$xml.PreserveWhitespace = $true
$xml.Load(xml_path)

# Add namespace to be able to xmlpath for namespaced elements
$ns = New-Object System.Xml.XmlNamespaceManager($xml.NameTable)
$ns.AddNamespace("start", "http://schemas.microsoft.com/Start/2014/StartLayout")

# Find the tiles and remove them
$xml.SelectNodes("//start:SecondaryTile", $ns) | % { $_.ParentNode.RemoveChild($_) | Out-Null }

# Save xml back
$xml.Save(xml_path)
