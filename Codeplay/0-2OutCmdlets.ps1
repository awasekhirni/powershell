###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
Get-Process | Out-File -Encoding "UTF8" -FilePath E:\CT\Powershell\CodePlay\myprocess.txt
Get-Process | Out-File -Encoding "UTF8" -FilePath .\myprocess.txt
Get-Content .\myprocess.txt
Get-Process | Out-GridView
Get-Process | Out-Printer 
Get-Process | Out-String

#-------------------------------------

#region Auto loading of modules 
 
# show modules loaded by default 
Get-Module 
# display modules that are available to load 
Get-Module -Name Cim* -ListAvailable
#importing CimCmdlets Module 
# version 2, we had to use Import-Module CimCmdlets
Get-CimInstance win32_bios
#displaying the list of modules loaded now
Get-Module 
#remove auto loaded module or any module 
Remove-Module CimCmdlets


#--------------------------------
#subexpression 
$service = Get-Service | select -First 1 
"Service name is $($service.name)"
1..100 | foreach {Write-Host $_}
$procs = Get-Process 
$procs[2..5]#range operator 



[math]::Sin([math]::pi/2)



