# ###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################


# You can declare functions directly in the psm1 file 



function Write-PvtMsgtoSAK(){
    Write-Host "Please do get in touch with us: sak@sycliq.com"
    Write-Host "for Corporate/Open House Technology Training"

}


# Set the Execution Policy before executing the functions 

#region Import Scripts 
#$PSScriptRoot is a shortcut to the "current folder where the script is being run from"


. $PSScriptRoot\ModuleExamples.ps1 
. $PSScriptRoot\ModuleExamples2.ps1


#endregion Import Scripts


### By default- if we do not explicitly export module members
### all functions will be visible outside the module

# To make the member functions visible, we use "Export-ModuleMember" 
# those not listed with "Export-ModuleMember will remain private

#best practice : explicitly export member functions which you want them to be visible 

#region for Export Module Members 

    Export-ModuleMember Write-MyName
    Export-ModuleMember Write-Tweetsak

#endregion for Export Module Members 

