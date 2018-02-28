###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

# Functions defined are usable inside this module 
# as they are not explicitly exported in the modules main file

function Write-MyName(){
    Write-Host "Module 1"
    Write-Host "Syed Awase " 
    Write-Host "Consultant/Technology Coach/Researcher/Entrepreneur"
    Write-Host " From Artificial Intelligence to UI"
}


function Write-PvtMsg(){
    Write-Host "Module 1: Private Function"
    Write-Host "Please do get in touch with us"
    Write-Host "for Corporate/Open House Technology Training"

}



# both above functions can only be called inside this module 
# if i wish to use these functions outside ??? this module 
# declare the functions directly in the psm1 file 