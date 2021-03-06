<#

.SYNOPSIS

Copies the all the files from one folder into another and creates a backup folder in the destination folder with the previous content.



.DESCRIPTION

Copy-FolderWithBackup takes a source and a destination folder. It first checks the destination folder for existing content.
If the destination folder contains files, it creates a timestamped backup folder and drops the existing files there.
Once this backup is performed, the files on the source folder are copied, replacing any files with conflicting names.
The name of the backup folder is called backupyyyy-MM-dd-HH-mm-ss with the corresponding timestamp.


.PARAMETER SourceFolder 

The folder that contains the files intended to be copied.



.PARAMETER DestinationFolder

The folder where the content from  SourceFolder is going to be dropped.


.EXAMPLE 

Copies the files from the C:\Folder to C:\To folder, creating a timestamped backup folder with the content from "C:\To"

Copy-FolderWithBackup "C:\From" "C:\To"



.NOTES

You need to run this function as a member of the Domain Admins group; doing so is the only way to ensure you have permission to query WMI from the remote computers.

#>
Function Copy-FolderWithBackup([string] $SourceFolder, [string] $DestinationFolder)
{
	$existingFiles = Get-ChildItem $DestinationFolder | measure
	if($existingFiles.Count -ne 0)
	{
		Write-Host "The destination folder contains files. Creating a backup of the files."
		
		$now = Get-Date
		$folderName = "backup-" + $now.ToString("yyyy-MM-dd-HH-mm-ss")
		Set-Location $DestinationFolder
		mkdir $foldername > $null
		Copy-Item $DestinationFolder\*.* $foldername
		
		Write-Host "Succesfully created a backup at " $foldername
		
	}
	
	Copy-Item $SourceFolder\*.* $DestinationFolder
	
	Write-Host "Succesfully copied the files from" $SourceFolder "to" $DestinationFolder
}
