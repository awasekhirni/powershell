###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#Listing Registry Entries 
# there are many different ways to examine registry entries 
# simplest way is to get the property names associated with a key 
 Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion | Select-Object -ExpandProperty Property

 ##########################
 #Get-ItemProperty 
 Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion


#Reading Registry Hives 
#Powershell treats the registry like a drive 
# Get-ChildItem to list the Registry key subkeys 
Get-ChildItem -Path HKLM:\software\microsoft\Windows
Get-ChildItem -Path HKLM:\, HKCU:\ -Include *PowerShell* -Recurse -ErrorAction SilentlyContinue

#Using Native Registry paths 
#HKCU - Virtual Drieves for HKEY_CURRENT_USER
#HKLM - HkEY_Local_Machine 
Get-ChildItem -Path Registry::HKEY_CLASSES_ROOT | Where-Object { $_.PSChildName -like ‘.*’ }
Get-ChildItem -Path  Registry::HKEY_CLASSES_ROOT\.* -Name

############
Renaming Registry Entries 
#To rename the powershell path entry to "PSHOME" 
Rename-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion -Name PowerShellPath -NewName PSHome




#########################################
#Reading Registry Values 
#Registry values in PowerShell are called "ItemProperties"
# Registy values are read using Get-ItemProperty 
Get-ItemProperty -Path ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion’
#Reading one particular registry value 


$allvalues = Get-ItemProperty -Path ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion’
$allvalues.RegisteredOwner
$allvalues.CSDVersion
$allvalues.CurrentVersion
‘Current User {0} is running Windows {1} with {2}’ -f $allvalues.RegisteredOwner, $allvalues.CurrentVersion, $allvalues.CSDVersion
$allvalues | Select-Object -Property RegisteredOwner, CurrentVersion, CurrentBuild, CSDVersion

#Reading Default values 
#Each Registry key has a default value. 
$extension = ‘.doc’
$allValues = Get-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\$extension
$allValues.’(Default)’


#Creating New Registry Keys 
New-Item -Path HKCU:\Software\Testkey
New-Item -Path HKCU:\Software\Testkey -Value ‘My default value’
New-Item -Path HKCU:\Software\Testkey\more\anotherone\finalkey -Force


#Creating or Changing Registry Values 
#Registry values in Powershell are called "ItemProperties" 
#New-ItemProperty 
#Set-ItemProperty

$RegKey = ‘HKCU:\Software\Testkey1’
$key = New-Item -Path $RegKey -Value ‘I am testing here’
$value1 = New-ItemProperty -Path $RegKey -Name ‘MyFirstValue’ -Value 123
$value2 = New-ItemProperty -Path $RegKey -Name ‘MySecondValue’ -Value ‘Hello World’


$RegKey = ‘HKCU:\Software\Testkey2’
$key = New-Item -Path $RegKey -Value ‘I am testing here’
Set-ItemProperty -Path $RegKey -Name ‘MyFirstValue’ -Value 123
Set-ItemProperty -Path $RegKey -Name ‘MySecondValue’ -Value ‘Hello World’

##################################
#Creating Registry Values with Type
#writing a registry value in specific registry data type 
$null = New-Item -Path HKCU:\Software\Testkey3
Set-ItemProperty -Path HKCU:\Software\Testkey3 -Name Testvalue -Value 1,2,3,4 -Type Binary

#Remove Registry Keys and Values 
#Remove-Item to actually delete a Registry Key 
# If the key contains subkeys, we use -Force to forcefully remove
Remove-Item -Path HKCU:\Software\Testkey3 -Force


#Listing Installed Software 
#Get-ItemProperty can read Registry Values, it also support wildcards 
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, UninstallString
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |Where-Object { $_.DisplayName } |
Select-Object DisplayName, DisplayVersion, Publisher, UninstallString | Out-GridView


$path1 = ‘HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*’
$path2 = ‘HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*’
$path3 = ‘HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*’
$path4 = ‘HKCU:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*’
Get-ItemProperty -Path $path1, $path2, $path3, $path4 | Where-Object { $_.DisplayName } |
Select-Object DisplayName, DisplayVersion, Publisher, UninstallString |Out-GridView

#################################
#Test Whether Registry Key Exists 
#testing whether a certain registry key exits

Test-Path -Path HKCU:\Software\Testkey
$RegPath = ‘HKCU:\Software\Testkey’
$exists = Test-Path -Path $RegPath
if ($exists -eq $false){
Write-Warning “Creating key $RegPath”
$null = New-Item -Path $RegPath -Force
    }
else{
    Write-Warning “Deleting key $RegPath”
    # Deleting is permanent! Remove -WhatIf to actually delete!
    # Make sure you delete the key you want, and not accidentally
    # something else. Make especially sure there is no typo
    # in your path variable, and the variable contains what you
    # intend to remove. If $RegPath was empty, then PowerShell
    # takes YOUR CURRENT PATH and depending on where you are,
    # could delete files, folders, or whatever. SO BE CAREFUL!
    Remove-Item -Path $RegPath -Force -Recurse -WhatIf
}

$isPDFViewerInstalled = Test-Path -Path Registry::HKEY_CLASSES_ROOT\.pdf

#################################################
#Test Whether Registry Value Exists 
#Registry values are treated like properties to a registry key 
# so they have no specific path and you cannot use Test-Path to check 
# whether a given Registry value exists 

$RegPath = ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion’
$ValueName = ‘RegisteredOwner’
$key = Get-Item -Path $RegPath
$exists = $key.GetValueNames() -contains $ValueName
“The value $valuename exists? $exists”

#Excluding Unwanted Registry Values 
#When you query the values of a registry key
#powershell will add a bunch of artifacts to the results 

$regkey = ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion’ 
Get-ItemProperty $regkey | Select-Object -Property *
Get-ItemProperty $regkey | Select-Object -Property * -ExcludeProperty PS*
$RegPath = ‘HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion’
$key = Get-Item -Path $RegPath
$values = $key.GetValueNames() | Sort-Object
Get-ItemProperty -Path $RegPath | Select-Object -Property $values


##Accessing Registry Remotely 
# Sometimes, we need to access Registry Keys and values on another machine

$ComputerName = ‘storage1’
# NOTE: RemoteRegistry Service needs to run on a target system!
$reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey(‘LocalMachine’, $ComputerName)
$key = $reg.OpenSubKey(‘SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall’)
$key.GetSubKeyNames() | ForEach-Object {
$subkey = $key.OpenSubKey($_)
$i = @{}
$i.Name = $subkey.GetValue(‘DisplayName’)
$i.Version = $subkey.GetValue(‘DisplayVersion’)
New-Object PSObject -Property $i
$subkey.Close()
}
$key.Close()
$reg.Close()



#List Registry Hives 
# Use the provider name of a drive name when you need to get a list of all registry hives
Get-ChildItem -Path Registry::
#Local Registry User Hive 
#Sometimes it is required to manipulate registry of another user 
#HKEY_CURRENT_USER always points to your own user data 
reg.exe /load HKU\Testuser c:\users\tom\ntuser.dat
Get-ChildItem -Path Registry::HKEY_USERS\Testuser\Software


#Copying Registry Hives 
#Copy-Item to quickly copy entier structure of Registry Keys and Subkeys in seconds
$source = ‘Registry::HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall’
$destination = ‘Registry::HKCU\Software\BackupCopy’
if ( (Test-Path -Path $destination) -eq $false){
New-Item -Path $destination
}
Copy-Item -Path $source -Destination $destination -Recurse


#Scanning Registry for ClassIDs
# Windows Registry is a repository fitted with various windows settings 
#Get-ItemProperty can read Registry values and accepts wildcards 
function Get-ClassID {
param($fileName = ‘vbscript.dll’)
Write-Warning ‘May take some time to produce results...’
Get-ItemProperty ‘HKLM:\Software\Classes\CLSID\*\InprocServer32’ |
Where-Object { $_.’(Default)’ -like “*$FileName” } |
ForEach-Object { if ($_.PSPath -match ‘{.*}’) { $matches[0] }
    }
}


#Enumerating Registry Keys with Style 
# To enumerate all subkeys in a registry key 
# Get-ChildItem 
Get-ChildItem -Path hkcu:\
Get-ChildItem -Path hkcu:\ -Recurse
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall | Select-Object -ExpandProperty PSPath
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall -Name | Select-Object -ExpandProperty PSPath
Resolve-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*
Resolve-Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object -ExpandProperty ProviderPath




#Getting Windows Product Key 
#Reading out windows license key 


function Get-ProductKey {
$map=”BCDFGHJKMPQRTVWXY2346789”
$value = (get-itemproperty “HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion”).
digitalproductid[0x34..0x42]
$ProductKey = “”
for ($i = 24; $i -ge 0; $i--) {
$r = 0
for ($j = 14; $j -ge 0; $j--) {
$r = ($r * 256) -bxor $value[$j]
$value[$j] = [math]::Floor([double]($r/24))
$r = $r % 24
    }
$ProductKey = $map[$r] + $ProductKey
if (($i % 5) -eq 0 -and $i -ne 0) {
$ProductKey = “-” + $ProductKey
    }
}
$ProductKey
}
# call the function
Get-ProductKey



#Extracting USB Drive Usage History 
# we can extract USB Storage History from your Registry 
# checking which drives were used in the past
$key = ‘Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR\*\*’
Get-ItemProperty $key |
    Select-Object -ExpandProperty FriendlyName |
    Sort-Object
