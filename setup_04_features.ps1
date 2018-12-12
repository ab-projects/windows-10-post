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

$to_disable = @(
    "AppServerClient",
    "Client-DeviceLockdown",
    "Client-EmbeddedBootExp",
    "Client-EmbeddedLogon",
    "Client-EmbeddedShellLauncher",
    "Client-KeyboardFilter",
    "Client-ProjFS",
    "Client-UnifiedWriteFilter",
    "ClientForNFS-Infrastructure",
    "Containers",
    "Containers-DisposableClientVM",
    "DataCenterBridging",
    "DirectPlay",
    "DirectoryServices-ADAM-Client",
    "HostGuardian",
    "HypervisorPlatform",
    "IIS-ASP",
    "IIS-ASPNET",
    "IIS-ASPNET45",
    "IIS-ApplicationDevelopment",
    "IIS-ApplicationInit",
    "IIS-BasicAuthentication",
    "IIS-CGI",
    "IIS-CertProvider",
    "IIS-ClientCertificateMappingAuthentication",
    "IIS-CommonHttpFeatures",
    "IIS-CustomLogging",
    "IIS-DefaultDocument",
    "IIS-DigestAuthentication",
    "IIS-DirectoryBrowsing",
    "IIS-FTPExtensibility",
    "IIS-FTPServer",
    "IIS-FTPSvc",
    "IIS-HealthAndDiagnostics",
    "IIS-HostableWebCore",
    "IIS-HttpCompressionDynamic",
    "IIS-HttpCompressionStatic",
    "IIS-HttpErrors",
    "IIS-HttpLogging",
    "IIS-HttpRedirect",
    "IIS-HttpTracing",
    "IIS-IIS6ManagementCompatibility",
    "IIS-IISCertificateMappingAuthentication",
    "IIS-IPSecurity",
    "IIS-ISAPIExtensions",
    "IIS-ISAPIFilter",
    "IIS-LegacyScripts",
    "IIS-LegacySnapIn",
    "IIS-LoggingLibraries",
    "IIS-ManagementConsole",
    "IIS-ManagementScriptingTools",
    "IIS-ManagementService",
    "IIS-Metabase",
    "IIS-NetFxExtensibility",
    "IIS-NetFxExtensibility45",
    "IIS-ODBCLogging",
    "IIS-Performance",
    "IIS-RequestFiltering",
    "IIS-RequestMonitor",
    "IIS-Security",
    "IIS-ServerSideIncludes",
    "IIS-StaticContent",
    "IIS-URLAuthorization",
    "IIS-WMICompatibility",
    "IIS-WebDAV",
    "IIS-WebServer",
    "IIS-WebServerManagementTools",
    "IIS-WebServerRole",
    "IIS-WebSockets",
    "IIS-WindowsAuthentication",
    "LegacyComponents",
    "MSMQ-ADIntegration",
    "MSMQ-Container",
    "MSMQ-DCOMProxy",
    "MSMQ-HTTP",
    "MSMQ-Multicast",
    "MSMQ-Server",
    "MSMQ-Triggers",
    "MediaPlayback",
    "Microsoft-Hyper-V",
    "Microsoft-Hyper-V-All",
    "Microsoft-Hyper-V-Hypervisor",
    "Microsoft-Hyper-V-Management-Clients",
    "Microsoft-Hyper-V-Management-PowerShell",
    "Microsoft-Hyper-V-Services",
    "Microsoft-Hyper-V-Tools-All",
    "MicrosoftWindowsPowerShellV2",
    "MicrosoftWindowsPowerShellV2Root",
    "MultiPoint-Connector",
    "MultiPoint-Connector-Services",
    "MultiPoint-Tools",
    "NFS-Administration",
    "NetFx4Extended-ASPNET45",
    "Printing-Foundation-LPDPrintService",
    "Printing-Foundation-LPRPortMonitor",
    "Printing-XPSServices-Features",
    "SMB1Protocol",
    "SMB1Protocol-Client",
    "SMB1Protocol-Deprecation",
    "SMB1Protocol-Server",
    "SearchEngine-Client-Package",
    "ServicesForNFS-ClientOnly",
    "SimpleTCP",
    "TFTP",
    "TIFFIFilter",
    "TelnetClient",
    "VirtualMachinePlatform",
    "WAS-ConfigurationAPI",
    "WAS-NetFxEnvironment",
    "WAS-ProcessModel",
    "WAS-WindowsActivationService",
    "WCF-HTTP-Activation",
    "WCF-HTTP-Activation45",
    "WCF-MSMQ-Activation45",
    "WCF-NonHTTP-Activation",
    "WCF-Pipe-Activation45",
    "WCF-TCP-Activation45",
    "Windows-Defender-ApplicationGuard",
    "Windows-Identity-Foundation",
    "WorkFolders-Client"
)
foreach($feature in $to_disable) {
    Write-Output "Disabling Windows Optional Feature '${feature}'"
    Disable-WindowsOptionalFeature -FeatureName $feature -Online -NoRestart
}

$to_enable = @(
    "FaxServicesClientPackage",
    "MSRDC-Infrastructure",
    "Microsoft-Windows-Client-EmbeddedExp-Package",
    "Microsoft-Windows-NetFx3-OC-Package",
    "Microsoft-Windows-NetFx3-WCF-OC-Package",
    "Microsoft-Windows-NetFx4-US-OC-Package",
    "Microsoft-Windows-NetFx4-WCF-US-OC-Package",
    "Microsoft-Windows-Subsystem-Linux",
    "NetFx4-AdvSrvs",
    "Printing-Foundation-Features",
    "Printing-Foundation-InternetPrinting-Client",
    "Printing-PrintToPDFServices-Features",
    "SmbDirect",
    "WCF-Services45",
    "WCF-TCP-PortSharing45",
    "Windows-Defender-Default-Definitions"
)
foreach($feature in $to_enable) {
    Write-Output "Enabling Windows Optional Feature '${feature}'"
    Enable-WindowsOptionalFeature -FeatureName $feature -Online -NoRestart -All
}
