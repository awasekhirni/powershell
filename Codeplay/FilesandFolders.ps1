###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#copying files and folders 
Copy-Item E:\CT\Powershell\CodePlay\baseball.txt E:\CT\Powershell\
Copy-Item E:\CT\Powershell\CodePlay\* E:\CT\Powershell\ -Recurse

#creating a New-item Cmdlet 

New-Item E:\CT\Powershell\CodePlay\ PowerShell -type directory
New-Item E:\CT\Powershell\CodePlay\new_file.txt -type file
#override the default behaviour by including the -force parameter
New-Item E:\CT\Powershell\CodePlay\new_file.txt -type file -force

# using the -value parameter to add some data to the new file 

New-Item E:\CT\Powershell\CodePlay\nnew_file.txt -type file -force -value "Welcome to Sycliq.com - SYCLIQ is an Acronym for Systems for Crop Life Cycle Intelligence!"

#Using the Remove-Item Cmdlet
Remove-Item E:\CT\Powershell\CodePlay\text.txt 
Remove-Item E:\CT\Powershell\CodePlay\* -Recurse
Remove-Item E:\CT\Powershell\CodePlay\* -Exclude *.wav
Remove-Item E:\CT\Powershell\CodePlay\* -Include *.wav, .mp3 

Remove-Item E:\CT\Powershell\CodePlay\ -Include *.txt -exclude *test* 
# -WhatIf parameter that does not actually remove anything but simply tells you what would happen if you did call Remove-item
Remove-Item E:\CT\Powershell\CodePlay\*.vbs -WhatIf 


#Using the Move-Item Cmdlet 

Move-Item E:\CT\Powershell\CodePlay\ E:\CT\Powershell\CodePlay\otherdata\
Move-Item E:\CT\Powershell\CodePlay\ E:\CT\Powershell\CodePlay\testdata -force 

#Renaming Item Cmdlet 

Rename-Item E:\CT\Powershell\CodePlay\test.jpg test.gif 

#Iteratively geting the child items 
Get-ChildItem -Recurse
Get-ChildItem env:
Get-ChildItem E:\CT\Powershell\CodePlay\*.* -include *.txt,*.log
Get-ChildItem E:\CT\Powershell\CodePlay\*.* -exclude *.txt, *.log
Get-ChildItem E:\CT\Powershell\CodePlay\*.* | Sort-Object length 
Get-ChildItem E:\CT\Powershell\CodePlay\*.* | Sort-Object length -Descending


#Retrieving a Specific Item
#based on last access time 
$(Get-Item E:\CT\Powershell\CodePlay\*.ps1).lastaccesstime 
$(Get-Item HKCU:\SOFTWARE).SubKeyCount
Get-Item HKCU:\SOFTWARE | Get-Member

#verifying the existence of a file or folder 
#verifying the existence of a file or folder 
Test-Path E:\CT\Powershell\CodePlay\
Test-Path E:\CT\Powershell\CodePlay\*.wma 
Test-Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion



