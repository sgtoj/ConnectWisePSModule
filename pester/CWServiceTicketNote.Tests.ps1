# remove module if it exist and re-imports it
$WorkspaceRoot = $(Get-Item $PSScriptRoot).Parent.FullName
Remove-Module "CWServiceBoardStatusCmdLets" -ErrorAction Ignore
Import-Module "$WorkspaceRoot\src\CWServiceTicketNoteCmdLets.psm1" -Force 

# dot-sources the definition file to get static variables (prefixed with 'pstr') to be used for testing
. "$WorkspaceRoot\pester\.test.variables.ps1" 

Describe 'Get-CWServiceTicketNote' {
	
	It 'gets ticket note entries for a ticket and check that the results is an array' {
		$ticketID = $pstrTicketID;
		$timeEntries = Get-CWServiceTicketNote -TicketID $ticketID -BaseApiUrl $pstrSvrUrl -CompanyName $pstrCompany -PublicKey $pstrSvrPublicKey -PrivateKey $pstrSvrPrivateKey;
		$timeEntries.GetType().BaseType.Name | Should Be "Array";		
	}

} 