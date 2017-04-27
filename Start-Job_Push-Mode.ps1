    # Push mode
	$MaxThreads = 5
	Foreach ($item in $allItems) { 
		start-Job  -Name $item -ScriptBlock $scriptBlock -ArgumentList $serverInstance_, $userName_, $passWord_, $sqlRequestPathFileName, $sqlResultPathFileName        
			
		While (@(Get-Job | Where { $_.State -eq "Running" }).Count -ge $MaxThreads) {
			Start-Sleep -Seconds 5
	    }    
	}

	While (Get-Job -State Running) 
	{
		Get-Job | Receive-Job
	}
	