choco install inconsolata -y

# Privacy and mitigaton settings
# See: https://docs.microsoft.com/en-us/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services

# Logon script
If ($InstallLogonScript -eq "true")
{
	. Logit "Copying Logon script to C:\Windows\Scripts"
	If (!(Test-Path "C:\Windows\Scripts"))
	{
		New-Item "C:\Windows\Scripts" -ItemType Directory
	}
	Copy-Item -Path $PSScriptRoot\Logon.ps1 -Destination "C:\Windows\Scripts" -Force
	# load default hive
	Start-Process -FilePath "reg.exe" -ArgumentList "LOAD HKLM\DEFAULT C:\Users\Default\NTUSER.DAT"
	# create RunOnce entries current / new user(s)
	. Logit "Creating RunOnce entries..."
	New-ItemProperty -Path "HKLM:\Default\Software\Microsoft\Windows\CurrentVersion\Runonce" -Name "Logon" -Value "Powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File C:\Windows\Scripts\Logon.ps1"
	New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Runonce" -Name "Logon" -Value "Powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File C:\Windows\Scripts\Logon.ps1"
	# unload default hive
	Start-Process -FilePath "reg.exe" -ArgumentList "UNLOAD HKLM\DEFAULT"
}

echo "$env:PROGRAMDATA"




#EDIT 2: The warning badge on the "Security Center" icon when signing in with a local account can be disabled in the Default User Profile registry hive with a DWORD 0 @ SOFTWARE\Microsoft\Windows Security Health\State\AccountProtection_MicrosoftAccount_Disconnected.
