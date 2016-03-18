param (
	[string]$server = "anonymous",
)
Rename-Computer -NewName $server -Restart
