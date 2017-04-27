	# username and password
	$credential = Get-Credential
	$userName_ = $credential.UserName
	$userName_ = $userName_.subString(1,$userName_.length - 1)
	$passWord_ = $credential.GetNetworkCredential().Password

	[scriptblock] $scriptBlock = {
		param ($serverInstance_, $userName_, $passWord_, $sqlRequestPathFileName, $sqlResultPathFileName)
		sqlps -Command "&{Invoke-Sqlcmd -QueryTimeout 2000 -InputFile $sqlRequestPathFileName -ServerInstance $ServerInstance_ -Username $userName_ –Password $passWord_ | Select-Object -Property * -ExcludeProperty RowError, RowState, HasErrors, Table, ItemArray | Export-CSV -UseCulture -NoTypeInformation -Encoding UTF8 -Path $sqlResultPathFileName}"
	}
