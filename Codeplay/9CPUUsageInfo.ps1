###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
#############################################################################
# Option A: This is if you just have the name of the process; partial name OK
$ProcessName = “TeamViewer”

# Option B: This is for if you just have the PID; it will get the name for you
#$ProcessPID = “10544”

#$ProcessName = (Get-Process -Id $ProcessPID).Name
$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors
$Samples = (Get-Counter “\Process($Processname*)\% Processor Time”).CounterSamples
$Samples | Select `
InstanceName,
@{Name=”CPU %”;Expression={[Decimal]::Round(($_.CookedValue / $CpuCores), 2)}}
#############################################################################
#getting performance counter data for local/remote machines.
Get-Counter -ListSet *
#listing all the sets of counters that are available to be used
Get-Counter -ListSet *| Sort-Object CounterSetName |Format-Table CounterSetName
#Processor Object List 
Get-Counter -ListSet Processor



