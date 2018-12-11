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
    $oldForegroundColor = $host.ui.RawUI.ForegroundColor
    $host.ui.RawUI.ForegroundColor = "Red"
    $line = $_.InvocationInfo.ScriptLineNumber
    Write-Output "${myName}: ERROR: ${line}: $_"
    $host.ui.RawUI.ForegroundColor = $oldForegroundColor
    exit 1
}

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

Get-AppxPackage *3dbuilder* | Remove-AppxPackage
Get-AppxPackage *Appconnector* | Remove-AppxPackage
Get-AppxPackage *Autodesk* | Remove-AppxPackage
Get-AppxPackage *BubbleWitch* | Remove-AppxPackage
Get-AppxPackage *CommsPhone* | Remove-AppxPackage
Get-AppxPackage *ConnectivityStore* | Remove-AppxPackage
Get-AppxPackage *Dell* | Remove-AppxPackage
Get-AppxPackage *Dropbox* | Remove-AppxPackage
Get-AppxPackage *Facebook* | Remove-AppxPackage
Get-AppxPackage *Asphalt8Airborne* | Remove-AppxPackage
Get-AppxPackage *Keeper* | Remove-AppxPackage
Get-AppxPackage *MarchofEmpires* | Remove-AppxPackage
Get-AppxPackage *McAfee* | Remove-AppxPackage
Get-AppxPackage *Messaging* | Remove-AppxPackage
Get-AppxPackage *MicrosoftStickyNotes* | Remove-AppxPackage
Get-AppxPackage *Minecraft* | Remove-AppxPackage
Get-AppxPackage *Netflix* | Remove-AppxPackage
Get-AppxPackage *Office.Sway* | Remove-AppxPackage
Get-AppxPackage *OneConnect* | Remove-AppxPackage
Get-AppxPackage *Plex* | Remove-AppxPackage
Get-AppxPackage *Reader* | Remove-AppxPackage
Get-AppxPackage *Solitaire* | Remove-AppxPackage
Get-AppxPackage *StorePurchaseApp* | Remove-AppxPackage
Get-AppxPackage *TuneInRadio* | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage *WindowsFeedbackHub* | Remove-AppxPackage
Get-AppxPackage *bingfinance* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *bingsports* | Remove-AppxPackage
Get-AppxPackage *bingweather* | Remove-AppxPackage
Get-AppxPackage *getstarted* | Remove-AppxPackage
Get-AppxPackage *king.com.* | Remove-AppxPackage
Get-AppxPackage *officehub* | Remove-AppxPackage
Get-AppxPackage *onenote* | Remove-AppxPackage
#Get-AppxPackage *people* | Remove-AppxPackage
Get-AppxPackage *skypeapp* | Remove-AppxPackage
Get-AppxPackage *solitairecollection* | Remove-AppxPackage
Get-AppxPackage *soundrecorder* | Remove-AppxPackage
Get-AppxPackage *windowsalarms* | Remove-AppxPackage
Get-AppxPackage *windowscamera* | Remove-AppxPackage
Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
Get-AppxPackage *windowsmaps* | Remove-AppxPackage
Get-AppxPackage *windowsphone* | Remove-AppxPackage
Get-AppxPackage *windowsstore* | Remove-AppxPackage
#Get-AppxPackage *xbox* | Remove-AppxPackage
Get-AppxPackage *zunemusic* | Remove-AppxPackage
Get-AppxPackage *zunevideo* | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage

# See Remove default Apps from Windows 10 https://thomas.vanhoutte.be/miniblog/delete-windows-10-apps/
# See Debloat Windows 10 https://github.com/W4RH4WK/Debloat-Windows-10
# Command line to list all packages: Get-AppxPackage -AllUsers | Select Name, PackageFullName
#

# won't work on 1809
# "Microsoft.Windows.PeopleExperienceHost_10.0.17763.1_neutral_neutral_cw5n1h2txyewy"
# "Microsoft.XboxGameCallableUI_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy" 
# "Microsoft.Windows.ParentalControls_1000.17763.1.0_neutral_neutral_cw5n1h2txyewy"
# "Microsoft.Windows.Cortana_1.11.5.17763_neutral_neutral_cw5n1h2txyewy"

#Get-AppxPackage Microsoft.Windows.ParentalControls | Remove-AppxPackage
Get-AppxPackage Windows.ContactSupport | Remove-AppxPackage
#Get-AppxPackage Microsoft.Xbox* | Remove-AppxPackage
Get-AppxPackage microsoft.windowscommunicationsapps | Remove-AppxPackage # Mail and Calendar
#Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsCamera | Remove-AppxPackage
Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
Get-AppxPackage Microsoft.Zune* | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage # Phone Companion
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage
Get-AppxPackage Microsoft.Appconnector | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsFeedback* | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.FeatureOnDemand.InsiderHub | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.Cortana | Remove-AppxPackage
Get-AppxPackage Microsoft.People | Remove-AppxPackage
Get-AppxPackage Microsoft.Bing* | Remove-AppxPackage # Money, Sports, News, Finance and Weather
Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
Get-AppxPackage Microsoft.3DBuilder | Remove-AppxPackage
Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
Get-AppxPackage Microsoft.CommsPhone | Remove-AppxPackage
Get-AppxPackage Microsoft.Advertising.Xaml | Remove-AppxPackage
Get-AppxPackage Microsoft.Windows.SecondaryTileExperience | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.ParentalControls | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.ContentDeliveryManager | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.CloudExperienceHost | Remove-AppxPackage
#Get-AppxPackage Microsoft.Windows.ShellExperienceHost | Remove-AppxPackage
#Get-AppxPackage Microsoft.BioEnrollment | Remove-AppxPackage
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage
Get-AppxPackage *Twitter* | Remove-AppxPackage
Get-AppxPackage king.com.CandyCrushSodaSaga | Remove-AppxPackage
Get-AppxPackage flaregamesGmbH.RoyalRevolt2 | Remove-AppxPackage
Get-AppxPackage *Netflix | Remove-AppxPackage
Get-AppxPackage Facebook.Facebook | Remove-AppxPackage
Get-AppxPackage Microsoft.MinecraftUWP | Remove-AppxPackage
Get-AppxPackage *MarchofEmpires | Remove-AppxPackage

# See How to Completely Uninstall OneDrive in Windows 10 http://lifehacker.com/how-to-completely-uninstall-onedrive-in-windows-10-1725363532
taskkill /f /im OneDrive.exe
C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall

#Then type in either
#%SystemRoot%\System32\OneDriveSetup.exe /uninstall
#if you're using 32-bit Windows 10 or
#%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
