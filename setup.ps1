"This will create some folders on your desktop, which folders will be created depending on what folders you have in your Onedrive directory. Do you want to continue? Y/n"

:prompt while ($true)
{
	switch ([console]::ReadKey($true).Key)
	{
		{ $_ -eq [ConsoleKey]::Y } { break prompt }
		{ $_ -eq [ConsoleKey]::N } { return }
	}
}


if( $null -eq $Env:OneDrive )
{
	Write-Host "The Environment Variable `"OneDrive`" Does Not Exist." -ForegroundColor Red
	return
}

Write-Host "`nStart Creating Directory Junctions." -ForegroundColor Yellow

foreach ( $Name in Get-ChildItem -Path $Env:OneDrive -Directory -Name )
{
	if( Test-Path -Path ~\Desktop\$Name )
	{
		Write-Host "$Name" -ForegroundColor Red -NoNewline; Write-Host " -> Already Exists."
		continue
	}

	[void](New-Item -Type Junction -Path ~\Desktop\$Name -Target $Env:OneDrive\$Name)
	Write-Host "$Name" -ForegroundColor Green -NoNewline; Write-Host " -> $Env:OneDrive\$Name"
}

Write-Host "Create Directory Junctions Complete.`n" -ForegroundColor Cyan
