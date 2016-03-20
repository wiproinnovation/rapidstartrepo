param
{
	[string]$memberName,
	[string]$memberAdminPassword,
	[string]$memberAdminUser
	
}
winrm s winrm/config/client '@{TrustedHosts="$memberName"}';
$user = "$memberName\$memberAdminUser";
$pwd = "$memberAdminPassword";
$password = ConvertTo-SecureString $pwd -AsPlainText -Force;
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $user,$password;
Invoke-Command -ComputerName $memberName -ScriptBlock {
Restart-Computer -Force
} -Credential $cred