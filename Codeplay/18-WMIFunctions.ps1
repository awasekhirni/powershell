###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

# WINDOWS MANAGEMENT INSTRUMENTATION WMI
# A service that seems to work much like a database 
# returns live data 
# use to find out details about physical and logical computer configuations
# remote working as well 


############
#Finding WMI Class Names 
Get-WmiObject -Class *Share* -List 
Get-WmiObject -Class Win32_Share 
# to display WMI Classes related to "Print"
Get-WmiObject -List | Select-String Print

#getting all WMI Classes and filter by keyword 
$Keyword = ‘disk’
Get-WmiObject -Class “Win32_*$Keyword*” -List |Where-Object { $_.Properties.Count -gt 5 -and $_.Name -notlike ‘*_Perf*’ }

# by Disk Partition
Get-WmiObject -Class Win32_DiskPartition



#Finding the most commonly used WMI Classes 
Select-Xml $env:windir\System32\WindowsPowerShell\v1.0\types.ps1xml -XPath /Types/Type/Name |
ForEach-Object { $_.Node.InnerXML } | Where-Object { $_ -like ‘*#root*’ } |
ForEach-Object { $_.Split(‘[\/]’)[-1] } | Sort-Object -Unique

#Windows BIOS Class 
# to extract bios information of the computer using WMI
Get-WmiObject -Class Win32_BIOS
Get-WmiObject Win32_BIOS | Select-Object * -First 1
Get-WmiObject Win32_BIOS | Get-Member 

#Checking Windows License Status 
Get-WmiObject SoftwareLicensingService 
Get-WmiObject SoftwareLicensingProduct | Select-Object -Property Description, LicenseStatus |Out-GridView


Get-WmiObject SoftwareLicensingProduct | Where-Object { $_.LicenseStatus -eq 1 } | Select-Object -Property Name, Description

#Listing All WMI Namespaces 
# WMI is organized into namespaces which work similar to subfolders 

Get-WmiObject -Query “Select * from __Namespace” -Namespace Root | Select-Object -ExpandProperty Name
Get-WmiObject -NameSpace root\SecurityCenter2 -List



#Listing PowerPlans 
# for CPU intensive tasks we would like to switch to High Performance power plan. 

# save current power plan
$PowerPlan = (Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter ‘isActive=True’).ElementName 
“Current power plan: $PowerPlan”
# turn on high performance power plan
(Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter ‘ElementName=”High Performance”’).Activate()
# do something
‘Power plan now is High Performance!’
Start-Sleep -Seconds 3
# turn power plan back to what it was before
(Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter “ElementName=’$PowerPlan’”).Activate()
“Power plan is back to $PowerPlan”



# Determining the Service start Modes 
# Using WMI we can enumerate the start mode for the services to use 

# instead of using services.msc you can list the services using
Get-WmiObject Win32_Service | Select-Object Name, StartMode
([wmi]’Win32_Service.Name=”Spooler”’).StartMode


# Identifying Computer Hardware 
# Extracting hard drive serial number 
# it provides a unique identifier unless the hard drive is exchanged
Get-WmiObject -Class Win32_DiskDrive | Select-Object -ExpandProperty SerialNumber
#alternatively - this gives the ID when Windows uses to identify computers when booting 
Get-WmiObject -Class Win32_ComputerSystemProduct | Select-Object -ExpandProperty UUID



# Extracting information about logged on users 
$ComputerName = ‘localhost’
Get-WmiObject Win32_ComputerSystem -ComputerName $ComputerName |Select-Object -ExpandProperty UserName


# Extracting information about all logged on users 
$ComputerName = ‘localhost’
Get-WmiObject Win32_Process -Filter ‘name="explorer.exe"’ -Computername $ComputerName | ForEach-Object { $owner = $_.GetOwner(); ‘{0}\{1}’ -f $owner.Domain, $owner.User } |Sort-Object -Unique

#Finding IP and Mac Addresses of the machine 

Get-WmiObject Win32_NetworkAdapter -Filter ‘NetConnectionStatus=2’

function Get-NetworkConfig {
Get-WmiObject Win32_NetworkAdapter -Filter ‘NetConnectionStatus=2’ |
ForEach-Object {
    $result = 1 | Select-Object Name, IP, MAC
    $result.Name = $_.Name
    $result.MAC = $_.MacAddress
    $config = $_.GetRelated(‘Win32_NetworkAdapterConfiguration’)
    $result.IP = $config | Select-Object -ExpandProperty IPAddress
    $result
    }
}
Get-NetworkConfig



#Finding Services and Filtering Results
# service throwing error certificates not installed??
Get-WmiObject Win32_Service -Filter ‘Description like “%cert%”’| Select-Object Caption, StartMode, State, ExitCode


#Server-Side Filtersing 
#minimize resources and maximize speed by using server-side filtering
Get-WmiObject Win32_Service |
    Where-Object {$_.Started -eq $false} |
    Where-Object { $_.StartMode -eq ‘Auto’} |
    Where-Object { $_.ExitCode -ne 0} |
    Select-Object Name, DisplayName, StartMode, ExitCode

    #//not working Equivalent
Get-WmiObject -Query (‘select Name, DisplayName, StartMode, ‘ + ‘ExitCode from Win32_Service where Started=false ‘ + ‘and StartMode=”Auto” and ExitCode<>0’)

#Removing Empty Results 
Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress }

#Extracting IPV4 Address using WMI 
Get-WmiObject Win32_NetworkAdapterConfiguration |
    Where-Object { $_.IPEnabled -eq $true } |
    ForEach-Object { $_.IPAddress } |
    ForEach-Object { [IPAddress]$_ } |
    Where-Object { $_.AddressFamily -eq ‘InterNetwork’ } |
    ForEach-Object { $_.IPAddressToString }


#Finding Unused Drives 
Get-WmiObject Win32_LogicalDisk | Select-Object -Property *
Get-WmiObject Win32_LogicalDisk |
    Select-Object -Property DeviceID, Description, FileSystem, Providername

$drives = Get-WmiObject Win32_LogicalDisk |ForEach-Object { $_.DeviceID }

#Listing Local Groups 
Get-WmiObject Win32_Group -Filter “domain=’$env:computername’” | Select-Object Name,SID

#checking battery status of the computer 
Function Test-Battery{
if ((Get-WmiObject Win32_Battery))
    {
    $true
    }
    else
    {
    $false
    }
}
Test-Battery



# Displaying Battery Charge in your prompt 
Function BatterCharge-Display{
    $charge = (Get-WmiObject Win32_Battery |
    Measure-Object -Property EstimatedChargeRemaining -Average).Average
    $prompt = “PS [$charge%]> “
    if ($charge -lt 30){
    Write-Host $prompt -ForegroundColor Red -NoNewline
    }
    elseif ($charge -lt 60)
    {
    Write-Host $prompt -ForegroundColor Yellow -NoNewline
    }
    else
    {
    Write-Host $prompt -ForegroundColor Green -NoNewline
    }
    $Host.UI.RawUI.WindowTitle = (Get-Location)
    ‘ ‘
}
BatterCharge-Display

#Extracting Estimated ChargeTime 
Get-WmiObject Win32_Battery
Get-WmiObject Win32_Battery | Measure-Object EstimatedChargeRemaining -Average
(Get-WmiObject Win32_Battery | Measure-Object EstimatedChargeRemaining -Average).Average


#Finding Computer Serial Number 
$serial = Get-WmiObject Win32_SystemEnclosure | Select-Object -ExpandProperty serialnumber
“Computer serial number: $serial”


#Renaming Computer
$serial = Get-WmiObject Win32_SystemEnclosure | Select-Object -ExpandProperty serialnumber
if ($serial -ne ‘None’) {
    $computer = Get-WmiObject Win32_ComputerSystem
    $computer.Rename(“DESKTOP_$serial”)
    } else {
    Write-Warning ‘Computer has no serial number’
 }


 #Use WMI and WQL
 Get-WmiObject -List Win32_*network*
 Get-WmiObject Win32_NetworkAdapterConfiguration
 Get-WmiObject -Query ‘Select * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled=True’

 #Accesing Individual Files and Folders Remotely via WMI 
 # missing parameters not working 
 Get-WmiObject Win32_Directory -Filter ‘Drive=”C:” and Path=”\\”’ | Select-Object -ExpandProperty Name
 Get-WmiObject CIM_DataFile -Filter ‘Drive=”C:” and Path=”\\Windows\\” and Extension=”log”’| Select-Object -ExpandProperty Name


 #Detect DHCP State 
 $number = Get-WmiObject Win32_NetworkAdapterConfiguration -Filter ‘IPEnabled=true and
DHCPEnabled=true’ |
    Measure-Object |
    Select-Object -ExpandProperty Count
“There are $number NICs with DHCP enabled”
$DHCPEnabled = $number -gt 0
“DHCPEnabled? $DHCPEnabled"


#Map Network Drive 
function New-MapDrive {
    param($Path)
    $present = @(Get-WmiObject Win32_Networkconnection |
    Select-Object -ExpandProperty RemoteName)
    if ($present -contains $Path)
    {
    “Network connection to $Path is already present”
    }
    else
    {
    net use * $Path
    }
}


# Using WMI to create Hardware Inventory
Get-WmiObject -Class CIM_LogicalDevice |
    Select-Object -Property Caption, Description, __Class

Get-WmiObject -Class Win32_PnPEntity |
    Select-Object Name, Service, ClassGUID |
    Sort-Object ClassGUID

# Extracting Video Resolution
Function Get-Resolution{
    param
    (
    [Parameter(ValueFromPipeline=$true)]
    [Alias(‘cn’)]
    $ComputerName = $env:COMPUTERNAME
    )
Process{
    Get-WmiObject -Class Win32_VideoController -ComputerName $Computername |
    Select-Object *resolution*, __SERVER
    }
}
Get-Resolution



# Extracting System UpTime Information
$os = Get-WmiObject -Class Win32_OperatingSystem
$boottime = [System.Management.ManagementDateTimeConverter]::ToDateTime($os.LastBootupTime)
$timedifference = New-TimeSpan -Start $boottime
$days = $timedifference.TotalDays
‘Your system is running for {0:0.0} days.’ -f $days



#Extracting Free Space on Disks
Get-WmiObject Win32_LogicalDisk |
    ForEach-Object {
    ‘Disk {0} has {1:0.0} MB space available’ -f $_.Caption, ($_.FreeSpace / 1MB)
    }



# Backing up Event Log Files 
Get-WmiObject Win32_NTEventLogFile |
    ForEach-Object {
    $filename = “$home\” + $_.LogfileName + ‘.evtx’
    Remove-Item $filename -ErrorAction SilentlyContinue
    $null = $_.BackupEventLog($filename).ReturnValue
    }


#Disabling Automatic Page Files 
# Please do not run this. Just understand it 
$computer = Get-WmiObject Win32_ComputerSystem -EnableAllPrivileges
$computer.AutomaticManagedPagefile = $false


# Get Running Process Owners 
Get-WmiObject Win32_Process |
    ForEach-Object {
    $ownerraw = $_.GetOwner();
    $owner = ‘{0}\{1}’ -f $ownerraw.domain, $ownerraw.user;
    $_ | Add-Member NoteProperty Owner $owner -PassThru
    } |
    Select-Object Name, Owner

#listing Processes and Process Ownership
## need to rewrite not working
Function Get-ProcessEx{
    param
    (
    $Name=’*’,
    $ComputerName,
    $Credential
    )
$null = $PSBoundParameters.Remove(‘Name’)
$Name = $Name.Replace(‘*’,’%’)
Get-WmiObject -Class Win32_Process @PSBoundParameters -Filter “Name like ‘$Name’” |
    ForEach-Object {
    $result = $_ | Select-Object Name, Owner, Description, Handle
    $Owner = $_.GetOwner()
    if ($Owner.ReturnValue -eq 2)
    {
    $result.Owner = ‘Access Denied’
    }
    else
    {
    $result.Owner = ‘{0}\{1}’ -f ($Owner.Domain, $Owner.User)
    }
    $result
    }
}

Get-ProcessEx power*.exe


#alternatively Get Process Owners 
$processes = Get-WmiObject Win32_Process -Filter “name like ‘power%.exe’”
$appendedprocesses = ForEach ($process in $processes)    {
    Add-Member -MemberType NoteProperty -Name Owner -Value (
    $process.GetOwner().User) -InputObject $process -PassThru
    }
$appendedprocesses | Select-Object -Property name, owner



#Computing the MEMORY RAM 
$memorytype = ‘Unknown’, ‘Other’, ‘DRAM’, ‘Synchronous DRAM’, ‘Cache DRAM’,
    ‘EDO’, ‘EDRAM’, ‘VRAM’, ‘SRAM’, ‘RAM’, ‘ROM’, ‘Flash’, ‘EEPROM’, ‘FEPROM’,
    ‘EPROM’, ‘CDRAM’, ‘3DRAM’, ‘SDRAM’, ‘SGRAM’, ‘RDRAM’, ‘DDR’, ‘DDR-2’
$formfactor = ‘Unknown’, ‘Other’, ‘SIP’, ‘DIP’, ‘ZIP’, ‘SOJ’, ‘Proprietary’,
    ‘SIMM’, ‘DIMM’, ‘TSOP’, ‘PGA’, ‘RIMM’, ‘SODIMM’, ‘SRIMM’, ‘SMD’, ‘SSMP’,
    ‘QFP’, ‘TQFP’, ‘SOIC’, ‘LCC’, ‘PLCC’, ‘BGA’, ‘FPBGA’, ‘LGA’
$col1 = @{Name=’Size (GB)’; Expression={ $_.Capacity/1GB } }
$col2 = @{Name=’Form Factor’; Expression={$formfactor[$_.FormFactor]} }
$col3 = @{Name=’Memory Type’; Expression={ $memorytype[$_.MemoryType] } }
Get-WmiObject Win32_PhysicalMemory | Select-Object BankLabel, $col1, $col2, $col3


#Creating HTML System Reports 

$style = @’
<style>
body { background-color:#EEEEEE; }
body,table,td,th { font-family:Tahoma; color:Black; Font-Size:10pt }
th { font-weight:bold; background-color:#AAAAAA; }
td { background-color:white; }
</style>
‘@
& {
“<HTML><HEAD><TITLE>Inventory Report</TITLE>$style</HEAD>”
“<BODY><h2>Report for ‘$env:computername’</h2><h3>Services</h3>”
Get-Service |
Sort-Object Status, DisplayName |
ConvertTo-Html DisplayName, ServiceName, Status -Fragment
‘<h3>Operating System Details</h3>’
Get-WmiObject Win32_OperatingSystem |
Select-Object * -ExcludeProperty __* |
ConvertTo-Html -As List -Fragment
‘<h3>Installed Software</h3>’
Get-ItemProperty
Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\* |
Select-Object DisplayName, InstallDate, DisplayVersion, Language |
Sort-Object DisplayName | ConvertTo-Html -Fragment
‘</BODY></HTML>’
} | Out-File $env:temp\report.hta
Invoke-Item $env:temp\report.hta


#creating HTML Reports
$head = ‘
<style>
BODY {font-family:Verdana; background-color:lightblue;}
TABLE {border-width: 1px;border-style: solid;border-color: black;border-collapse: collapse;}
TH {font-size:1.3em; border-width: 1px;padding: 2px;border-style: solid;border-color:
black;background-color:#FFCCCC}
TD {border-width: 1px;padding: 2px;border-style: solid;border-color: black;background-color:yellow}
</style>’
$header = ‘<H1>Last 24h Error Events</H1>’
$title = ‘Error Events Within 24 Hrs’
‘127.0.0.1’ | ForEach-Object {
    $time = [System.Management.ManagementDateTimeConverter]::ToDmtfDateTime((Get-Date).AddHours(-24))
    Get-WmiObject Win32_NTLogEvent -ComputerName $_ -Filter “EventType=1 and TimeGenerated>=’$time’” |
        ForEach-Object {$_ | Add-Member NoteProperty TimeStamp (
        [System.Management.ManagementDateTimeConverter]::ToDateTime($_.TimeWritten)) ; $_
        }
    } | Select-Object __SERVER, LogFile, Message, EventCode, TimeStamp | ConvertTo-Html -Head $head -Body $header -Title $title |  Out-File $home\report.htm 
    
    Invoke-Item “$home\report.htm”


###alternatively html report function
Function Get-SystemReport{
    param
    (
    $ComputerName = $env:ComputerName
    )
    $htmlStart = “
    <HTML><HEAD><TITLE>Server Report</TITLE>
    <style>
    body { background-color:#EEEEEE; }
    body,table,td,th { font-family:Tahoma; color:Black; Font-Size:10pt }
    th { font-weight:bold; background-color:#AAAAAA; }
    td { background-color:white; }
    </style></HEAD><BODY>
    <h2>Report listing for System $Computername</h2>
    <p>Generated $(Get-Date -Format ‘yyyy-MM-dd hh:mm’) </p>
    “
    $htmlEnd = ‘</body></html>’
    $htmlStart
        Get-WmiObject -Class CIM_PhysicalElement |
        Group-Object -Property __Class |
        ForEach-Object {
        $_.Group |
        Select-Object -Property * |
        ConvertTo-Html -Fragment -PreContent (‘<h3>{0}</h3>’ -f $_.Name )
        }
    $htmlEnd
}

$path = “$env:temp\report.hta”
Get-SystemReport | Out-File -Filepath $path
Invoke-Item $path



