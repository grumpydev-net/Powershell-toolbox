###################################################################################################################
# Script: 		GZUnzipFolder.ps1
# Author: 		adrian@adrianpadilla.net
# Version:		1.0
# Keywords: 	GZip, unzipp
# Description:
# 				Takes a folder as parameter and unzips all the .gz files on it.
#				The files will have the same name except  the gz format.
# Pending items / Technical debt:
#				* Currently all the content is loaded as a string before writing. Need to do it as a buffered stream to support very large files.
#				* Pending validation of paths. Convert to file objects and use IO.Path methods.
#				* Extend usage and parameter documentation.
###################################################################################################################
Param(
    $folder
)

$folder = 'C:\Users\v-adpadi\Desktop\GZ test\'
$folder = $folder.TrimEnd('\')

Write-Host 'Unzipping files in folder '$folder

foreach($file in (Get-ChildItem $folder\*.gz))
{
	Write-Host "Processing file" $file
    $inputStream = New-Object System.IO.FileStream $file, ([IO.FileMode]::Open), ([IO.FileAccess]::Read), ([IO.FileShare]::Read)
    $zipStream = New-Object System.IO.Compression.GzipStream $inputStream, ([IO.Compression.CompressionMode]::Decompress)

	$outputfilename = $folder + '\'  + $file.Name.TrimEnd(".gz");
    $outputfilestream = New-Object System.IO.FileStream $outputfilename, ([IO.FileMode]::Create), ([IO.FileAccess]::Write), ([IO.FileShare]::Write)
    $streamReader =  New-Object System.IO.StreamReader($zipStream);
    $filecontent = $streamReader.ReadToEnd();
	
	Write-Host "Writting to file " $outputfilename 
    $streamWriter = New-Object System.IO.StreamWriter($outputfilestream);
    $streamWriter.Write($filecontent);

    Write-Host "Finished with file" $file
    $inputStream.Close();
    $zipStream.Close();
    $streamReader.Close();
    $streamWriter.Close();
}


##Get-ChildItem $folder *.gz | 
