#Requires -Version 3.0
# -*- coding: utf-8 -*-

param(
    # Name the new PC
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string] $Computername
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

#--- Windows Settings ---
#Disable-BingSearch
#Disable-GameBarTips

#Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowFileExtensions
#Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock
#Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -AlwaysShowIconsOn

#--- Windows Subsystems/Features ---
#choco install Microsoft-Hyper-V-All -source windowsFeatures
#choco install Microsoft-Windows-Subsystem-Linux -source windowsfeatures

choco install -y vcredist-all

#--- Tools ---
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'
choco install -y sysinternals -y
choco install -y vim
choco install -y notepadplusplus

#--- Apps ---
choco install -y googlechrome

#--- Uninstall unecessary applications that come with Windows out of the box ---

#
# PS C:\Users\nballmann\workspaces\ab-projects\windows-10-post> Get-AppxPackage | select name, packagefullname

# Name                                        PackageFullName
# ----                                        ---------------
# Microsoft.Windows.CloudExperienceHost       Microsoft.Windows.CloudExperienceHost_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.AAD.BrokerPlugin                  Microsoft.AAD.BrokerPlugin_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.ShellExperienceHost       Microsoft.Windows.ShellExperienceHost_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# windows.immersivecontrolpanel               windows.immersivecontrolpanel_10.0.2.1000_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.Cortana                   Microsoft.Windows.Cortana_1.11.5.17763_neutral_neutral_cw5n1h2txyewy
# Microsoft.MicrosoftEdge                     Microsoft.MicrosoftEdge_44.17763.1.0_neutral__8wekyb3d8bbwe
# Microsoft.Windows.ContentDeliveryManager    Microsoft.Windows.ContentDeliveryManager_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.WindowsCamera                     Microsoft.WindowsCamera_2018.824.60.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.1.7          Microsoft.NET.Native.Framework.1.7_1.7.25531.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.1.7          Microsoft.NET.Native.Framework.1.7_1.7.25531.0_x86__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.1.7            Microsoft.NET.Native.Runtime.1.7_1.7.25531.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.1.7            Microsoft.NET.Native.Runtime.1.7_1.7.25531.0_x86__8wekyb3d8bbwe
# Microsoft.VCLibs.140.00                     Microsoft.VCLibs.140.00_14.0.26706.0_x64__8wekyb3d8bbwe
# Microsoft.VCLibs.140.00                     Microsoft.VCLibs.140.00_14.0.26706.0_x86__8wekyb3d8bbwe
# Microsoft.WindowsStore                      Microsoft.WindowsStore_11810.1001.12.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.1.6          Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.1.6          Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x86__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.1.6            Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.1.6            Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe
# Microsoft.StorePurchaseApp                  Microsoft.StorePurchaseApp_11810.1001.10.0_x64__8wekyb3d8bbwe
# Microsoft.MixedReality.Portal               Microsoft.MixedReality.Portal_2000.18100.1171.0_x64__8wekyb3d8bbwe
# Microsoft.GetHelp                           Microsoft.GetHelp_10.1706.12921.0_x64__8wekyb3d8bbwe
# Microsoft.WebMediaExtensions                Microsoft.WebMediaExtensions_1.0.12902.0_x64__8wekyb3d8bbwe
# Microsoft.XboxGamingOverlay                 Microsoft.XboxGamingOverlay_2.22.11001.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.2.2          Microsoft.NET.Native.Framework.2.2_2.2.27011.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.2.2          Microsoft.NET.Native.Framework.2.2_2.2.27011.0_x86__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.2.2            Microsoft.NET.Native.Runtime.2.2_2.2.27011.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.2.2            Microsoft.NET.Native.Runtime.2.2_2.2.27011.0_x86__8wekyb3d8bbwe
# Microsoft.WindowsSoundRecorder              Microsoft.WindowsSoundRecorder_10.1809.2731.0_x64__8wekyb3d8bbwe
# Microsoft.ScreenSketch                      Microsoft.ScreenSketch_10.1809.2964.0_x64__8wekyb3d8bbwe
# Microsoft.YourPhone                         Microsoft.YourPhone_1.0.13402.0_x64__8wekyb3d8bbwe
# Microsoft.XboxGameOverlay                   Microsoft.XboxGameOverlay_1.36.7001.0_x64__8wekyb3d8bbwe
# Microsoft.Services.Store.Engagement         Microsoft.Services.Store.Engagement_10.0.18101.0_x86__8wekyb3d8bbwe
# Microsoft.Services.Store.Engagement         Microsoft.Services.Store.Engagement_10.0.18101.0_x64__8wekyb3d8bbwe
# Microsoft.UI.Xaml.2.0                       Microsoft.UI.Xaml.2.0_2.1810.18003.0_x64__8wekyb3d8bbwe
# Microsoft.UI.Xaml.2.0                       Microsoft.UI.Xaml.2.0_2.1810.18003.0_x86__8wekyb3d8bbwe
# Microsoft.WindowsCalculator                 Microsoft.WindowsCalculator_10.1811.3241.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.2.1          Microsoft.NET.Native.Framework.2.1_2.1.26424.0_x86__8wekyb3d8bbwe
# Microsoft.NET.Native.Framework.2.1          Microsoft.NET.Native.Framework.2.1_2.1.26424.0_x64__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.2.1            Microsoft.NET.Native.Runtime.2.1_2.1.26424.0_x86__8wekyb3d8bbwe
# Microsoft.NET.Native.Runtime.2.1            Microsoft.NET.Native.Runtime.2.1_2.1.26424.0_x64__8wekyb3d8bbwe
# Microsoft.VCLibs.140.00.UWPDesktop          Microsoft.VCLibs.140.00.UWPDesktop_14.0.26905.0_x64__8wekyb3d8bbwe
# Microsoft.VCLibs.140.00.UWPDesktop          Microsoft.VCLibs.140.00.UWPDesktop_14.0.26905.0_x86__8wekyb3d8bbwe
# Microsoft.MicrosoftStickyNotes              Microsoft.MicrosoftStickyNotes_3.1.46.0_x64__8wekyb3d8bbwe
# Microsoft.XboxSpeechToTextOverlay           Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_x64__8wekyb3d8bbwe
# Microsoft.Print3D                           Microsoft.Print3D_3.1.2612.0_x64__8wekyb3d8bbwe
# Microsoft.Xbox.TCUI                         Microsoft.Xbox.TCUI_1.11.29001.0_x64__8wekyb3d8bbwe
# Windows.PrintDialog                         Windows.PrintDialog_6.2.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.XboxGameCallableUI                Microsoft.XboxGameCallableUI_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.SecureAssessmentBrowser   Microsoft.Windows.SecureAssessmentBrowser_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Windows.CBSPreview                          Windows.CBSPreview_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.XGpuEjectDialog           Microsoft.Windows.XGpuEjectDialog_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.SecHealthUI               Microsoft.Windows.SecHealthUI_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.Windows.PinningConfirmationDialog Microsoft.Windows.PinningConfirmationDialog_1000.17763.1.0_neutral__cw5n1h2txyewy
# Microsoft.Windows.PeopleExperienceHost      Microsoft.Windows.PeopleExperienceHost_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.ParentalControls          Microsoft.Windows.ParentalControls_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.OOBENetworkConnectionFlow Microsoft.Windows.OOBENetworkConnectionFlow_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.Windows.OOBENetworkCaptivePortal  Microsoft.Windows.OOBENetworkCaptivePortal_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.PPIProjection                     Microsoft.PPIProjection_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.Apprep.ChxApp             Microsoft.Windows.Apprep.ChxApp_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.Windows.CapturePicker             Microsoft.Windows.CapturePicker_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.Windows.NarratorQuickStart        Microsoft.Windows.NarratorQuickStart_10.0.17763.1_neutral_neutral_8wekyb3d8bbwe
# 1527c705-839a-4832-9118-54d4Bd6a0c89        1527c705-839a-4832-9118-54d4Bd6a0c89_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.Win32WebViewHost                  Microsoft.Win32WebViewHost_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# Microsoft.MicrosoftEdgeDevToolsClient       Microsoft.MicrosoftEdgeDevToolsClient_1000.17763.1.0_neutral_neutral_8wekyb3d8bbwe
# Microsoft.LockApp                           Microsoft.LockApp_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.AsyncTextService                  Microsoft.AsyncTextService_10.0.17763.1_neutral__8wekyb3d8bbwe
# c5e2524a-ea46-4f67-841f-6a9465d9d515        c5e2524a-ea46-4f67-841f-6a9465d9d515_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# E2A4F912-2574-4A75-9BB0-0D023378592B        E2A4F912-2574-4A75-9BB0-0D023378592B_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE        F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE_10.0.17763.1_neutral_neutral_cw5n1h2txyewy
# InputApp                                    InputApp_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.AccountsControl                   Microsoft.AccountsControl_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.Windows.AssignedAccessLockApp     Microsoft.Windows.AssignedAccessLockApp_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy
# Microsoft.ECApp                             Microsoft.ECApp_10.0.17763.1_neutral__8wekyb3d8bbwe
# Microsoft.CredDialogHost                    Microsoft.CredDialogHost_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.BioEnrollment                     Microsoft.BioEnrollment_10.0.17763.1_neutral__cw5n1h2txyewy
# Microsoft.VP9VideoExtensions                Microsoft.VP9VideoExtensions_1.0.12962.0_x64__8wekyb3d8bbwe
# Microsoft.WebpImageExtension                Microsoft.WebpImageExtension_1.0.12821.0_x64__8wekyb3d8bbwe
# Microsoft.Wallet                            Microsoft.Wallet_2.2.18179.0_x64__8wekyb3d8bbwe
# Microsoft.MSPaint                           Microsoft.MSPaint_5.1811.20017.0_x64__8wekyb3d8bbwe
# Microsoft.Microsoft3DViewer                 Microsoft.Microsoft3DViewer_5.1811.27012.0_x64__8wekyb3d8bbwe
# Microsoft.HEIFImageExtension                Microsoft.HEIFImageExtension_1.0.12812.0_x64__8wekyb3d8bbwe
# Microsoft.DesktopAppInstaller               Microsoft.DesktopAppInstaller_1.0.22011.0_x64__8wekyb3d8bbwe
# Microsoft.LanguageExperiencePackde-DE       Microsoft.LanguageExperiencePackde-DE_17763.7.11.0_neutral__8wekyb3d8bbwe
#

# 3D Builder
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage

# Alarms
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage

# Autodesk
Get-AppxPackage *Autodesk* | Remove-AppxPackage

# Bing Weather, News, Sports, and Finance (Money):
Get-AppxPackage Microsoft.BingFinance | Remove-AppxPackage
Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
Get-AppxPackage Microsoft.BingSports | Remove-AppxPackage
Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage

# BubbleWitch
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage

# Candy Crush
Get-AppxPackage king.com.CandyCrush* | Remove-AppxPackage

# Comms Phone
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage

# Dell
Get-AppxPackage *Dell* | Remove-AppxPackage

# Dropbox
Get-AppxPackage *Dropbox* | Remove-AppxPackage

# Facebook
Get-AppxPackage *Facebook* | Remove-AppxPackage

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# Get Started
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage

# Keeper
Get-AppxPackage *Keeper* | Remove-AppxPackage

# Mail & Calendar
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage

# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage

# March of Empires
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage

# McAfee Security
Get-AppxPackage *McAfee* | Remove-AppxPackage

# Uninstall McAfee Security App
$mcafee = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "McAfee Security" } | select UninstallString
if ($mcafee) {
	$mcafee = $mcafee.UninstallString -Replace "C:\Program Files\McAfee\MSC\mcuihost.exe",""
	Write "Uninstalling McAfee..."
	start-process "C:\Program Files\McAfee\MSC\mcuihost.exe" -arg "$mcafee" -Wait
}

# Messaging
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage

# Minecraft
Get-AppxPackage *Minecraft* | Remove-AppxPackage

# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage

# Office Hub
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage

# One Connect
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage

# OneNote
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage

# People
Get-AppxPackage Microsoft.People | Remove-AppxPackage

# Phone
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage

# Photos
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage

# Plex
Get-AppxPackage *Plex* | Remove-AppxPackage

# Skype (Metro version)
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage

# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage

# Sway
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage

# Twitter
Get-AppxPackage *Twitter* | Remove-AppxPackage

# Xbox
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage

# Zune Music, Movies & TV
Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage

# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# WiFi Sense: HotSpot Sharing: Disable
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Disable Telemetry (requires a reboot to take effect)
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# Better File Explorer
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1		
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1		
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

# These make "Quick Access" behave much closer to the old "Favorites"
# Disable Quick Access: Recent Files
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 0
# Disable Quick Access: Frequent Folders
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 0

# Lock screen (not sleep) on lid close
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 1

# Disable Xbox Gamebar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" -Name AppCaptureEnabled -Type DWord -Value 0
Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name GameDVR_Enabled -Type DWord -Value 0

# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

#--- Restore Temporary Settings ---
#Enable-MicrosoftUpdate
#Install-WindowsUpdate -acceptEula

#--- Rename the Computer ---
# Requires restart, or add the -Restart flag
if ($env:computername -ne $Computername) {
	Rename-Computer -NewName $Computername
}
