###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

# this variable's scope is limited to this module alone
$scopedToMyModule = "Scoped to my Module"

#To make it global 
$Global:scopedVariableGlobally = "Globally Scoped Variable"

#Script level scoping 
$Script:sclocal="Calling from a local script variable"

function Write-Tweetsak(){
    Write-Host "Module 2"
    Write-Host "tweet to SAK: @aks008"
    Write-Host "Hakuna Matata! What a wonderful day!!"
    Write-Host $sclocal

}