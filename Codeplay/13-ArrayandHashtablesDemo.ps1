###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#1-Simple Arrays 

$sakArray = 'Syed Awase', 9900911,12,(Get-Date),$null, $true
$sakArray.Count 
$sakArray.Length
$sakArray.Rank
$sakArray.LongLength
$sakArray[0]
$sakArray[-1]
$sakArray[0,1,-1]
$sakArray[0,1,-2]
$newsak = $sakArray[0..2]
$newsak 
$newsak.Length
$newsak.Count
$newsak +='Syed Azeez'
$newsak.Count


#2-Creating a strongly type array 
[Int[]]$strongSakArray = 1,2,3,4,5,6
$strongSakArray +=12
$strongSakArray
$strongSakArray+="I am trying to insert string into an integer array"

#3-Strongly typed arrays 
$RogueOne =[Int[]](1,2,3,4,5,6)
$RogueOne.GetType().FullName 
$RogueOne.GetEnumerator()
$RogueOne.Rank

$FilmiNaam = [String[]]("RogueOne","Sultan","Dangal","Don't Breathe")
$FilmiNaam.GetType().FullName
$FilmiNaam.GetType().AssemblyQualifiedName
$FilmiNaam.GetType().Attributes


$fobject +="fumbling"
$fobject.GetTypeCode()
$fobject.GetType()



#4Switch statement with Arrays 

$farray = 1,23,223,2341,5432,1121,123,8878
Switch($farray){
    1{'one'}
    23{'two'}
    3{'three'}
    4{'four'}
    5{'five'}
    6{'six'}
    7{'seven'}
    8{'eight'}
}


#checking arrays using Wildcards 

$names = Get-ChildItem -Path $env:windir | Select-Object -ExpandProperty Name
$names -contains ‘explorer.exe’
$names -contains ‘explorer*’
$names -like ‘explorer*’


$mySchoolFriends ='Aayesha','bharat','arijit','ram','naveed'
$mySchoolFriends -contains 'Aayesha'
$mySchoolFriends -contains 'salman'
$mySchoolFriends -like 'a*'
@($mySchoolFriends -like 'a*').Count -gt 0


################################
#4-Creating Byte Arrays 
$byteArray = New-Object Byte[] 100
$byteArray = [Byte[]](,0xFF*100)
$valArray =(1..7)*5


##########################
#5-Performance Optimization for Arrays
#Arrays are slow and expensive process 

$array = 1..10
[System.Collections.ArrayList]$arraylist = $array
$arraylist.RemoveAt(4)
$null = $arraylist.Add(11)
$arraylist.Insert(0,’added at the beginning’)
$arraylist


####################
#6-Reversing Array 
# reverse the order of elements in an array 
$a = 1,2,3,4
[array]::Reverse($a)
$a
#creating jagged arrays 
$abu = 1,2,3,(1,('a','Syed awase','azeez'),3),5
$abu.Count
$abu.Length
$abu.Rank
$abu[3]
$abu[2]
$abu[3][2]
$abu[3][1][1]


#######################
#7-creating multi-dimensional arrays 
$MDArray = New-Object'Int32[.]'2.2
$MDArray
$MDArray[1,1]=20
$MDArray[0,0] =10


##################
#8-Returning Array in one Chunk and preseving its type 

function ArrayTypeTest{
    $myresult = [System.Collections.ArrayList](1..10)
    return $myresult
}
 
ArrayTypeTest | ForEach-Object {"Receiving $_"}
(ArrayTypeTest).GetType().FullName


#############################
#9-Range of letters

65..90 | ForEach-Object {[char]$_}
65..90 | ForEach-Object {"$([char]$_):"}
$letters = [char[]](97..122)
$letters


#######################################
#10-Converting Cmdlet Results into Arrays 
(Get-ChildItem $env:windir\explorer.exe -ea SilentlyContinue).GetType().FullName
(Get-ChildItem $env:windir -ea SilentlyContinue).GetType().FullName
@( Get-ChildItem C:\nonexistent -ea SilentlyContinue).GetType().FullName
@( Get-ChildItem $env:windir\explorer.exe -ea SilentlyContinue).GetType().FullName



############################
#11-Arrays of Strings 
'~'*50
'SyedAwase'*10
@('SyedAwase')*10


############################
#12-Using Hashtables 
$person =@{}
$person.Age=39
$person.Name='Syed'
$person.FName='Awase'
$person.Status ='je suis celebete'
$person
$person['Age']
$info ='Age'
$person.$info
$person.GetType().FullName


#########################
#13-Sorting Hash tables 
#hashtables stores key-value pairs 
$hash = @{Name="Syed"; Age=39;status='Online'}
$hash
$hash.GetEnumerator()|Sort-Object Name

#ordered hash table 
$hash = @{Name='Syed'; Age=39;status='Online'}
$Ohash = [Ordered]@{Name=’Awase’; Age=66; Status=’Online’}
$hash
$Ohash

####################################
#14-Converting hash to objects 


$shahrukh = @{Name=’shahrukh’; Age=51; Status=’Online’}
$shahrukh
$shobject = New-Object PSObject -Property $shahrukh
$shobject.GetType()
$shobject | Select-Object -Property Name, Status,Age


############################
#15-Converting hash tables to translate numeric values to clear text 
$translate =@{
    1="ek"
    2="do"
    3="teen"
    4="char"
    5="panch"
    }

    $translate
    $translate[2]


###########################
#16-Using Hash tables for calculated properties 

$age = @{
    Name='Age'
    Expression={(New-TimeSpan $_.LastWriteTime).Days }
    }

Get-ChildItem $env:windir |Select-Object Name,$age,Length -First 4
Get-ChildItem $env:windir | Select-Object Name, $age, Length | Sort-Object -Property Age -Descending
Get-ChildItem $env:windir | Select-Object Name, $age, Length | Where-Object { $_.Age -lt 5 }


######################################
#17-Remove Keys from hash Tables 
$myHash = @{}
$myHash.Name = ‘Syed Awase’
$myHash.ID = 990008
$myHash.Age = 39
$myHash.Location = ‘BITS,PILANI’
$myHash
$myHash.Remove('Age')
$myHash

