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

# See How to Completely Uninstall OneDrive in Windows 10 http://lifehacker.com/how-to-completely-uninstall-onedrive-in-windows-10-1725363532
taskkill /f /im OneDrive.exe
C:\Windows\SysWOW64\OneDriveSetup.exe /uninstall

#Then type in either
#%SystemRoot%\System32\OneDriveSetup.exe /uninstall
#if you're using 32-bit Windows 10 or
#%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall

choco install inconsolata -y
