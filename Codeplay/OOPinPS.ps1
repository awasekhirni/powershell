###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################


#############
#Object Oriented Programming in Powershell 
#creating class definitions => specification/blueprints
# adding properties => 
# adding methods/functions 
# instantiating objects 

#Standard approach to construct objects is 

function Demo-Object($SchemaStructure, $Table, $Comment){

    # build a hash table with properties 
    $properties =[ordered]@{
        SchemaVal = $SchemaStructure 
        Table = $Table 
        Comment = $Comment 
    }

    #start by creating an object of type PSObject 

    $object = New-Object -TypeName PSObject -Property $properties
    #Return the newly created object 
    return $object 


}

$sakObject = Demo-Object -Schema "MySchema" -Table "MyTable" -Comment "MyComment" 

$sakObject


#alternatively creating PSObject in CSharp 

using System;

public class CSObjectDemo{
  public static string composeFullname(string, pSchema,string pTable){
  
    string retVal="";
    retVal=pSchema+"."+pTable;
    return retVal;
  }//public static string compose Full name

}


##############################
#using class in powershell v5 

Class CustomObject{
    [string] $Name;
    CustomObject([string] $NameIn) {
        $this.Name = $NameIn;
    }
 
    [string] JumbleName() {
        $a = $null
        [char[]]$this.Name| Sort-Object {Get-Random} | %{ $a = $PSItem + $a}
        return $a
    }
}


$x= [CustomObject]::new("RAEES")
$x.JumbleName()


################## Another way of creating objects in powershell
Add-Type @'
public class MyObject
{
    public int MyField = 5;    
    public int xTimesMyField(int x) {
        return x * MyField;
    }
}
'@

$object = New-Object MyObject 
$object 
$object.xTimesMyField(100)


##################
# You can also use -asCustomObject with the New-Module cmdlet to export a module as a class            
$object = New-Module {            
    [int]$myField = 5            
    function XTimesMyField($x) {            
        $x * $myField            
    }            
    Export-ModuleMember -Variable * -Function *                
} -asCustomObject            
            
$object            
$object.xTimesMyField(12)  


####################
# You can also simply declare an object and start tacking on properties and methods with the            
# Add-Member cmdlet.  If you use -passThru you can make one giant pipeline that adds all of the            
# members and assign it to a variable            
            
$object = New-Object Object |            
    Add-Member NoteProperty MyField 5 -PassThru |             
    Add-Member ScriptMethod xTimesMyField {            
        param($x)            
        $x * $this.MyField            
        } -PassThru            
                
$object            
$object.xTimesMyField(10) 


#############################
##Object creation example
$groups = 'Group1', 'Group2'
$users = 'User1', 'User2'
 
$objectCollection=@()
 
$object = New-Object PSObject
Add-Member -InputObject $object -MemberType NoteProperty -Name Group -Value ""
Add-Member -InputObject $object -MemberType NoteProperty -Name User -Value ""
 
$groups | ForEach-Object {
$groupCurrent = $_
 
   $users | ForEach-Object {
      $userCurrent = $_
         $object.Group = $groupCurrent
         $object.User = $userCurrent
 
         $objectCollection += $object
    }
}
 
$objectCollection

########alternatively the above code can be written as 

$groups = 'Group1', 'Group2'
$users = 'User1', 'User2'
 
$objectCollection = $groups |
    ForEach-Object {
          $groupCurrent = $_
          $users | ForEach-Object {
            $userCurrent = $_
 
$properties = @{
   User=$userCurrent;
   Group = $groupCurrent
}
 
            New-Object -TypeName PSObject -Property $properties
        }
    }
 
$objectCollection


###still improvising on it 

$groups = 'Group1', 'Group2'
$users = 'User1', 'User2'
 
$properties = @{User=''; Group = ''; Dummy = 'Default'}
$objectTemplate = New-Object -TypeName PSObject -Property $properties
 
$objectCollection = $groups |
    ForEach-Object {
        $groupCurrent = $_
        $users | ForEach-Object {
            $userCurrent = $_
 
         $objectCurrent = $objectTemplate.PSObject.Copy()
         $objectCurrent.group = $groupCurrent
         $objectCurrent.user = $userCurrent
         $objectCurrent
        }
    }
 
$objectCollection | ft –AutoSize


