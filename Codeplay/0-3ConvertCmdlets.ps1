###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
Get-EventLog -LogName Security -Newest 10 | ConvertTo-Csv |Out-File .\securitylogsak.csv 
Get-Content .\securitylogsak.csv | ConvertFrom-Csv


#--------------------
#select-objects 
Get-Process | Select-Object -Property Name, ID, VM, PM
Get-Process | Select Name,ID, VM, PM |Get-Member
Get-Process | Select Name, Id, PM, NPM | Sort VM-Descending 
Get-Process |Sort VM-Descending| Select Name, Id, PM, NPM  
#selecting object => subset of objects 
Get-Process | sort VM -Descending | select -First 5
Get-Process | sort VM -Descending | select -Last 5
Get-Process | sort VM -Descending | select -skip 3 -First 5
Measure-Command {1..500 | select -First 5 -wait}
Measure-Command {1..5000 | select -First 5}

#making custom property => Select-Object 
#creating a custom property "TotalMemory" => Computed Value
Get-Process | Select -Property Name, ID, @{name="TotalMemory"; expression={$_.PM+$_.VM}}
Get-Process | Select -Property Name, ID, @{name="TotalMemory"; expression={($_.PM+$_.VM) /1GB -as[int]}}
Get-Process |Select -Property Name, ID,
     @{Name="virtMem";Expression={$psitem.vm}},
     @{Name="PhysMem";Expression={$psitem.pm}} 
               
Get-Process |Select -Property Name, ID,
     @{Name="virtMem";Expression={$psitem.vm}},
     @{Name="PhysMem";Expression={$psitem.pm}} | Get-Member
#choosing a subset of objects 
Get-Process | sort PM -Descending | select -Skip 3 -First 5 -Property name, id, pm, vm



#Filtering Objects using Where-Object 
Get-Service | Where Status -ne Running
Get-Service | Where-Object Status -ne Running
Get-Service | ? Status -eq Running
Get-Service | Where status -eq stopped | where servicetype -eq Win32OwnProcess
Get-Process | Where-Object -FilterScript {$_.WorkingSet -gt 1mb -AND $_.company -notmatch "Microsoft"}
(Get-Process).Where({$_.ws -gt 100mb},"First",3)
(Get-Process).Where({$_.ws -gt 100mb},"Last",2)
Get-Process | Where {$_.ws -gt 100mb} | Select -First 3
measure-command {(1..1000) | where {$psitem%2}}
Get-Process | sort Handles


#Grouping Object -------------------------

Get-Service | Group-Object -property Status
Get-Service | group status | Get-Member
$myservices = Get-Service | group status
$myservices

#Enumerating Objects using ForEach-Object 
Start-Process calc
Get-Process calc 
Get-Process calc | foreach Kill
("Syed Awase","Syed Ameese","Syed Azeez", "TPRI","SycliQ").foreach({$_.toupper()})
Get-Process | Format-Wide


