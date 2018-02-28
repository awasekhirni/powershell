###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

$dirs = Get-ChildItem D:\
forEach($dir in $dirs){
    Write-Host $dir.FullName
    Write-Host "----------------"
    Write-Host "Syed Awase Khirni Machine Directory D:\"
    $acl = $dir.GetAccessControl()
    Write-Host $acl.AccessToString
    Write-Host
}