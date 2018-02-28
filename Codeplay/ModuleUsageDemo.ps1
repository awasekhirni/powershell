###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#define the path to functions and modules 
$modulePath = 'E:\CT\Powershell\CodePlay'
$moduleName = 'MyManifestforModule'


#now importing the full path for module 
$module = "$($modulePath)\$($moduleName).psd1"

#Importing module 
Import-Module -Force $module 

#Now the functions are available for use 
Write-MyName
Write-Tweetsak

# Now if we call the following method which is not exported
# we are likely to get an error 

Write-PvtMsgtoSAK


# to manually unload a module or when the session ends it will be automatically unloaded
Remove-Module $moduleName

# to list all the modules loaded 
Get-Module 

#More help on Modules 
Get-Help about_modules 

#help for other topics 
Get-Help about*


