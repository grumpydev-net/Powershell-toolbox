###################################################################################################################
# Script: 		UserHasPermissionsToFolder.ps1
# Author: 		adrian@adrianpadilla.net
# Version:		1.0
# Keywords: 	ACL, 
# Description:
# 				Indicates wheter an account is listed in the ACL of a folder or not.
# Pending items / Technical debt:
#				* Validate parameters
#				* Is there any case count would be greater than 1?
#				* 
###################################################################################################################
Function UserHasPermissionsToFolder([string] $userName,	[string] $folder)
{
	# TODO: Validate parameters
	# TODO: Is there any case count would be greater than 1?
	$measure = (Get-Acl -Path $folder).GetAccessRules($true,$true, [System.Security.Principal.NTAccount]) | where {$_.IdentityReference.Value.Equals($userName)} | measure;
	
	($measure.Count.Equals(1));
}