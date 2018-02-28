#Scalers are virtual duffel bags that are utilized in order to store and transport 
# data within your PS Code 

#builtin scaler
$PSHOME
# scaler with filter 
dir $PSHOME -Filter *.dll
#scaler environment 
dir env: | sort name 
# in order to receive a complete list of all .dll files lcoated in the Windows home folder
$env:windir 

dir $env:windir -Filter *.dll

$env: homepath = $env:homepath + "\home"

#scalers are not required to be defined prior to use in PS
# just assign the scaler a value 
$varOne = "One"
# to fetch the type of the data the scalers has
$var1.gettype();


# assigning a value and writing it to the output 
$svc = "eventlog"
Write-Output "the service is $svc"



