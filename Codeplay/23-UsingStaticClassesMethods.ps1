#using static classes and methods 
[System.Environment]
[System.Environment] |Get-Member 
[System.Environment] |Get-Member -Static

#Displaying static properties of System.Environment 
[System.Environment]::CommandLine
[System.Environment]::OSVersion
[System.Environment]::HasShutdownStarted


#Doing Math with System.Math 
[System.Math] | Get-Member -Static -MemberType Methods
[System.Math]::Sqrt(9)
[System.Math]::Pow(2,3)
[System.Math]::Floor(3.3)
