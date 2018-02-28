###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#Working with files and folders 
Get-ChildItem -Force C:\
# recursive iteration
Get-ChildItem -Force C:\ -Recurse 
# to retrieve all executables with in the Program Files Folder 
# specific timeline
Get-ChildItem -Path $env:ProgramFiles -Recurse -Include *.exe | Where-Object -FilterScript {
    ($_.LastWriteTime -gt "2015-10-1") -and ($_.Length -ge 1mb) -and ($_.Length -le 10mb)
    }

#Copying files and folders
Copy-Item -Path E:\example.txt -Destination E:\ex.bak

Copy-Item -Path c:\boot.ini -Destination c:\boot.bak -Force

Copy-Item C:\temp\test1 -Recurse c:\temp\DeleteMe

Copy-Item -Filter *.txt -Path c:\data -Recurse -Destination c:\temp\text

(New-Object -ComObject Scripting.FileSystemObject).CopyFile("c:\boot.ini", "c:\boot.bak")

####################################
#Creating files and folders 

New-Item -Path 'C:\temp\New Folder' -ItemType "directory"

New-Item -Path 'C:\temp\New Folder\file.txt' -ItemType "file"


###################
#Removing all files and folders within a folder 

Remove-Item C:\temp\DeleteMe - Recurse 


###############################
#Mapping a local folder as a Windows Accessible Drive 
#using subst command, we can map a local folder 
subst p: $env:ProgramFiles


### Reading a text file into an Array
# reads the data from file as an array with one element per line of the file content. 
# on length check, you would get no of lines 
Get-Content -Path C:\sometext.txt 
(Get-Content -Path C:\sometext.txt).Length 





#############################
#Copying the contents of the file to another file 

$SourceFile = "C:\Temp\File.txt"
$DestinationFile = "C:\Temp\NonexistentDirectory\File.txt"

If (Test-Path $DestinationFile) {
    $i = 0
    While (Test-Path $DestinationFile) {
        $i += 1
        $DestinationFile = "C:\Temp\NonexistentDirectory\File$i.txt"
    }
} Else {
    New-Item -ItemType File -Path $DestinationFile -Force
}

Copy-Item -Path $SourceFile -Destination $DestinationFile -Force
