param
(
	[string]$domainName,
	[string]$domainNetbiosName
	
)
Add-WindowsFeature AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools;
Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools;
Add-WindowsFeature -Name "gpmc" -IncludeAllSubFeature -IncludeManagementTools;
Import-Module ADDSDeployment;
$pwd = ConvertTo-SecureString pass@word1 -AsPlainText -Force;
Install-ADDSForest -DomainName ${domainName} -DomainMode Win2012 -DomainNetBiosName ${domainNetbiosName} -ForestMode Win2012 –InstallDNS -SafeModeAdministratorPassword $pwd -Force
