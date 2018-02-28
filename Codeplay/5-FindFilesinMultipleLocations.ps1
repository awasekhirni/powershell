###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
#finding files in multiple locations
$path1 = "E:\CT\Powershell\CodePlay"
$path2 = "E:\CT\Powershell\CodePlay"
Get-ChildItem -Path $path1, $path2
Get-ChildItem *.txt 
#finding large files
Get-ChildItem |Where-Object {$_.Length -gt 2MB}
Get-ChildItem | Where-Object {$_.Length -gt 50KB} | Select @{Name="Length";Expression={$_.Length/1MB}},Name

#finding old files 
Get-ChildItem | Where-Object {$_.LastWriteTime -lt (Get-Date).AddDays(-30)}


#alternatively 
$time = (Get-Date).AddDays(-90)
$size = 2MB
Get-ChildItem $path1,$path2 | Where-Object {$_.LastWriteTime -lt $time -and $_.Length -gt $size}
