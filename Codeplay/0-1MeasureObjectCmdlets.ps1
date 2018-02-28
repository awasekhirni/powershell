###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
Clear-Host

$SomeOfMyVariables = "Pluralsight Program by Syed Awase"
$SomeOfMyVariables
$SomeOfMyVariables = "@Harman Pune"
$SomeOfMyVariables

Get-Alias dir
#---------------------------------------------


#region in and notin --------------------------------------------------------
# New -in and -notin operator

  $value = 3
  if ($value -in (1,2,3)) 
    {"The number $value was here"}

  $array = (3,4,5,7)
  if (6 -notin $array) 
    {"6 ain't there"}


#endregion

#______________________________________________

# Where
  # You no longer have to use the $_ syntax with Where for simple expressions

  Set-Location "C:\Windows"  # Just to give us an interesting place

  # Old Syntax
  Get-ChildItem | Where-Object {$_.Length -ge 100kb}

  # New Syntax
  Get-ChildItem | Where-Object Length -ge 100kb

  $size = 100kb
  Get-ChildItem | Where-Object Length -ge $size
  dir | ? Length -ge 100kb

#endregion where

#region hashtable demo 
 $hashTablev5= @{a=111;b=222;c=333;d=4444;e=5555}
 $hashTablev5

 #ordered list 
 $hashTableorder = [ordered]@{a=111;b=222;c=333;d=4444;e=5555}
 $hashTableorder

#endregion  hashtable demo


#------------------------------------------------

Get-ChildItem
Get-ChildItem -Directory

#-File switch only returns files 
Get-ChildItem -File 

Get-ChildItem -Attributes !Directory+Hidden
Get-ChildItem -Hidden
Get-ChildItem -ReadOnly
Get-ChildItem -System
Get-ChildItem -Hidden -ReadOnly





#-----------------------------------------------
Get-Command -CommandType Cmdlet
Get-Command -CommandType Function
Get-Command -CommandType Alias
 Get-Command -CommandType Application
  Get-Command -CommandType Workflow
  Get-Command -CommandType Filter
  Get-Command -CommandType Workflow
  Get-Command -CommandType Script


  Restart-Computer -ComputerName SomeServer -Wait

  Restart-Computer -ComputerName SomeServer -Wait -Timeout 60

  Restart-Computer -ComputerName Someserver -Wait -For PowerShell



#-----------------------------------------

Get-ChildItem -Path . -File 
Get-ChildItem -Path . -File |Measure-Object 
Get-ChildItem -Path . -File |Measure-Object -Property Length -Sum
$diskUsage = Get-ChildItem . -Recurse -File | Measure-Object -Property Length -Sum
$diskUsage.Sum/1GB
Get-Content .\testscore.txt
Get-Content .\testscore.txt | Measure-Object -Sum -Average -Minimum -Maximum


#--------------------
$rawfile= Get-Content -Raw .\testscore.txt 
$rawfile 
$rawfile.GetType()

#------------------------
#locking a computer 
rundll32.exe user32.dll,LockWorkStation

#-------------------------
#logging of the current session 
shutdown.exe -l

#using WMI(Windows Management Instrumentation) to shutdown
(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(0)

#shutting down or restarting a computer 
(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(1)

# restarting the operating system 
(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(2)

#-----------------------------
#listing desktop settings
Get-WmiObject -Class Win32_Desktop -ComputerName .

Get-WmiObject -Class Win32_Desktop -ComputerName . | Select-Object -Property [a-z]*
#---------------------
#Extracting BIOS Information 
Get-WmiObject -Class Win32_BIOS -ComputerName .

#Listing Processor Information 
Get-WmiObject -Class Win32_Processor -ComputerName . | Select-Object -Property [a-z]*

#SystemType Property 
Get-WmiObject -Class Win32_ComputerSystem -ComputerName . | Select-Object -Property SystemType 



# Listing Computer Manufacturer Model 
Get-WmiObject -Class Win32_ComputerSystem

#Listing Installed Hotfixes 
Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName .

Get-WmiObject -Class Win32_QuickFixEngineering -ComputerName . -Property HotFixId


# Listing Operating System Version Information 
Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property Build*,OSType,ServicePack*

#Listing Local Users and Owners
Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property NumberOfLicensedUsers,NumberOfUsers,RegisteredUser
Get-WmiObject -Class Win32_OperatingSystem -ComputerName . | Select-Object -Property *user*

# Computing the Disk Space Available for use 
Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -ComputerName .


#Getting Logon Session Information 
Get-WmiObject -Class Win32_LogonSession -ComputerName .

#Getting Local Time from a Computer 
Get-WmiObject -Class Win32_LocalTime -ComputerName . | Select-Object -Property [a-z]*


# Displaying Service Status 
Get-WmiObject -Class Win32_Service -ComputerName . | Select-Object -Property Status, Name, DisplayName 

Get-WmiObject -Class Win32_Service -ComputerName . | Format-Table -Property Status,Name,DisplayName -AutoSize -Wrap