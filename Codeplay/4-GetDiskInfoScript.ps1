###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
#computerName
$env:computerName
Get-WmiObject –Class Win32_LogicalDisk –Filter "DriveType=3"
 -ComputerName DESKTOP-I57JOS9 |
Select-Object –Property DeviceID,@{Name='ComputerName';
Expression={$_.PSComputerName}},Size,FreeSpace


# Create New Aliases 
Set-Alias -Name gi -Value Get-Item 
Set-Alias -Name si -Value Set-Item 
Set-Alias -Name gl -Value Get-Location 
Set-Alias -Name sl -Value Set-Location 
set-Alias -Name gcm -Value Get-Command

#getting the list of alias 
Get-Alias
