

# Now actually uninstall the apps
Get-AppxPackage -allusers *CandyCrushSodaSaga* | Remove-AppxPackage
Get-AppxPackage -allusers *Minecraft* | Remove-AppxPackage
Get-AppxPackage -allusers *3dbuilder* | Remove-AppxPackage
Get-AppxPackage -allusers *windowsalarms* | Remove-AppxPackage
Get-AppxPackage -allusers *windowscamera* | Remove-AppxPackage
Get-AppxPackage -allusers *windowsmaps* | Remove-AppxPackage
Get-AppxPackage -allusers *bingfinance* | Remove-AppxPackage
Get-AppxPackage -allusers *bingnews* | Remove-AppxPackage
Get-AppxPackage -allusers *bingsports* | Remove-AppxPackage
Get-AppxPackage -allusers *bingweather* | Remove-AppxPackage
Get-AppxPackage -allusers *officehub* | Remove-AppxPackage
Get-AppxPackage -allusers *onenote* | Remove-AppxPackage
Get-AppxPackage -allusers *skypeapp* | Remove-AppxPackage
Get-AppxPackage -allusers *zunemusic* | Remove-AppxPackage
Get-AppxPackage -allusers *zunevideo* | Remove-AppxPackage
Get-AppxPackage -allusers *soundrecorder* | Remove-AppxPackage
Get-AppxPackage -allusers *NetworkSpeedTest* | Remove-AppxPackage
Get-AppxPackage -allusers *EclipseManager* | Remove-AppxPackage
Get-AppxPackage -allusers *ActiproSoftwareLLC* | Remove-AppxPackage
Get-AppxPackage -allusers *MicrosoftPowerBIForWindows* | Remove-AppxPackage
Get-AppxPackage -allusers *Pandora* | Remove-AppxPackage
Get-AppxPackage -allusers *RemoteD* | Remove-AppxPackage
Get-AppxPackage -allusers *Sway* | Remove-AppxPackage
Get-AppxPackage -allusers *twitter* | Remove-AppxPackage
Get-AppxPackage -allusers *xboxapp* | Remove-AppxPackage
Get-AppxPackage -allusers *XboxIdentityProvider* | Remove-AppxPackage
Get-AppxPackage -allusers *windowsphone* | Remove-AppxPackage
Get-AppxPackage -allusers *CommsPhone* | Remove-AppxPackage
Get-AppxPackage -allusers *Phone* | Remove-AppxPackage
Get-AppxPackage -allusers *communicationsapps* | Remove-AppxPackage
Get-AppxPackage -allusers *Messaging* | Remove-AppxPackage
Get-AppxPackage -allusers *connect* | Remove-AppxPackage
Get-AppxPackage -allusers *contact* | Remove-AppxPackage
Get-AppxPackage -allusers *people* | Remove-AppxPackage
Get-AppxPackage -allusers *photos* | Remove-AppxPackage
Get-AppxPackage -allusers *zune* | Remove-AppxPackage
Get-AppxPackage -allusers *bing* | Remove-AppxPackage
Get-AppxPackage -allusers *one* | Remove-AppxPackage
Get-AppxPackage -allusers *xbox* | Remove-AppxPackage


#Get-Appxpackage -allusers *HolographicFirstRun* | remove-appxpackage

#Get-Appxpackage -allusers *holographic* | remove-appxpackage

Dism /online /Remove-Capability /CapabilityName:Analog.Holographic.Desktop

Function DisableCortana
{  
    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"    
    IF(!(Test-Path -Path $path)) { 
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows" -Name "Windows Search"
    } 
    Set-ItemProperty -Path $path -Name "AllowCortana" -Value 0 
    #Restart Explorer to change it immediately    
    Stop-Process -name explorer
}
DisableCortana


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
