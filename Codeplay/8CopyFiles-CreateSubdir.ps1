###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
$SourceFile = "C:\Temp\File.txt"
$DestinationFile = "C:\Temp\NonexistentDirectory\File.txt"

If ((Test-Path $DestinationFile) -eq $false) {
    New-Item -ItemType File -Path $DestinationFile -Force
} 

Copy-Item -Path $SourceFile -Destination $DestinationFile 
