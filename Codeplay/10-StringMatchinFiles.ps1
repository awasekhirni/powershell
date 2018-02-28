###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
###########################################################

$Path = "E:\CT\Powershell\CodePlay"
$Text = "This is the data that I am looking for"
$PathArray = @()
$Results = "E:\CT\Powershell\CodePlay\testscore.txt"


# This code snippet gets all the files in $Path that end in ".txt".
Get-ChildItem $Path -Filter "*.txt" |
Where-Object { $_.Attributes -ne "Directory"} |
ForEach-Object {
If (Get-Content $_.FullName | Select-String -Pattern $Text) {
$PathArray += $_.FullName
$PathArray += $_.FullName
}
}
Write-Host "Contents of ArrayPath:"
$PathArray | ForEach-Object {$_}


##########################################################