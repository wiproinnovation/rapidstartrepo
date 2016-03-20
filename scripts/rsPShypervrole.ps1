param
{
		[string]$hostName
}
winrm s winrm/config/client '@{TrustedHosts="$hostName"}';
$password = ConvertTo-SecureString pass@word1 -AsPlainText -Force;
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist "$hostName\Administrator",$password;
Invoke-Command -ComputerName $hostName -ScriptBlock {Add-WindowsFeature Hyper-V -IncludeAllSubFeature; Add-WindowsFeature RSAT-Hyper-V-Tools -IncludeAllSubFeature} -Credential $cred