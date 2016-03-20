param
{
	[string]$hostName,
	[string]$runasDomainName,
	[string]$sourceShare,
	[string]$sourceShareUser,
	[string]$sourceSharePassword,
	[string]$installCommandLine
	
}

winrm s winrm/config/client '@{TrustedHosts="$hostName"}';
$password = ConvertTo-SecureString pass@word1 -AsPlainText -Force;
$cred = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist "$runasDomainName\Administrator",$password;
Invoke-Command -ComputerName $hostName -ScriptBlock {
$net = new-object -ComObject WScript.Network
$net.MapNetworkDrive("P:", "$sourceShare", $false, "$sourceShareUser",  "$sourceSharePassword")
P:
cd $sourcePath
$installCommandLine | Out-Null
} -Credential $cred -AsJob
Get-Job | Wait-Job