###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#Appending data to a text file 
Add-Content E:\CT\Powershell\CodePlay\textex1.txt "Written by Syed Awase"

#Add Content appends the new value immediately after the last character
#in the text file 
Add-Content E:\CT\Powershell\CodePlay\textex1.txt "`nThe End"

Write-Host `a 
$A = Get-Date; Add-Content E:\CT\Powershell\CodePlay\*.log $A 

#Using the Select-String Cmdlet 
# to check whether or not a specific string value exists in a text file 
Get-Content E:\CT\Powershell\CodePlay\successState.txt | Select-String "Failed" -Quiet 

#Displaying data and save that data with one command 
#Tee-Object cmdlet enables you to display data in the windows Powershell window 
# to save that same data to a text file 
# all with a single command 
#Get-Process cmdlet retrieves information about all the processes running on the computer 

Get-Process | Tee-Object -file E:\CT\Powershell\CodePlay\outputOne.txt 

#Erasing the contents of a file 
#using clear-content 
Clear-Content E:\CT\Powershell\CodePlay\textex1.txt
Clear-Content E:\CT\Powershell\CodePlay\demo\t*
Clear-Content E:\CT\Powershell\CodePlay\demo\text.xls

#using ConvertTo-Html Cmdlet 

Get-Process | ConvertTo-Html | Set-Content E:\CT\Powershell\CodePlay\processresult.html


Get-Process | ConvertTo-Html name,path,fileversion |Set-Content E:\CT\Powershell\CodePlay\processresult-2.html

Get-Process | ConvertTo-Html name,path, fileversion -title "Process Information" | Set-Content E:\CT\Powershell\CodePlay\tex1.html


Get-Process | 
ConvertTo-Html name,path,fileversion -title "Process Information" -body "Information about the processes running on the computer." | 
Set-Content E:\CT\Powershell\CodePlay\tex2.html

#Reading a text file 
Get-Content E:\CT\Powershell\CodePlay\outputOne.txt 
Get-Content E:\CT\Powershell\CodePlay\outputOne.txt  | ForEach-Object {Get-WmiObject -ComputerName $_win32_bios}
Get-Content E:\CT\Powershell\CodePlay\outputOne.txt | Measure-Object 
Get-Content E:\CT\Powershell\CodePlay\outputOne.txt | Select-Object -last 5

#Reading csv file 
Import-Csv E:\CT\Powershell\CodePlay\demo\demofile.csv
Import-Csv E:\CT\Powershell\CodePlay\demo\demofile.csv | Where-Object {$_.last_name -eq "freeman"}
Import-Csv E:\CT\Powershell\CodePlay\demo\demofile.csv | Where-Object {$_.last_name -eq "freeman" -and $_.first_name -eq "Laura"}

#using the import-Clixml 
#export-clixml -enables to save data as an XML file 
Get-ChildItem E:\CT\Powershell\CodePlay\demo\ | Export-Clixml E:\CT\Powershell\CodePlay\demo\demofile.xml
$A=Import-Clixml E:\CT\Powershell\CodePlay\demo\demofile.xml
$A | Sort-Object length 

# Export/import csv 
Get-Process | Export-CSV E:\CT\Powershell\CodePlay\demo\demofile2.csv -Encoding "unicode"
Get-Process | Export-CSV E:\CT\Powershell\CodePlay\demo\demofile2.csv  -NoTypeInformation

# Measure-Command 
Measure-Command {Get-Service |Export-Clixml E:\CT\Powershell\CodePlay\demo\demofile2.csv}

