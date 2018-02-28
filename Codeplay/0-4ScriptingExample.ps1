﻿###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################
#---SimpleScripting Example one 
#Forloop
For($i=0; $i -lt 10; $i++){
    Write-Host "pink money is the new black money:" $i
}
#Do-While Loop
$j=0
Do{
    $j
    $j++
    Write-Host "Panama Files" $j

}While($j -lt 15)

#Do-Until loop
$k=0
Do{
$k
$k++
Write-Host "Tweets Hacked-Vijaya Mallya"$k
} Until($k -eq 10)

#while-loop
While($m -lt 9){
    $m
    $m++
    Write-Host "Every day we stand in queue for money and we get"$m
}



#ForEach 
$aks_services = Get-Service -name S*
ForEach($aks_service in $aks_services){
    $aks_service | select Name, DisplayName, Status 
} 


#ifelseif
If ($mood.Good) {
Get-Service
} else {
Restart-Computer –computername localhost
}


$procs = Get-Process | select Name, Handles, WS
foreach ($proc in $procs){
if (($proc.Handles -gt 200) -and ($proc.WS -gt 50000000)) {
$proc
    }
}


#switch
Switch ($printer.status) {
0 {$status = "OK"}
1 {$status = "Out of paper"}
2 {$status = "Out of Ink"}
3 {$status = "Input tray jammed"}
4 {$status = "Output tray jammed"}
5 {$status = "Cover open"}
6 {$status = "Printer Offline"}
7 {$status = "Printer on Fire!!"}
Default {$status = "Unknown"}
}



##### Handling Strings 
# String Quoting 
Clear-Host 
"Hello! You fool I Love You: Joy Ride Song"
'Hello! You fool I Love You: Joy Ride Song'

####mixed quoted 
'Chain kuli-ki Main Kuli ki Chain: "Translate in English", OK?'

#Escape Sequences - use the backtick `
Clear-Host 
# backspace `b (does not work in ISE, only the regular script window)
"Power `bShell"
#new line `n
"Territorial `n Prescience"

#carriage return `r
"TPRI `SYCLIQ"


#tabs 
"TPRI `t SYCLIQ"



#############################
#Large blocks of text 
Clear-Host
$demonotes = @"
Bitty bought a bit of butter to make the  bitter butter better So, Syed went, added more sugar!! 
"@

$demonotes

##########
#connection string 
$SQLString = 'SELECT col1' `
     + '     , col2' `
     + '     , col3' `
     + '  FROM someTable ' `
     + ' WHERE col1 = ''a value'' '

#with here strings 
$SQLString = @'
SELECT col1' `
     + '     , col2' `
     + '     , col3' `
     + '  FROM someTable ' `
     + ' WHERE col1 = ''a value'' 
'@


#String interpolation 

Set-Location C:\PS
Clear-Host

# Take the output of Get-ChildItem, which is an object, and gets that objects count property
$items = (Get-ChildItem).Count

# Take the output of Get-Location and store it in a variable
$loc = Get-Location

# Use these variables in a string
"There are $items items are in the folder $loc."

# To actually display the variable, escape it with a backtick
"There are `$items items are in the folder `$loc."

# String interpolation only works with double quotes
'There are $items items are in the folder $loc.'

# String Interpolation works with here strings
$hereinterpolation = @"
Items`tFolder
-----`t----------------------
$items`t`t$loc

"@

$hereinterpolation 

# Can use expressions in strings, need to be wrapped in $()
Clear-Host
"There are $((Get-ChildItem).Count) items are in the folder $(Get-Location)."

"Today is $(Get-Date). Be well."

"The 28% tax of a 100.00 dollar bill is $(28.00 * 0.28) dollars"

##









# String Formatting - C# like syntax is supported
#   In C you'd use:
[string]::Format("There are {0} items.", $items)

# Powershell shortcut
"There are {0} items." -f $items

"There are {0} items in the location {1}." -f $items, $loc

"There are {0} items in the location {1}. Wow, {0} is a lot of items!" -f $items, $loc

# Predefined formats
# N - Number
"N0 {0:N0} formatted" -f 12345678.119    # N0 12,345,678 formatted
"N1 {0:N1} formatted" -f 12345678.119    # N1 12,345,678.1 formatted
"N2 {0:N2} formatted" -f 12345678.119    # N2 12,345,678.12 formatted
"N2 {0:N9} formatted" -f 12345678.119    # N2 12,345,678.12 formatted
"N0 {0:N0} formatted"   -f 123.119       # N0 123 formatted
"N0 {0,8:N0} formatted" -f 123.119       # N0      123 formatted

# C - Currency
"C0 {0:C0} formatted" -f 12345678.1234   # C0 $12,345,678 formatted
"C1 {0:C1} formatted" -f 12345678.1234   # C1 $12,345,678.1 formatted
"C2 {0:C2} formatted" -f 12345678.1234   # C2 $12,345,678.12 formatted

# P - Percentage
"P0 {0:P0} formatted" -f 0.1234          # P0 12 % formatted
"P2 {0:P2} formatted" -f 0.1234          # P2 12.34 % formatted

# X - Hex
"X0 0x{0:X0} formatted" -f 1234          # X0 0x4D2 formatted
"X0 0x{0:X0} formatted" -f 0x4D2         # X0 0x4D2 formatted

# D - Decimal
"D0 {0:D0} formatted"   -f 12345678      # D0 12345678 formatted
"D8 {0:D8} formatted"   -f 123           # D8 00000123 formatted
"D0 {0:D0} formatted"   -f 123           # D0      123 formatted
"D0 {0,8:D0} formatted" -f 123           # D0      123 formatted

# Note, decimal only supports ints. This causes an error:
"D0 {0:D0} formatted"   -f 123.1         


# Custom formatting
$items = 1234
"There are {0:#,#0} items." -f $items    # There are 1,234 items.
  
"Custom 0, 25 $#,##0.0000  = {0,25:$ #,##0.0000} " -f 123456789.012000005   # Custom 0, 25 $#,##0.0000  =        $ 123,456,789.0120
"Custom 0, 25 $#,##0.0000  = {0,25:$ #,##0.00} "   -f 123456789.012000005   # Custom 0, 25 $#,##0.0000  =          $ 123,456,789.01
"Custom 0, 25 $#,##0.0000  = {0,25:$ #,##0.00} "   -f 123456789.012000005   # Custom 0, 25 $#,##0.0000  =          $ 123,456,789.01
                                                                            
"Custom 0, 10 #,##0%    = {0,10:#,##0%} "    -f 0.125                       # Custom 0, 10 #,##0%    =        13%
"Custom 0, 10 #,##0.00% = {0,10:#,##0.00%} " -f 0.125                       # Custom 0, 10 #,##0.00% =     12.50%
                                                                            
# Custom date formatting. Note MM is Month, mm is minute                              
"Today is {0:M/d/yyyy}. Be well."               -f $(Get-Date)              # Today is 3/13/2014. Be well.
"Today is {0,10:MM/dd/yyyy}. Be well."          -f $(Get-Date)              # Today is 03/13/2014. Be well.
"Today is {0,10:yyyyMMdd}. Be well."            -f $(Get-Date)              # Today is   20140313. Be well.
"Today is {0,10:MM/dd/yyyy hh:mm:ss}. Be well." -f $(Get-Date)              # Today is 03/13/2014 12:21:19. Be well.
                                                                            
# Calculations can be passed in as the item to be formatted                 
"The 20% tip of a 33.33 dollar bill is {0} dollars" -f (33.33 * 0.20)       # The 20% tip of a 33.33 dollar bill is 6.666 dollars

"The 20% tip of a 33.33 dollar bill is {0:0.00} dollars" -f (33.33 * 0.20)  # The 20% tip of a 33.33 dollar bill is 6.67 dollars

##









# String operators -like and -match

# Wildcards
Clear-Host
"PowerShell" -like "Pow*"
"PowerShell" -like "shell*"
"PowerShell" -like "?owerShell"  # question marks work for single characters
"PowerShell" -like "Power*[s-v]" # ends in a char between s and v
"PowerShell" -like "Power*[a-c]" # ends in a char between a and c

# Regular Expressions
Clear-Host
"888-368-1240" -match "[0-9]{3}-[0-9]{3}-[0-9]{4}"  
"ZZZ-368-1240" -match "[0-9]{3}-[0-9]{3}-[0-9]{4}"  
"888.368.1240" -match "[0-9]{3}-[0-9]{3}-[0-9]{4}"  

##


#-----------------------------------------------------------------------------#
# Arrays
#-----------------------------------------------------------------------------#

# Simple array
Clear-Host
$array = "Syed", "Code"
$array
$array[0]
$array[1]

$array.GetType()

# Updating arrays
$array = "Awase", "Ameese"
$array

$array[0] = "Power"
$array[1] = "Shell"
$array

# Formal Array Creation Syntax
$array = @("Power", "Shell")
$array

$array = @()   # Only way to create an empty array
$array.Count

$array += "Azeez"
$array += "Awase"
$array.Count


$array = 1..5  # Can load arrays using numeric range notation
$array

# Check to see if an item exists
Clear-Host
$numbers = 1, 42, 256
$numbers -contains 42

$numbers -notcontains 99

$numbers -notcontains 42


##

# Load four individual arrays
$a = 1..5
$b = 6..10
$c = 11..15
$d = 16..20

# Now create an array from the four individual ones
$array = $a, $b, $c, $d

# Array will now look like
# Col      [0] [1] [2] [3] [4]
# Row [0]   1   2   3   4   5
# Row [1]   6   7   8   9  10
# Row [2]  11  12  13  14  15
# Row [3]  16  17  18  19  20

# Reference the second item in the second array (remember arrays are 0 based)
$array[1][2] # Zero based array, go to 2nd row, 3rd item

# Take the contents of the array and join them into a single string. 
$array[0] -join " "

##









#-----------------------------------------------------------------------------#
# Hash tables 
#-----------------------------------------------------------------------------#

$hash = @{"Key"         = "Value"; 
          "sycliq"  = "Sycliq.com"; 
          "tpri" = "territorialprescience.com"}
          
$hash                  # Display all values
$hash["sycliq"]    # Get a single value from the key

$hash."tpri"    # Get single value using object syntax

# You can use variables as keys
$mykey = "PowerShell"
$hash.$mykey         # Using variable as a property
$hash.$($mykey)      # Evaluating as an expression
$hash.$("sycliq" + "tpri")

# Adding and removing values
$hash                                     # Here's what's there to start
$hash["Sycliq"] = "www.sycliq.com"  # Add value using new key
$hash                                     # Show the additional row

$hash.Remove("tpri")        # Remove by passing in key
$hash

# See if key exists
$hash.Contains("Sycliq")      # Should be there
$hash.Contains("tpri")      # Gone since we just removed it

# See if value exists
$hash.ContainsValue("www.sycliq.com")  
$hash.ContainsValue("territorialprescience.com")  

# List keys and values
$hash.Keys
$hash.Values

# Find if a key or value is present
$hash.Keys -contains "territorialprescience.com"

$hash.Values -contains "Sycliq.com"


##



