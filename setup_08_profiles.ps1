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

# Get default user profile path
$default_userprofile = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name 'Default').Default

# TODO: do this for default user profile too 
Remove-Item -Recurse -Force (Join-Path $env:USERPROFILE '3D Objects')
Remove-Item -Recurse -Force (Join-Path $default_userprofile '3D Objects')

Remove-Item -Force (Join-Path $env:USERPROFILE 'Desktop\Microsoft Edge.lnk')
Remove-Item -Force (Join-Path $default_userprofile 'Desktop\Microsoft Edge.lnk')


#C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\DefaultLayouts.xml

# <start:SecondaryTile
#     AppUserModelID="Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy!App"
#     TileID="PreInstalled.DefaultStartLayout2.1"
#     Arguments="creative-ms:default?p=DefaultStartLayout2&launch=ms-get-started://redirect%3Fid=placeholdertiles"
#     IsSuggestedApp="true"
#     <!-- … -->
# />



# TODO: remove the dynamic tiles from startmenue
#New-Item "C:\temp" -Type Directory
#Export-StartLayout -Path "C:\temp\DefaultLayout.xml"
# Delete the files manually please.
#Import-StartLayout -LayoutPath "C:\temp\DefaultLayout.xml" -MountPath "C:\"
