function is_admin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
    return $principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )
}

Try
{
    if ( is_admin ) 
    { 
        exit 0 
    }
	else
	{
		Write-Host "ERROR: Current user is not an administrator!"
	}
}
Catch
{
    Write-Host "ERROR: " $_.Exception.Message
}

exit 1
