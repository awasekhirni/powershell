###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
###################
Write-Host "Add-Content Demo" -ForegroundColor green
Write-Host "Demo starting "; Start-Sleep 10; Write-Host "Started ...";
#Adds content to a specified items 
#adding words to a file
#Add-Content 

# Add a stirng to all text files with an exception 
Add-Content -Path "*.txt" -Exclude "help" -Value "Written by -Syed Awase=>sak@sycliq.com"
#Add a date to the end of the specified files 
Add-Content -Path "file1.log", "file2.log" -Value (Get-Date) -PassThru
#Add the contents of a specified file to another file 
Add-Content -Path "monthly.txt" -Value (Get-Content "E:/CT/Powershell/CodePlay/Weeklydata.txt")
$d=Read-Host "Enter your directory" 
#Create a new directory and file and copy content 
Add-Content -Value (Get-Content "test.log") -Path $d



