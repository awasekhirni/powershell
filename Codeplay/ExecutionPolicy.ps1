# to allow remote execution of the scripts 
Set-ExecutionPolicy RemoteSigned 

#Get-ExecutionPolicy  to retrieve the execution policy
Get-ExecutionPolicy


#System Adminstration Tasks 
Get-Service
Get-Service | Where-Object {$_.status -eq "stopped"}
Get-Service | Where-Object {$_.status -eq "running"}
Get-Service | Sort-Object status,displayname
Get-EventLog -list
Get-EventLog -list | Where-Object {$_.logdisplayname -eq "System"}
Get-EventLog system
Get-EventLog system -newest 3
Get-EventLog system -newest 3 | Format-List
Get-EventLog "Windows PowerShell" | Where-Object {$_.EventID -eq 403}
Get-EventLog "Windows PowerShell" | Group-Object eventid | Sort-Object Name


Resume-Service tapisrv
Resume-Service -DisplayName "telephony"



#Get-Culture to return language setting and locale information 
Get-Culture 


#To keep track of all commands typed in the console. 
Get-History
Get-History 32 -count 32 
$MaximumHistoryCount =150
#invoke the 3 command executed in the history 
Invoke-History 3
Get-History | Export-Clixml "E:\CT\Powershell\CodePlay\history.txt"
Import-Clixml "E:\CT\Powershell\CodePlay\my_history.xml" | Add-History


#Write warning cmdlet 
# is used to write a warning message to the screen 
Write-Warning "The Folder E:\CT\Powershell\CodePlay does not exist"

