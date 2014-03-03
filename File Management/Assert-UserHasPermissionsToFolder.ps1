Function Assert-UserHasPermissionsToFolder([string] $userName,	[string] $folder)
{
	# TODO: Validate parameters
	# TODO: Is there any case count would be greater than 1?
	$measure = (Get-Acl -Path $folder).GetAccessRules($true,$true, [System.Security.Principal.NTAccount])| where {$_.IdentityReference.Value.ToUpperInvariant().Equals($userName.ToUpperInvariant())} | measure;
	
	($measure.Count.Equals(1));
}