param
{
	[string]$memberName,
	[string]$memberAdminPassword,
	[string]$memberAdminUser,
	[string]$domainName,
	[string]$domainAdminPassword,
	[string]$domainAdminUser
}
winrm s winrm/config/client '@{TrustedHosts="$memberName"}';
$password = ConvertTo-SecureString $memberAdminPassword -AsPlainText -Force;
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $memberName\$memberAdminUser,$password;
Invoke-Command -ComputerName $memberName -ScriptBlock {
$password = ConvertTo-SecureString $domainAdminPassword -AsPlainText -Force;
$domainCred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $domainName\$domainAdminUser,$password;
Add-Computer -DomainName $domainName -Credential $domainCred -Force
} -Credential $cred