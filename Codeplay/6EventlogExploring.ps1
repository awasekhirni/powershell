###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
Get-EventLog -List 
#showing all the events in a specific log -Application
Get-EventLog -LogName Application
#showing all  the events in a specific log -Security 
Get-EventLog -LogName Security 
#Showing all events in the application event log that are older than 7 days 
Get-EventLog -LogName Application -Before (Get-Date).AddDays(-7)
#events before 1 day 
Get-EventLog -LogName Application -After(Get-Date).AddDays(-1)
#list all error application log 
Get-EventLog -LogName Application -EntryType Error
#list all event logs from a remote computer 
Get-EventLog -LogName Application -ComputerName SomeComputer
#list all applications event log containing specific words in the message 
Get-EventLog -LogName Application -Message "*Could not find*"


##########################
# .NET Framework class library includes a class named System.Diagnostics.Eventlog 
New-Object -TypeName System.Diagnostics.EventLog
New-Object -TypeName System.Diagnostics.EventLog -ArgumentList Application

# Storing a reference to an object, so that you can use it in the current shell
# PS lets you create variables that are essentially named objects 
# variable names always begin with $. 
$AppLog = New-Object -TypeName System.Diagnostics.EventLog -ArgumentList Application 


#Accessing a Remote Event Log with New-Object 
$RemoteAppLog = New-Object -TypeName System.Diagnostics.EventLog Application, 192.168.1.1


#Clearing an Event Log with Object Methods 
$RemoteAppLog | Get-Member -MemberType Method 

# to clear the event log 
$RemoteAppLog.Clear()

# to create a com object with new-object 
New-Object -ComObject WScript.shell
New-Object -ComObject WScript.Network 
New-Object -ComObject Scripting.Dictionary
New-Object -ComObject Scripting.FileSystemObject


#Objects 
$a = 1,2,"three"
Get-Member -InputObject $a


#Using IE from Windows Powershell 
$ie = New-Object -ComObject InternetExplorer.Application 
// to run ie 
$ie.Visible = $true
// to navigate to a specific web address by using the navigate method
$ie.Navigate("http://www.territorialprescience.com")
# to possibly retrieve text content from the Web page 
$ie.Document.Body.InnerText 
#to close InternetExplorer from with in Powershell 
$ie.Quit()

// to remove the varibale ie 
Remove-Variable ie 




