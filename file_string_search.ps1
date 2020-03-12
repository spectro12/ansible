
$lastuseddir = gci $dir_path | sort LastWriteTime | select -last 1  # gets the last modified file
$dir_path = $lastuseddir.FullName 
$sw = 'w.*'                                                  # regex search pattern
                                
if(Get-Childitem -Path $dir_path | Select-String -Pattern "$sw")      #searches the file for the string if the string is present in the file output true, else false
{Write-Host 'True'
} else {
     Write-Host 'False'
}

