###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
# Add a local computer to a domain then restart the computer
Add-Computer -DomainName "Domain01" -Restart
#Add a local computer to a workgroup 
Add-Computer -WorkgroupName "WorkGroup-A"
#Add a local computer to a domain
Add-Computer -DomainName "Domain01" -Server "Domain00X" -PassThru -verbose 
#Adding a computer using 0Upath Parameter
Add-Computer -DomainName "Domain02" -OUPath "OU=testOU,DC=domain,DC=Domain,DC=com"
#Moving group of computers to a new domain 
Add-Computer -ComputerName "Server01", "Server02", "localhost" -Domain "Domain02" -LocalCredential Domain01User01 -UnjoinDomainCredential Domain01Admin01 -Credential Domain02Admin01 -Restart
#move a computer to a new domain and change the name of the computer 
Add-Computer -ComputerName "Server01" -Domain "Domain02" -NewName "Server044" -Credential Domain02Admin01 -Restart
#Add computers listed in a file to a new domain 
Add-Computer -ComputerName (Get-Content Servers.txt) -Domain "Domain02" -Credential Domain02Admin02 -Options Win9XUpgrade -Restart
###############
###Remove-Computer
#removing the local computer from its domain 
Remove-Computer -UnjoinDomainCredential Domain01Admin01 -PassThru -Verbose -Restart
#Move several computers to a legacy workgroup
Remove-Computer -ComputerName (Get-Content oldServers.txt) -LocalCredential Domain01Admin01 -UnjoinDomainCredential Domain01Admin01 -WorkgroupName "Legacy" -Force -Restart
#Removing computers from a workgroup without confirmation 
Remove-Computer -ComputerName "Server01", "localhost" -UnjoinDomainCredential Domain01Admin01 -WorkgroupName "local" -Restart -Force 
################
#Rename-Computer
#renaming the local computer 
Rename-Computer -NewName "Server044" -DomainCredential Domain01Admin01 -Restart
#Rename a remote computer 
Rename-Computer -ComputerName "Srv01" -NewName "Sever001" -LocalCredential Srv01Admin01 -DomainCredential Domain01Admin01 -Force -PassThru -Restart 
# renaming multiple computers 
$a = Import-Csv ServerNames.csv -Header OldName, NewName 
Foreach($Server in $a){
    Rename-Computer -ComputerName $Server.oldName -NewName $Server.NewName -DomainCredential Domain01Admin01 -Force -Restart
    }
#Resetting Computer Machine password
#Reset-ComputerMachinePassword
#Reset the password for the local computer 
Reset-ComputerMachinePassword 
#Reset the password for the local computer by using a specified domain controller 
Reset-ComputerMachinePassword -Server "DC01" -Credential Domain01Admin01
#Reset the password on a remote computer 
Invoke-Command -ComputerName "Server01" -ScriptBlock {Reset-ComputerMachinePassword}
##################
#Restore-Computer
#Restore the local computer 
Restore-Computer -RestorePoint 253 
#Restore the local computer with confirmation 
Restore-Computer -RestorePoint 255 -confirm 
#Restore a computer and the check the status 
Get-ComputerRestorePoint
Restore-Computer -RestorePoint 255
Get-ComputerRestorePoint -LastStatus

################
##Checkpoint-computer 
## creating a system restore point 
Checkpoint-Computer -Description "Install MyApp" 
Checkpoint-Computer -Description "ChangeNetSettings" -RestorePointType MODIFY_SETTINGS

################
#Stop or shutdown computer 
#stop-Computer 
#shutdown the computer 
Stop-Computer 
#shutdown two remote computers and the local computer 
Stop-Computer -ComputerName "Server01", "Server02","localhost"
#shutdown remote computer as background job
$j = Stop-Computer -ComputerName "Server01", "Server02", -AsJob
$results =$j |Receive-Job
$results
#shut down a remote computer 
Stop-Computer -ComputerName "Server01" -Impersonation annonymous - Authentication PacketIntegrity
#These commands force an immediate shut down of all the computers in Domain01 
$s=Get-Content Domains01.txt 
$c=Get-Credential domain01admin01
Stop-Computer -ComputerName $s -Force -ThrottleLimit 10 -Credential $c
#Test-Connection 
#sending echo requetst to a remote computer 
Test-Connection "Server01"
#sending echo requests to several computers 
Test-Connection -ComputerName "Server01", "Server02","Server03"
#send echo requests from several computers to a computer 
Test-Connection -Source "Server02", "Server12", "localhost" -ComputerName "Server01" -Credential Domain01Admin01
#customize the test command 
 Test-Connection -ComputerName "Server01" -Count 3 -Delay 2 -TTL 255 -BufferSize 256 -ThrottleLimit 32
 #Run a test as background job
  $job = Test-Connection -ComputerName (Get-Content "Servers.txt") -AsJob
  if ($job.JobStateInfo.State -ne "Running") {$Results = Receive-Job $job}

