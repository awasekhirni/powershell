###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
###Discovering Objects and Types in Powershell

$a=1 
$a.GetType().FullName 
$pi=3.145679
$pi.GetType().FullName
$lno = 324123123123123123
$lno.GetType().FullName
$sak ="Syed Awase Khirni"
$sak.GetType().FullName
$sakDOB = Get-Date
$sakDOB.GetType().FullName
[Int32]::MaxValue
[Int64]::MaxValue
[Byte]::MaxValue
[UInt32]::MaxValue
[Int32]::MinValue
[Int64]::MinValue
[UInt64]::MinValue

[Byte]$myval = 100
$myval.GetType().FullName


[Char]65
[Byte][Char]'A'
[Byte[]][Char[]]'Syed'
[Char[]](65..90)

[System.Net.Mail.MailAddress]'SyedAwase<awasekhirni@gmail.com>'
[System.Net.IPAddress]'192.168.2.1'
[System.Version]'10.1.3.22'

#chaining type conversion 
[Byte[]][Char[]]"Syed Awase"

$ByteArray = [Byte[]][Char[]]’MyProduct’
$null = New-Item -Path HKCU:\Software\Test -Force
Set-ItemProperty HKCU:\Software\Test ProductName -Type Binary -Value $ByteArray


#sorting objects 
1,10,12,12,13,1313,12312 |Sort-Object
'1','10','22','33','44' |Sort-Object 


#Using Converter Class 

$myval =[System.Convert]::ToByte(123)

$myval.GetType().FullName
$uvalue =[System.Convert]::TouInt64(714)
$uvalue.GetType().FullName

#binary string representation 
[System.Convert]::ToString(78778,2)
#hex string representation 
[System.Convert]::ToString(123,16)
#octal string representation 
[System.Convert]::ToString(123,8)

$binary = ‘1110111000010001’
[System.Convert]::ToInt64($binary,2)

0xFFFF
[BitConverter]::ToInt16([BitConverter]::GetBytes(0xFFFF), 0)

###
#OS Information 
[System.Environment]::OSVersion
[System.Environment]::OSVersion.ServicePack
[System.Environment]::OSVersion.Version
[System.Environment]::Is64BitOperatingSystem
[System.Environment]::Is64BitProcess
[System.Environment]::MachineName
[System.Environment]::TickCount
$start = [System.Environment]::TickCount
Start-Sleep -Seconds 2
$end = [System.Environment]::TickCount
$duration = $end-$start
“Milliseconds: $duration ms”

[System.Environment]::SetEnvironmentVariable(‘test’,’hello’,’user’)
[System.Enum]::GetNames([System.EnvironmentVariableTarget])
[System.Environment]::GetFolderPath
[System.Enum]::GetNames([System.Environment+SpecialFolder])
[System.Environment]::GetFolderPath(‘CommonMusic’)



#############################################
#Resolving Host Name 
[System.Net.Dns]::GetHostByName(‘microsoft.com’)
[System.Net.Dns]::GetHostByAddress(‘10.10.12.100’)
[System.Net.Dns]::GetHostByName()



#########################
#Generating a GUID
[System.Guid]::NewGuid().ToString()
[System.Guid]::NewGuid().ToString()
[System.Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()


############################
#Finding Existing Enumeration Data Types

[AppDomain]::CurrentDomain.GetAssemblies() |
ForEach-Object { trap{continue} $_.GetExportedTypes() } |
Where-Object { $_.isEnum } |
Sort-Object FullName |
ForEach-Object {
$values = [System.Enum]::GetNames($_) -join ‘,’
$rv = $_ | Select-Object -Property FullName, Values
$rv.Values = $values
$rv
}


####################################
#Listing Windows Updates 

$Session = New-Object -ComObject Microsoft.Update.Session
$Searcher = $Session.CreateUpdateSearcher()
$HistoryCount = $Searcher.GetTotalHistoryCount()
if ( $HistoryCount -gt 0)
{
$Searcher.QueryHistory(1,$HistoryCount) |
Select-Object Date, Title, Description
}


#####################################
#Useful .Net Types Listing 
$typename = ‘System.Management.Automation.TypeAccelerators’
$shortcut = [PSObject].Assembly.GetType($typename)::Get
$shortcut.Keys |
Sort-Object |
ForEach-Object { “[$_]” }


# Sorting Objects 
Get-WmiObject -Class Win32_SystemDriver | Sort-Object -Property State,Name | Format-Table -Property Name,State,Started,DisplayName -AutoSize -Wrap
Get-WmiObject -Class Win32_SystemDriver | Sort-Object -Property State,Name -Descending | Format-Table -Property Name,State,Started,DisplayName -AutoSize -Wrap

#select-Object -> to create new custom Windows PowerShell Objects that contain properties selected from the objects you use to create them
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace| Get-Member
Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property Name,FreeSpace | ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1024.0/1024.0; $_}



#Working with Custom Objects 
Get-ChildItem E:\CT\Powershell\CodePlay\baseball.txt | Sort-Object Length
$colStats = Import-CSV E:\CT\Powershell\CodePlay\baseball.txt
foreach($objBatter in $colStats){
    $objBatter.Name + " {0:N3}" -f ([int] $objBatter.Hits / $objBatter.AtBats)
}

## Computing Averages 
$colAverages = @()
$colStats = Import-CSV E:\CT\Powershell\CodePlay\baseball.txt
foreach ($objBatter in $colStats)
  {
    $objAverage = New-Object System.Object
    $objAverage | Add-Member -type NoteProperty -name Name -value $objBatter.Name
    $objAverage | Add-Member -type NoteProperty -name BattingAverage -value ("{0:N3}" -f ([int] $objBatter.Hits / $objBatter.AtBats))
    $colAverages += $objAverage
  }

$colAverages | Sort-Object BattingAverage -descending

#Repeating a task for multiple objects 
#ForEach-Object 
Get-WmiObject -Class Win32_LogicalDisk 

Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object -Process {($_.FreeSpace)/1024.0/1024.0}

Get-WmiObject -Class Win32_LogicalDisk | ForEach-Object -Process {$_.FreeSpace = ($_.FreeSpace)/1024.0/1024.0}