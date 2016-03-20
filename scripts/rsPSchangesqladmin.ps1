param(
	[string]$hostName,
	[string]$domainName
	
	)
Import-Module SQLPS -DisableNameChecking
Invoke-Sqlcmd -query 'CREATE LOGIN "$domainName\Administrator" FROM WINDOWS' -ServerInstance $hostName -Username sa -Password pass@word1
Invoke-Sqlcmd -query 'ALTER SERVER ROLE sysadmin ADD MEMBER "$domainName\Administrator"' -ServerInstance $hostName -Username sa -Password pass@word1


