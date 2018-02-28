###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

function SayHello-ToSyed{
    'Hello! Syed Awase- How are you doing?'
}

SayHello-ToSyed

#Stick to the Guidelines defined for creating Functions
##1- Get-Verb to get the list of verbs approved
#Company Prefix - To Avoid name collisions, all public functions shoudl use very own noun-prefix
# Company Name "TPRI" - Get-TPRINetworkCard 
# Use Standard Parameter names 
#Optional Parameters should have atleast a default value 
#Mandatory Parameters Always define atleast a type 
#--Add Comment Based Help 

Get-Verb
   # List of verbs approved are 
 ##  Verb        Group         
##----        -----         
#Add         Common        
#Clear       Common        
#Close       Common        
#Copy        Common        
#Enter       Common        
#Exit        Common        
#Find        Common        
#Format      Common        
#Get         Common        
#Hide        Common        
#Join        Common        
#Lock        Common        
#Move        Common        
#New         Common        
#Open        Common        
#Optimize    Common        
#Pop         Common        
#Push        Common        
#Redo        Common        
##Remove      Common        
#Rename      Common        
#Reset       Common        
#Resize      Common        
#Search      Common        
#Select      Common        
#Set         Common        
#Show        Common        
#Skip        Common        
#Split       Common        
#Step        Common        
#Switch      Common        
#Undo        Common        
#Unlock      Common        
#Watch       Common        
#Backup      Data          
#Checkpoint  Data          
#Compare     Data          
#Compress    Data          
#Convert     Data          
#ConvertFrom Data          
#ConvertTo   Data          
#Dismount    Data          
#Edit        Data          
#Expand      Data          
#Export      Data          
#Group       Data          
#Import      Data          
#Initialize  Data          
#Limit       Data          
#Merge       Data          
#Mount       Data          
#Out         Data          
#Publish     Data          
#Restore     Data          
#Save        Data          
#Sync        Data          
#Unpublish   Data          
#Update      Data          
#Approve     Lifecycle     
#Assert      Lifecycle     
#Complete    Lifecycle     
#Confirm     Lifecycle     
#Deny        Lifecycle     
#Disable     Lifecycle     
#Enable      Lifecycle     
#Install     Lifecycle     
#Invoke      Lifecycle     
#Register    Lifecycle     
#Request     Lifecycle     
#Restart     Lifecycle     
#Resume      Lifecycle     
#Start       Lifecycle     
#Stop        Lifecycle     
#Submit      Lifecycle     
#Suspend     Lifecycle     
#Uninstall   Lifecycle     
#Unregister  Lifecycle     
#Wait        Lifecycle     
#Debug       Diagnostic    
#Measure     Diagnostic    
#Ping        Diagnostic    
#Repair      Diagnostic    
#Resolve     Diagnostic    
#Test        Diagnostic    
#Trace       Diagnostic    
#Connect     Communications
#Disconnect  Communications
#Read        Communications
#Receive     Communications
#Send        Communications
#Write       Communications
#Block       Security      
#Grant       Security      
#Protect     Security      
#Revoke      Security      
#Unblock     Security      
#Unprotect   Security      
#Use         Other 

#-------------
#region functions 
$sycliq = {
    Clear-Host
    "Welcome to SycliQ- System for Commuting Life Cyle Intelligence"
    
}

$sycliq

function CallSycliQ(){
Clear-Host
"Welcome to SycliQ- System for Crop Life Cycle Intelligence"
}


function CallSycliq-Care(){
Clear-Host 
"Welcome to SycliQ-Systems for commodity life cycle intelligence"
}

function CallSycliq-Commute(){
    Clear-Host
    "SycliQ- System for Commuting Life Cycle Intelligence"
}

#run the functions 
CallSycliq-Care
CallSycliq-Commute

## Convention to write functions, use an approved verb from the list
# Get a list of approved verbs 
Get-Verb



# parameters can be passed in by placing them in paranthesis 
function Get-FullName($firstName, $lastName){

Write-Host($firstName +""+$lastName)

}

Get-FullName "Awase" "Syed" 
Get-FullName("Awase","Syed")

$company = "www.territorialprescience.com"

Get-FullName $company "Syed"
Get-FullName $("Awase" + "Khirni") "Syed"


# Any changes to a parameter inside a function are scoped to that function 

function set-DefaultWebSite($website){
   $website = "www.territorialprescience.com"
   "Inside function `$website = $website"
}

Clear-Host 
$website = "www.sycliq.com"
set-DefaultWebSite($website)

############
function Get-AValue($one,$two){
    return $one/$two
}

Get-AValue 10 2
$returnValue = Get-AValue 100 2
"Returned value is $returnValue"


# Functions also support named parameters 
# Simply put the name of the parameter with a "-"
# Not that with named parameters the order is no longer important 
$returnValue = Get-AValue -one 2221312 -two 3121
"Returned value is $returnValue"

############################################
#Advanced Functions 
# possible to pipeline enable your functions 

function Get-MyFiles(){
   # executes once at the start of the function
    begin {
        $myfiles = "Here are some Powershell files : `r`n"
        }

     #process block is executed once for each object being 
     #passed in from the pipe
     process{
        if ($_.Name -like "*.ps1"){
            $myfiles += "`t$($_.Name)`r`n"
        }
        }

        # the end block executes once, after the rest of the function
        end {
            return $myfiles
        }
        
}
Clear-Host 
Set-Location "E:\CT\Powershell\CodePlay"
Get-ChildItem | Get-MyFiles

$result = Get-ChildItem | Get-MyFiles

$result.GetType()
Clear-Host
$i =0
foreach($f in $result)
{
   $i++
   "$i : $f"
}

########################################
# To pipeline the output, push the output in the process area 
function Get-SyedFiles(){
   #executes once at the start
   begin{}

   process{
    if($_.Name -like "*.ps1")
    {
        $mypsFiles = "`t My PowerShell files is $($_.Name)"
        $mypsFiles 
    }
   }
   #executes once, after the rest of the function
   end {}

}


$output = Get-ChildItem | Get-SyedFiles
$output.GetType()
Clear-Host
$i = 0
foreach($f in $output)
{
  $i++
  "$i : $f"
}


#Advanced functions also allow parameters with extra helping hints 

function Get-MoneyValue(){
    
    #Needed to indicate this is an advanced function 
    [CmdletBinding()]
    
    param( 
    #Begin the parameter block 
    [Parameter(Mandatory=$true, HelpMessage="Please give me 500 and 1000 Notes")]
    [int] $one,
    #Note in the second we are strongly typing, and are providing a default value 
    [Parameter (Mandatory=$false, HelpMessage="Please enter value two")]
    [int] $two=892


    ) #end of the parameter block 

    begin{}
    process{ return $one * $two}
    end{}

}

# Example 1 pass in values 
Get-MoneyValue -one 2000 -two 23
Get-MoneyValue -one 23 



#############
#Error Handling 
function DummyTest($numerator,$denominator){
 Write-Host " Error Function Demo"
 $result = $numerator/$denominator
 Write-Host "Result:$result"
 Write-Host "Demo Completed"
 
}
Clear-Host 
DummyTest 78221 12 
DummyTest 121212 0 //attempt to divide by zero error


###################
# Fixing the above by using try/catch/finally 

function MyDummyTest($numerator, $denominator){
   Write-Host "Beginning of the function"

   try{
    $result = $numerator/$denominator
    Write-Host "Result: $result"
   }catch{
   Write-Host " Error Occured: Exception Information below!"
   Write-Host $_.ErrorID
   Write-Host $_.Exception.Message 
   break

   
   
   }finally{

   Write-Host "Successfully completed function"
   
   
   }
}

Clear-Host 
MyDummyTest 78221 12 
MyDummyTest 121212 0 



#################
#Adding Help to User Defined Functions 
# Custom tags within a comment block that Get-Help will recognize
# Note that not all of them are required
# .SYNOPSIS - A brief description of the command
# .DESCRIPTION - Detailed command description
# .PARAMETER name - Include one description for each parameter
# .EXAMPLE - Detailed examples on how to use the command
# .INPUTS - What pipeline inputs are supported
# .OUTPUTS - What this funciton outputs
# .NOTES - Any misc notes you haven't put anywhere else
# .LINK - A link to the URL for more help. Use one .LINK tag per URL
# Use "Get-Help about_comment_based_help" for full list and details


function Get-ChildName(){

<#
  .SYNOPSIS
  Returns a list of only the names for the child items in the current location.
  
  .DESCRIPTION
  This function is similar to Get-ChildItem, except that it returns only the name
  property. 
  
  .INPUTS
  None. 
  
  .OUTPUTS
  System.String. Sends a collection of strings out the pipeline. 
  
  .EXAMPLE
  Example 1 - Simple use
  Get-ChildName
  
  .EXAMPLE
  Example 2 - Passing to another object in the pipeline
  Get-ChildName | Where-Object {$_.Name -like "*.ps1"}

  .LINK
  Get-ChildItem 
  
#>

  Write-Output (Get-ChildItem | Select-Object "Name")


}

Clear-Host 
Get-Help Get-ChildName 

Clear-Host 
Get-Help Get-ChildName -full 









####################################



#2.Defining Function Parameters
#functions can be define in two ways 

function Test-Function($Parameter1='Default value1', $Parameter2='Default Value2'){
    " You have define $Parameter1 and $Parameter2"
}


function Test-Function{
    param($Parameter1='Default value1', $Parameter2='Default Value2')
    "You have defined $Parameter1 and $Parameter2"
}



################################
#3.Picking Standard parameter Names 
#parameter names always start with PascalCase"Capital Letter"
#no predefined list of parameters names, but one can create 
#by looking at all the parameters from all cmdlets 

Get-Command -CommandType Cmdlet |
ForEach-Object { $_.Parameters } |
ForEach-Object { $_.Keys } |
Group-Object -NoElement |
Sort-Object Count, Name -Descending |
Select-Object -Skip 11 |
Where-Object { $_.Count -gt 1 } |
Out-GridView

#listed below are list of parameter lists used in Cmdlet
#99	WhatIf	
#99	Confirm	
#81	Name	
#76	Force	
#62	Credential	
#60	InputObject	
#59	Path	
#53	LiteralPath	
#49	PassThru	
#38	UseTransaction	
#38	ComputerName	
#36	Exclude	
#35	Include	
#32	Filter	
#31	Id	
#19	Authentication	
#17	InstanceId	
#16	Scope	
#15	UseSSL	
#15	CertificateThumbprint	
#14	Value	
#14	Property	
#14	Port	
#13	FilePath	
#13	ApplicationName	
#12	ThrottleLimit	
#12	SessionOption	
#12	Description	
##12	ConnectionUri	
#12	ArgumentList	
#10	Session	
#10	Encoding	
#9	SourceIdentifier	
#8	Wait	
#8	Namespace	
#8	DisplayName	
#8	AsJob	
#7	Stream	
#7	State	
#7	NoClobber	
#7	Message	
#7	Job	
#7	Impersonation	
#6	TypeName	
#6	Timeout	
#6	OptionSet	
#6	Option	
#6	Module	
#6	LogName	
#6	Delimiter	
#6	ConfigurationName	
#6	Command	
#6	Class	
#6	AllowRedirection	
#5	View	
#5	Variable	
#5	Source	
#5	SelectorSet	
#5	ResourceURI	
#5	Recurse	
#5	PSProvider	
#5	NoServiceRestart	
#5	MessageData	
#5	FullyQualifiedModule	
#5	Depth	
#5	Certificate	
#5	Append	
#5	Action	
#4	UseDefaultCredentials	
#4	UseCulture	
#4	UICulture	
#4	StackName	
#4	ShowError	
#4	ScriptBlock	
#4	Runspace	
#4	ProxyCredential	
#4	NoNewline	
#4	NewName	
#4	Locale	
#4	List	
#4	GroupBy	
#4	Expand	
#4	EnableAllPrivileges	
#4	DisplayError	
#4	Destination	
##4	Culture	
#4	Count	
#4	Content	
#4	Category	
#4	CaseSensitive	
#4	Body	
#4	Authority	
#4	AppDomainName	
#3	WsmanAuthentication	
#3	Width	
#3	VMName	
#3	VMGuid	
#3	ValueSet	
#3	Uri	
#3	To	
#3	SupportEvent	
#3	SkipNetworkProfileCheck	
#3	Server	
#3	SecurityDescriptorSddl	
#3	RunspaceName	
#3	RunspaceInstanceId	
#3	RunspaceId	
#3	Role	
#3	Restart	
#3	PSVersion	
#3	Protocol	
#3	ProcessName	
#3	Process	
#3	OutputBufferingMode	
3	OutFile	
3	NoTypeInformation	
3	Newest	
3	ModulesToImport	
3	MemberType	
3	MaxTriggerCount	
3	MaximumRedirection	
3	LocalCredential	
3	Function	
3	FullyQualifiedName	
3	Fragment	
3	Forward	
3	EnableNetworkAccess	
3	CommandType	
3	CommandName	
3	Cmdlet	
3	Breakpoint	
3	AsString	
3	AssemblyName	
3	As	
2	WorkgroupName	
2	WebSession	
2	Visibility	
2	Verb	
2	UseUTF16	
2	UseSharedProcess	
2	UserName	
2	UserAgent	
2	UseBasicParsing	
2	UnjoinDomainCredential	
2	Unique	
2	TypesToProcess	
2	TypeData	
2	Type	
2	TransportOption	
2	TransferEncoding	
2	TotalCount	
2	Title	
2	TimeoutSec	
2	ThreadOptions	
2	ThreadApartmentState	
2	Tags	
2	SubscriptionId	
2	Strict	
2	Status	
2	StartupType	
2	StartupScript	
2	SkipRevocationCheck	
2	SkipCNCheck	
2	SkipCACheck	
2	Skip	
2	ShowSecurityDescriptorUI	
2	SessionVariable	
2	SessionTypeOption	
2	SessionType	
2	SecureKey	
2	SecondValue	
2	Seconds	
2	ScriptsToProcess	
2	Script	
2	RunAsCredential	
2	RestorePoint	
2	Resolve	
2	Raw	
2	Quiet	
2	Query	
2	PSSession	
2	PSHost	
2	ProxyUseDefaultCredentials	
2	ProxyAuthentication	
2	ProxyAccessType	
2	Proxy	
2	ProcessorArchitecture	
2	PrependPath	
2	Prefix	
2	PowerShellVersion	
2	ParameterName	
2	OperationTimeout	
2	Off	
2	NotMatch	
2	NoEncryption	
2	ModuleInfo	
2	Minimum	
2	Method	
2	MemberName	
2	MaximumReceivedObjectSizeMB	
2	MaximumReceivedDataSizePerCommandMB	
2	Maximum	
2	LiteralName	
2	ListenerOption	
2	Line	
2	Key	
2	JobName	
2	InFile	
2	Index	
2	IdleTimeoutSec	
2	Headers	
2	Header	
2	Guid	
2	FormatTypeName	
2	FormatsToProcess	
2	Format	
2	First	
2	Expression	
2	ExecutionPolicy	
2	EventIdentifier	
2	EntryType	
2	End	
2	Drive	
2	DisplayHint	
2	DisableNameChecking	
2	DisableKeepAlive	
2	Dialect	
2	Delay	
2	Debugger	
2	DcomAuthentication	
2	Date	
2	Copyright	
2	ContentType	
2	ConfigurationTypeName	
2	CompanyName	
2	Column	
2	CimSession	
2	CimResourceUri	
2	CimNamespace	
2	CanonicalName	
2	Before	
2	AutoSize	
2	Author	
2	AsCustomObject	
2	ApplicationBase	
2	AppendPath	
2	AllowClobber	
2	All	
2	Alias	
2	After	
2	AccessMode	

######################################


############
#5-Using Mandatory parameters

Function Mandatory-TestParameters{
    param(
    [Parameter(Mandatory=$true)]
    $name
    )

    "Displaying your $name"
}


###########################
#6-Adding help messages to Mandatory parameters 

Function HelpMessage-Demo{
    param(
    [Parameter(Mandatory=$true, HelpMessage='Please enter your name')]
    $name
    )
    "Displaying your name: $name"
}



#############################
#7-Strongly-Typed Mandatory parameters

Function Strong-Test{
    param(
        [Parameter(Mandatory=$true, HelpMessage='Enter number of Rupees!')]
        $Rs
    )

    $dollar = $Rs * 67.786
    $dollar

}


#Correction 

Function Strong-Test{
    param(
        [Parameter(Mandatory=$true, HelpMessage='Enter number of Rupees!')]
        [Double]
        $Rs
    )

    $dollar = $Rs * 67.786
    $dollar

}

#############################
#8-Masked Mandatory Parameters
# A parameter marked as mandatory and "SecureString" will automatically 
#prompt for the password with masked characters 

function Masked-Test{
    param(
        [System.Security.SecureString]
        [Parameter(Mandatory=$true)]
        $password
    )

    $plain = (New-Object System.Management.Automation.PSCredential('dummy', $password)).GetNetworkCredential().Password

    "You entered the following values: $plain"
}


#######################################
#9-Using Switch Parameters 
# used to switch parameter to a function 
#switch parameters work like a switch  

function Test-SwitchParameter{
    param(
        [Switch]
        $DoSpecial
    )

    if($DoSpecial){
        'I am doing something special'
    }else{
        'I am doing the usual stuff'
    }
}


###################################
#10- Using Parameters sets 
# Powershell does not support overloading of parameters, 
# but has something called ParameterSets 

function Add-User{
    [CmdletBinding(DefaultParameterSetName='A')]
    param(
    [Parameter(ParameterSetName='A', Mandatory=$true)]
    $Name,

    [Parameter(ParameterSetName='B', Mandatory=$true)]
    $GoogleUserName,

    [Parameter(ParameterSetName='C', Mandatory=$true)]
    $TwitterAccount
      )
    $chosen = $PSCmdlet.ParameterSetName
    "You have choosen $chosen parameter set."   
}



#########################
#11-Parameter Sets to automatically bind data types 

function Test-Binding{
    [CmdletBinding(DefaultParameterSetName='Name')]
    param(
    [Parameter(ParameterSetName='ID', Position=0, Mandatory=$true)]
    [Int]
    $id,
    [Parameter(ParameterSetName='Name', Position=0, Mandatory=$true)]
    [String]
    $name
      )
    $set = $PSCmdlet.ParameterSetName
    “You selected $set parameter set”
    if ($set -eq ‘ID’) {
    “The numeric ID is $id”
    } else {
    “You entered $name as a name”
    }
}


#####################################
#12-Optional and Mandatory at the SameTime


Function OptionalMandatory-Test{
    [CmdletBinding(DefaultParameterSetName='A')]
    param(
        [Parameter(ParameterSetName=’A’,Mandatory=$false)]
        [Parameter(ParameterSetName=’B’,Mandatory=$true)]
        $ComputerName,
        [Parameter(ParameterSetName=’B’,Mandatory=$false)]
        $Credential
    )
    $chosen = $PSCmdlet.ParameterSetName
“You have chosen $chosen parameter set.”

}


####################################################
#13-Limiting the Number of Arguments
#Parameters can receive multiple values when they accept arrays 

function Add-User{
    param(
        [String[]]
        $UserName

    )
    $UserName | ForEach-Object {"Adding $_"}
}

#alternatively for multiple arguments 

function Add-User{
    param
    (
    [ValidateCount(1,2)]
    [String[]]
    $UserName
    )
    $UserName | ForEach-Object { “Adding $_” }
}


#################################
#14- Intellisense for function argument prompts 


function Select-Color{
    param(
    [ValidateSet('Red','Green','Blue')]
    $Color
    
    )

    "You Choose $Color"

}

###################################################
#15-Enumeration Types for Parameter Intellisense
#an alternative to ValidateSet is by assigning an enumeration data type to a parameter

function Select-Color{
    param(
    [System.ConsoleColor]
    $Color
    )

    "Please select the Color: $Color"
}


##################################################
#16-Validating Arguments using Patterns
# we can use regular expression pattern to validation function parameters


function Get-ZIPCode{
    param(
        [ValidatePattern('^\d{5}$')]
        [String]
        $Zip
    )
    "Please enter the zip code of the country you live in:$Zip"
}


#####################################################
#17-Evaluating User Submitted Parameters

function Get-Parameter{
    param(
        $Name,
        $LastName='Default',
        $Age,
        $Id
    )
    $PSBoundParameters
}


#####################################
#18-Splatting Parameters
# Splatting is taking a hash table with key/value pairs in it and then 
#applying it to a function or cmdlet 
# All keys are matched with the command parameter names and all values are 
#submitted to the appropriate parameters


$hash = @{
    Path = $env:windir
    Filter = '*.ps1'
    Recurse =$true
    ErrorAction='SilentlyContinue'

}

Get-ChildItem @hash
#Equivalent to
Get-ChildItem -Path $env:windir -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue


#################################################
#19-Forwarding Parameters 
######Splatting in combination with $PSBoundParameters

function Get-BIOS{
    param(
        $ComputerName,
        $Path
        )

        Get-WmiObject -Class Win32_BIOS @PSBoundParameters

}

#alternatively

function Get-BIOS{
param(
$SomethingElse,
$ComputerName,
$Path
    )
$null = $PSBoundParameters.Remove(‘SomethingElse’)
“The parameter $SomethingElse still exists but will not get splatted”
Get-WmiObject -Class Win32_BIOS @PSBoundParameters
}


#################################
#20-Exiting a Function
# to exist a function immediately, we use "return"statement

function Get-NamedProcess{
    param
    ($name=$null)
    if ($name -eq $null)
    {
        Write-Host -ForegroundColor Red ‘Specify a name!’
        return
       }
    Get-Process $name
}


function ConvertTo-Binary{
    param($Number)
    return [System.Convert]::ToString($Number, 2)
}


###########################################
#21-Defining return values 
# When ever function code "leaves behind" information, 
# Powershell automatically sends this information to Write-Output

function Test-ReturnValue
{
Write-Output 1
Write-Output ‘Hello’
Write-Output (Get-Date)
}


function Test-ReturnValue
{
1
‘Hello’
Get-Date
}


function Test-ReturnValue
{
1
‘Hello’
return Get-Date
}



##############################
#22-Declaring Function Return Type
# PS3.0 => we can declare the output type of the function most likely returns
# OutputType Attribute 


function Test-IntelliSense{
    [OutputType(‘System.DateTime’)]
    param()
    return Get-Date
}


############################
#23-Accepting Pipeline Data in Realtime 
# making a function work inside a pipeline and accept information from previous cmdlets or function
# at mininmum we need on parameter that is marked to accept pipeline information
function Test-Pipeline {
    param(
    [Parameter(ValueFromPipeline=$true)]
    $InputObject
    )
    process
    {
    “Working with $InputObject”
    }
}


#########################
#24 - Accepting Pipeline Data as a block 
# to get the input as one single chunk 
function Test-Pipeline {
    $pipelineData = @($Input)
    $Count = $pipelineData.Count
    “Received $Count elements: $pipelineData”
}

#when $input is not converted into an array 
function Test-Pipeline {
$Count = $Input.Count
“Received $Count elements: $Input”
}

############################
# 25-Using Pipeline Filters 
#filter keyword is used to create a simple pipleine-aware function
# filters are deprecated but they still work 
# an excellent and fast way to create pipeline Filters
Filter Test-ApplicationProgram{
    if ($_.MainWindowTitle -ne ‘’)
    {
    $_
    }
}

#######################################
#26- Determine Functions Pipleline Position
# Determine if the function is the last element in the pipeline or operating in the middle of it
function Test-PipelinePosition {
    param
    (
    [Parameter(ValueFromPipeline=$true)]
    $data
    )
process{
    if ($MyInvocation.PipelinePosition -ne $MyInvocation.PipelineLength)
        {
        $data
        }
        else
        {
        Write-Host $data -ForegroundColor Red -BackgroundColor White
        }
    }
}


##################################
#27- Adding Write protection to Functions 
# function by default are not write-protected so they can easily be overwritten and redefined.
# how to make a function read-only 

function ReadOnlyOption-UserDefined{
    "You cannot override/overwrite me!"

}

(Get-Item function:ReadOnlyOption-UserDefined).Options ='ReadOnly'

#Removing and user defined function and then redefine it  
Remove-Item function:ReadOnlyOption-UserDefined -Force

# to make the function"Constant"
# prevent it from deleting as shown above 
# define the function as a Constant in the first place 

$code ={
    "You cannot override/overwrite me:"
} 

New-Item function:Test-UserDefinedReadonly -Options Constant -Value $code 



###########################
#28- Monitoring changes on Functions and Viewing Source Code 
#New-ISESnippet to monitor changes 
${function:New-IseSnippet}
${function:New-IseSnippet} | clip.exe
$psISE.CurrentPowerShellTab.Files.Add().Editor.Text = ${function:New-IseSnippet}

function Get-FunctionSourceCode{
    param($FunctionName)
    $Path = “function:$FunctionName”
    if (Test-Path -Path $Path)
    {
    $sourceCode = Get-Item -Path $Path |
    Select-Object -ExpandProperty Definition
    $psISE.CurrentPowerShellTab.Files.Add().Editor.Text = $sourceCode
    }
    else
    {
    Write-Warning “Function $FunctionName not found.”
    }
}



###################################
#29-Common Parameters 
# While user defined function parameters are defined inside the "param" block
# We can still use the standard set of common parameters -just like cmdlets

function Test-Function{
    param
    (
    $MyParameter
    )
}


function Test-Function{
    [CmdletBinding()]
    param
    (
    $MyParameter
    )
}


function Test-Function{
    [CmdletBinding()]
    param
    (
    $MyParameter
    )
    Write-Verbose “Starting”
    “You entered $MyParameter”
    Write-Verbose “Ending”
}


########################################
#30- Risk Mitigation Parameters 
# -WhatIf (used for simulation)
# -Confirm (used for confirmed actions)
#"SupportsShouldProcess" to enable risk mitigation parameters 
function New-Folder{
[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact=’Medium’)]
    param
    (
    $Path
    )
New-Item -Path $Path -ItemType Directory
}

#########################################
#31-Custom Risk Mitigation Code 
#fully control which parts of your function get executed and which get skipped 
# when a user uses -WhatIf or -Confirm
function New-Folder{
[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact=’Medium’)]
    param(
    [Parameter(Mandatory=$true)]
    $Path
    )
    # remove all limitations for remaining code:
    $WhatIfPreference = $false
    $ConfirmPreference = ‘None’
    # use limitations only here:
    if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME,”Creating Folder $Path”))
    {
    New-Item -Path $Path -ItemType Directory
    }
    else
    {
    Write-Host ‘Just simulating...!’ -ForegroundColor Green
    }
}




###########################################
#32- Adding Rich Help Documentation for the functions 
# place the snippet code before the function using a comment block

<#
.SYNOPSIS
Short description
.DESCRIPTION
Long description
.EXAMPLE
Example of how to use this cmdlet
.EXAMPLE
Another example of how to use this cmdlet
#>
Function MyHelp-Demo{
    "My Help Demo Function demonstrates the help"
}


#####################
Alternatively 

function MyHelp-Demo{
<#
.SYNOPSIS
Short description
.DESCRIPTION
Long description
.EXAMPLE
Example of how to use this function
.EXAMPLE
Another example of how to use this function
#>
    param
    (
    # Documentation for parameter1
    $Parameter1,
    # Documentation for parameter2
    $Parameter2
    )
‘I am documented’
}


###################
alternatively 

 function MyHelp-Demo{

    param
    (
    # Documentation for parameter1
    $Parameter1,
    # Documentation for parameter2
    $Parameter2
    )
    ‘I am documented’
<#
.SYNOPSIS
Short description
.DESCRIPTION
Long description
.EXAMPLE
Example of how to use this function
.EXAMPLE
Another example of how to use this function
#>
}













