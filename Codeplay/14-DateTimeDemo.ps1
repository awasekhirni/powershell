###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

##1-Getting Weekdays and Current Month 
#Get-Date 
Get-Date -Format ‘M’
Get-Date -Format ‘MM’
Get-Date -Format ‘MMM’
Get-Date -Format ‘MMMM’
Get-Date -Format 'd/M/y/h:m:s'
Get-Date -Format 'd/M/y/H:m:s'

#2-Filtering Day of the Week 

Function Get-Weekend{
    (Get-Date).DayOfWeek -gt 5
}

if(Get-Weekend){
    'No Service at Weekends'
    }Else{
    'Servicing you on Weekdays'
    }


#3-Prompting WorkHours
function prompt {
    $work = [Int] ((New-TimeSpan (Get-Process -Id $pid).StartTime).TotalMinutes)
    “$work min> “
    $host.UI.RawUI.WindowTitle = (Get-Location)
    }


#Display in hours 
    function hourprompt {
    $work = [Int] ((New-TimeSpan (Get-Process -Id $pid).StartTime).TotalHours)
    ‘{0:0.0}h > ‘ -f $work
    $host.UI.RawUI.WindowTitle = (Get-Location)
}

#4-Calculating Time Differences 
(New-TimeSpan 2016-12-25).Days
$days = (New-TimeSpan -End 2016-12-25).Days
“$days days to go until next Christmas”


#5-UsingRelative Dates 
(Get-Date)-(New-TimeSpan -Days 2)
(Get-Date).AddDays(-2)
Get-EventLog -LogName System -EntryType Error -After (Get-Date).AddHours(-12)


#6-Finding out DateTime Methods 
Get-Date | Get-Member -MemberType *Method
(Get-Date) - (New-TimeSpan -Days 10)
(Get-Date).AddDays(-10)

#TimeSpan
[TimeSpan]100
[TimeSpan]5d

#7- Getting short dates 
(Get-Date).ToShortDateString()
#finding leap years 
[DateTime]::IsLeapYear(1904)
[DateTime]::DaysInMonth(2013,2)
[DateTime]::DaysInMonth(2014,2)
[DateTime]::DaysInMonth(2016,2)

#Extracting Time Zones 
((Get-Date).ToUniversalTime()).AddHours(8)



#8-Converting Unix Time 
$Path = ‘HKLM:\Software\Microsoft\Windows NT\CurrentVersion’
Get-ItemProperty -Path $Path | Select-Object -ExpandProperty InstallDate

#Convert from UnixTime 

function ConvertFrom-UnixTime {
    param(
    [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
    [Int32]
    $UnixTime
    )
    begin {
    $startdate = Get-Date –Date ‘01/01/1970’
    }
    process {
    $timespan = New-TimeSpan -Seconds $UnixTime
    $startdate + $timespan
    }
}

$Path = ‘HKLM:\Software\Microsoft\Windows NT\CurrentVersion’
Get-ItemProperty -Path $Path | Select-Object -ExpandProperty InstallDate | ConvertFrom-UnixTime

$Path = ‘HKLM:\Software\Microsoft\Windows NT\CurrentVersion’
Get-ItemProperty -Path $Path | Select-Object -ExpandProperty InstallDate | ConvertFrom-UnixTime |New-TimeSpan | Select-Object -ExpandProperty Days

#13-Counting Work Days
#computing the number of working days in a month
function Get-Weekday {
    param(
    $Month = $(Get-Date -Format ‘MM’),
    $Year = $(Get-Date -Format ‘yyyy’),
    $Days = 1..5
    )
$MaxDays = [System.DateTime]::DaysInMonth($Year, $Month)
1..$MaxDays | ForEach-Object {
Get-Date -Day $_ -Month $Month -Year $Year | Where-Object { $Days -contains $_.DayOfWeek }
 }
}

Get-Weekday | Measure-Object | Select-Object -ExpandProperty Count
Get-Weekday -Days ‘Saturday’, ‘Sunday’ | Measure-Object | Select-Object -ExpandProperty Count
Get-Weekday -Days 'Monday'


#14-Extracting Time Zone information 
[System.TimeZoneInfo]::GetSystemTimeZones()
[System.TimeZoneInfo]::Local

#15-Parsing Date and Time 
$dobdate='5/3/1975'
[DateTime]$dobdate
[DateTime]::Parse($dobdate)

#16-localized Day Names 
[System.Enum]::GetNames([System.DayOfWeek])
0..6 | ForEach-Object{
    [Globalization.DatetimeFormatInfo]::CurrentInfo.Daynames[$_]
}

0..11 | ForEach-Object {
[Globalization.DatetimeFormatInfo]::CurrentInfo.MonthNames[$_]
}

#17-Alert for lunch time 
function lunchtimePrompt {
    $lunchtime = Get-Date -Hour 12 -Minute 30
    $timespan = New-TimeSpan -End $lunchtime
    [Int]$minutes = $timespan.TotalMinutes
switch ($minutes) {
    { $_ -lt 0 } { $text = ‘Lunch is over. {0}’; continue }
    { $_ -lt 3 } { $text = ‘Prepare for lunch! {0}’ }
    default { $text = ‘{1} minutes to go... {0}’ }
    }
‘PS> ‘
$Host.UI.RawUI.WindowTitle = $text -f (Get-Location), $minutes
if ($minutes -lt 3) { [System.Console]::Beep() }
}


#18-Testing Numbers and Dates 
function Test-Numeric($Value) { ($Value -as [Int64]) -ne $null }
function Test-Date($Value) { ($Value -as [DateTime]) -ne $null }
function Test-IPAddress($Value) { ($Value -as [System.Net.IPAddress]) -ne $null -and ($Value -as
[Int]) -eq $null }
[DateTime]::Parse('5/3/1975')

#19-Adding Clock to PowerShell Console

function Add-Clock {
$code = {
$pattern = ‘\d{2}:\d{2}:\d{2}’
    do {
    $clock = Get-Date -Format ‘HH:mm:ss’
    $oldtitle = [system.console]::Title
    if ($oldtitle -match $pattern) {
    $newtitle = $oldtitle -replace $pattern, $clock
    } else {
    $newtitle = “$clock $oldtitle”
    }
[System.Console]::Title = $newtitle
Start-Sleep -Seconds 1
    } while ($true)
}

$ps = [PowerShell]::Create()
$null = $ps.AddScript($code)
$ps.BeginInvoke()
}
Add-Clock

########################

#Using Culture
$culture = New-Object System.Globalization.CultureInfo(“ja-JP”)
[System.Globalization.CultureInfo]::GetCultures(‘InstalledWin32Cultures’)