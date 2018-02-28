###########################################
##    Syed Awase Khirni
##    awasekhirni@gmail.com
##    sak@sycliq.com/sak@territorialprescience.com 
##    +91.9035433124
## Please do not remove this
##  
############################################

#Resolving paths 
Resolve-Path .\myprocess.txt
#alternatively we can use for Resolve-Paths
$ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath(‘.\myprocess.txt’)
#sophisticated directory filtering 
##Get-ChildItem now supports sophisticated filtering through its -Attributes parameter. To get all files in your Windows
#folder or one of its subfolders that are not system files but are encrypted or compressed, use something like this:
Get-ChildItem $env:windir -Attributes !Directory+!System+Encrypted,!Directory+!System+Compressed -Recurse -ErrorAction SilentlyContinue
# 3- Finding files only or folders only 
# to list only files or only folders 
Get-ChildItem $env:windir | Where-Object {$_.PSIsContainer -eq $true}
Get-ChildItem $env:windir |Where-Object {$_.PSIsContainer -eq $false}
# Alternatively 
Get-ChildItem $env:windir -File 
Get-ChildItem $env:windir -Directory

#4-Adding Personal Drives in Powershell
#allows you to create custom drives with custom drive names 

Function Add-PersonalDrive{
    [System.Enum]::GetNames([System.Environment+SpecialFolder]) |
        ForEach-Object{
        $name= $_ 
        $target = [System.Environment]::GetFolderPath($_)
        New-PSDrive $name FileSystem $target -Scope Global
        }
    }

#5-Discovering File System realted Cmdlets 
 Get-Command -Noun item*, path 
 #extracting the aliases for these cmdlets 
Get-Alias -Definition *-item*, *-path* | Select-Object Name, Definition | Out-GridView

#6-Cleaning the tempfolder with powershell 
#Simulation
$cutoff = (Get-Date) - (New-TimeSpan -Days 1)
$before = (Get-ChildItem $env:temp |Measure-Object Length -Sum).Sum 
Get-ChildItem $env:temp | Where-Object { $_.Length -ne $null} |
    Where-Object {$_.LastWriteTime -lt $cutoff} | 
    Remove-Item -Force -ErrorAction SilentlyContinue -Recurse -WhatIf

$after = (Get-ChildItem $env:temp | Measure-Object Length -Sum).Sum
$freed =$before-$after
Write-Host "Temporary Files Cleaned are of size:" ($freed/1MB)

#confirmed delete
Write-Host "Permenantly deleting Temporary files"
$cutoff = (Get-Date) - (New-TimeSpan -Days 1)
$before = (Get-ChildItem $env:temp |Measure-Object Length -Sum).Sum 
Get-ChildItem $env:temp | Where-Object { $_.Length -ne $null} |
    Where-Object {$_.LastWriteTime -lt $cutoff} | 
    Remove-Item -Force -ErrorAction SilentlyContinue -Recurse -Confirm

$after = (Get-ChildItem $env:temp | Measure-Object Length -Sum).Sum
$freed =$before-$after
Write-Host "Temporary Files Cleaned are of size:" ($freed/1MB)



#7- Unblocking and Unpacking zip files 
$source = 'E:\CT\Powershell\CodePlay\test.zip'
$Destination = 'E:\CT\Powershell\CodePlay\test'

Unblock-File $Destination 
$helper = New-Object -ComObject Shell.Application 
$files = $helper.NameSpace($Source).Items()
$helper.NameSpace($Destination).CopyHere($files)


#8 find Open Files
#script to file open files on a remote systems 
openfiles /Query /S storage1 /FO CSV /V | ConvertFrom-Csv | Out-GridView



#9- Finding Newest or oldest Files 

Get-ChildItem $env:windir |Measure-Object -Property Length -Minimum -Maximum | Select-Object -Property Minimum,Maximum

#Measuring LastWriteTime of the Objects in the directory
Get-ChildItem $env:windir | Measure-Object -Property LastWriteTime -Minimum -Maximum | Select-Object -Property Minimum,Maximum
#Measuring min and max start times of all the running processes

Get-Process | Where-Object StartTime | Measure-Object -Property StartTime -Minimum -Maximum | Select-Object -Property Minimum,Maximum

#10-Finding Duplicate Files 
# Using Hash tables we can find duplicates 
Function Find-DuplicateName{
    $Input | ForEach-Object{
        if($lookup.ContainsKey($_.Name)){
        '{0} ({1}) already exists in {2}.' -f $_.Name, $_.FullName, $lookup.$($_.Name)
        }
        else{
            $lookup.Add($_.Name, $_.FullName)
        }
    }

}
$lookup=@{}
Get-ChildItem $home |Find-DuplicateName
Get-ChildItem $env:windir |Find-DuplicateName 
Get-ChildItem $env:windir\system32 |Find-DuplicateName 



#11-Finding Old Files  
# to identify the files older than a specified number of days to delete or backup

 Filter Filter-Age($Days=10){
    if(($_.CreationTime -le (Get-Date).AddDays($days *-1))){$_}
  }

Dir $env:windir *.log -Recurse -ea 0 |Filter-Age -Days 5
#simulating delete
Dir $env:windir *.log -Recurse -ea 0 | Filter-Age -Days 10 | Del -WhatIf


#12-Finding System Folders 
# The Environment .NET class provides a static method named GetFolderPath() which provides the information. 
[Environment]::GetFolderPath('Desktop')

#13-Hidingin Drive Letters from users 
# Some problem the script is not working need to debug 
Function Hide-Drive{
    param($DriveLetter)
    $key=@{
        Path = 'HKCU:\Software\Microsoft\windows\CurrentVersion\Policies\Explorer'
        Name='NoDrives'
    }
    if ($DriveLetter -eq $null)
    {
    Remove-ItemProperty @key
    }
    else
    {
    $mask = 0
    $DriveLetter |     ForEach-Object { $_.toUpper()[0] } | Sort-Object |
    ForEach-Object { $mask += [Math]::Pow(2,(([Byte]$_) -65)) }
    Set-ItemProperty @key -Value $mask -type DWORD
    }
  }




#14-Checking Total Size of Downloads-Folder 
# Checking the size of default IE/Chrome/Downloads folder 
$folder = ”$env:userprofile\Downloads”
Get-ChildItem -Path $folder -Recurse -Force -ea 0 |
Measure-Object -Property Length -Sum |
ForEach-Object {
$sum = $_.Sum / 1MB
“Your Downloads folder currently occupies {0:#,##0.0} MB storage” -f $sum
}


#15-Sharing Folders 
# creating a folder and sharing it with others across the network 
Function New-Share{
    param($Path,$Name)
    try {
    $ErrorActionPreference = ’Stop’
    if ((Test-Path $Path) -eq $false){
    $null = New-Item -Path $Path -ItemType Directory
    }
    net.exe share $Name=$Path
    }
    catch {
    Write-Warning ”Create Share: Failed, $_”
    }
   }


#16-Shrinking Paths 
# File-related .Net Frameworks methods fail when the overall path length exceeds a certain length
# use low-level methods to convert lengthy paths to the old 8.3 notation which is a lot shorter in many cases
Function Get-ShortPath{
    param( [Parameter(Mandatory=$true)]
    $Path)
    $code = @’
[DllImport(“kernel32.dll”, CharSet = CharSet.Auto, SetLastError=true)]
public static extern uint GetShortPathName(string longPath,
StringBuildershortPath,uint bufferSize);
‘@
$API = Add-Type -MemberDefinition $code -Name Path -UsingNamespace System.Text -PassThru
$shortBuffer = New-Object Text.StringBuilder ($Path.Length * 2)
$rv = $API::GetShortPathName( $Path, $shortBuffer, $shortBuffer.Capacity )
    if ($rv -ne 0){
    $shortBuffer.ToString()
    }
    else
    {
    Write-Warning ”Path ‘$path’ not found.”
       }
    }


#17-Estimating the size of the folders 
Function Get-FolderSize{
    param($path=$home)
    $code = { (‘{0:#,##0.0} MB’ -f ($this/1MB)) }
    Get-ChildItem -Path $Path| Where-Object { $_.PSIsContainer } |
    ForEach-Object {
    Write-Progress -Activity ’Calculating Total Size for:’ -Status $_.FullName
    $sum = Get-ChildItem $_.FullName -Recurse -ErrorAction SilentlyContinue |
    Measure-Object -Property Length -Sum -ErrorAction SilentlyContinue
    $bytes = $sum.Sum
    if ($bytes -eq $null){
    $bytes = 0
    }
    $result = 1 | Select-Object -Property Path, TotalSize
    $result.Path = $_.FullName
    $result.TotalSize = $bytes | Add-Member -MemberType ScriptMethod -Name toString -Value $code -Force -PassThru 
    $result
    }
   }

#18-Bulk-Renaming Files 
#Rename-Item can rename hundred of fildes in one step 
$Global::i=1
Get-ChildItem -Path c:\test1\ -Filter *.jpg | Rename-Item -NewName { “picture_$i.jpg”; $global:i++}


#19-Monitoring Folder COntent
# Using FileSystemWatcher Object we can monitor a folder and write a log for all newly created files 
$folder = ’E:\CT\Powershell\CodePlay’
$timeout = 1000
$FileSystemWatcher = New-Object System.IO.FileSystemWatcher $folder
Write-Host ”Press CTRL+C to abort monitoring $folder”
while ($true) {
$result = $FileSystemWatcher.WaitForChanged(‘all’, $timeout)
if ($result.TimedOut -eq $false)
    {
Write-Warning (‘File {0} : {1}’ -f $result.ChangeType, $result.name)
    }
}
Write-Host ’Monitoring aborted.’

#20-Open File Exclusively by a single user and not allowing others to open
$path = ”$env:temp\somefile.txt” # MUST EXIST!
if ( (Test-Path$path) -eq$false)
    {
Set-Content-Value’test’-Path$path
    }
$file = [System.io.File]::Open($path, ’Open’, ’Read’, ’None’)
$reader = New-Object System.IO.StreamReader($file)
$text = $reader.ReadToEnd()
$reader.Close()
Read-Host ’Press ENTER to release file!’
$file.Close()

#21-Removing File Extensions
[system.io.path]::GetFileNameWithoutExtension(‘c:\test\report.txt’)

#22-Quickly changing File Extensions 
$oldpath = ‘c:\test\datei.csv’
$newpath = [System.IO.Path]::ChangeExtension($oldpath, ‘.xls’)
$oldpath
$newpath

#23-Grouping Files based on Size 
#Group-Object can auto-create hash tables so that we can easily create groups of object of a kind
$criteria = {
if ($_.Length -lt 1KB) {
‘tiny’
    } elseif ($_.length -lt 1MB) {
‘average’
    } else {
‘huge’ }
    }
$myFiles = dir $env:windir | Group-Object -Property $criteria -asHash -asString

$myFiles
$myFiles.huge

#24-Opening many files with a single command
# to quickly open all files of a kinds 
Function Open-File {
    param(
    [Parameter(Mandatory=$true)]
    $path
    )
    $paths = Resolve-Path $path -ea SilentlyContinue
    if ($paths -ne $null) {
    $paths | Foreach-Object { Invoke-Item $_ }
    } else {
    “No file matched $path.”
        }
    }

#26-Filtering Multiple File Types 
    Filter Where-Extension{
    param(
        [String[]]
        $extension = (‘.bmp’, ’.jpg’, ’.wmv’)
    )
    $_ |
    Where-Object {
    $extension -contains $_.Extension
    }
   }

   Dir $env:windir -Recurse -ea 0 | Where-Extension .log,.txt


#27-Creating ShortCuts on your Desktop 
$shell = New-Object -ComObject WScript.Shell
$desktop = [System.Environment]::GetFolderPath(‘Desktop’)
$shortcut = $shell.CreateShortcut(“$desktop\clickme.lnk”)
$shortcut.TargetPath = ”notepad.exe”
$shortcut.IconLocation = ”shell32.dll,23”
$shortcut.Save()


#28-Create Files and Folders in One Step 
#Use New-Item to create a file and folders 
New-Item -Path c:\subfolder\anothersubfolder\yetanotherone\test1.txt -Type File -Force


#29-Removing Recent Folders 
#Windows uses the special recent folder to remember which files have been openeed. 
Get-ChildItem ([Environment]::GetFolderPath(“Recent”)) | Remove-Item -Recurse -WhatIf

#30Displaying HexDumps 
Function Get-HexDump{
    param
    (
    $path,
    $width=10,
    $bytes=-1
    )
$OFS=’’
Get-Content -Encoding byte $path -ReadCount $width `
-TotalCount $bytes | ForEach-Object {
$byte = $_
if (($byte -eq 0).count -ne $width)
    {
$hex = $byte | ForEach-Object {
‘ ‘ + (‘{0:x}’-f $_).PadLeft(2,’0’)}
$char = $byte | ForEach-Object {
    if ([char]::IsLetterOrDigit($_))
    {
[char] $_
    }
    else
    {
‘.’
    }
    }
“$hex $char”
    }
    }
}
 

#31-Reading file Magic Number 
#each file has a unique magic number that tells windows what type of file it is
#this function retrieves the magic number 

 Function Get-MagicNumber{
            param
            (
            $path
            )
        Resolve-Path $path | ForEach-Object {
        $magicnumber = Get-Content -Encoding byte $_ -ReadCount 4 -TotalCount 4
        $hex1 = (‘{0:x}’ -f ($magicnumber[0] * 256 + $magicnumber[1])).PadLeft(4,’0’)
        $hex2 = (‘{0:x}’ -f ($magicnumber[2] * 256 + $magicnumber[3])).PadLeft(4,’0’)
        [string] $chars = $magicnumber|ForEach-Object{
    if ([char]::IsLetterOrDigit($_))
        {
        [char] $_
        }
        else
        {
        ‘.’
        }
        }
        “{0} {1} ‘{2}’” -f $hex1, $hex2, $chars }
}


#32-Rename Drive Label 
#WMI can read any drive label and change the drive label too
$drive = [wmi]”Win32_LogicalDisk=’C:’”
$drive.VolumeName = ”My Harddrive”
$drive.Put()


#33 No Need for Virtual Drives 
Dir Registry::HKEY_CLASSES_ROOT
New-PSDrive HKCR Registry HKEY_CLASSES_ROOT
Dir HKCR:


#32 Temporary File Name 
(Get-Date -format 'yyyy-MM-ddhh-mm-ss')+'.tmp'


#33-Creating a large Dummy file with .NET
$path = ”$env:temp\testfile.txt”
$file = [io.file]::Create($path)
$file.SetLength(1gb)
$file.Close()
Get-Item $path



#34 Check whether a specific file existing in a folder
Test-Path $home\*.ps1
@(Get-ChildItem $home\*.ps1).Count
Test-Path c:\test -PathType Container


#35- Get a list of hidden files 

Get-ChildItem $env:windir -Force 
Get-ChildItem $env:windir -Force |Where-Object {$_.Mode -like '*h*'}
Get-ChildItem $env:windir -Attributes h 


#36 Converting FileSystem to NTFS 
Function ConvertTo-NTFS{
    param
    (
    $letter=’C:’
    )
if (!(Test-Path $letter))
    {
Throw ”Drive $letter does not exist.”
    }
$drive = [wmi]”Win32_LogicalDisk=’$letter’”
$label = $drive.VolumeName
$filesystem = $drive.FileSystem
if ($filesystem -eq ’NTFS’)
    {
Throw ’Drive already uses NTFS filesystem’
    }
“Label is $label”
$label |
convert.exe $letter /FS:NTFS /X
}



#37 Reading and Writign Drive Labels 

    Function Get-DriveLabel{
    param
    (
    $letter=’C:’
    )
    if (!(Test-Path $letter)){
    Throw ”Drive $letter does not exist.”
    }
    ([wmi]”Win32_LogicalDisk=’$letter’”).VolumeName
    }

    #changing the drive label 
    Function Set-DriveLabel{
    param
    (
    $letter=’C:’,
    $label=’New Label’
    )
    if (!(Test-Path $letter))
    {
    Throw ”Drive $letter does not exist.”
    }
    $instance= ([wmi]”Win32_LogicalDisk=’$letter’”)
    $instance.VolumeName = $label
    $instance.Put()
    }

    #requires Admin previleges 
    Set-DriveLabel D: ‘A new label’

#38- Determining a Drives File System
#not working 
    Function Get-FileSystem{
        param
        (
        $letter=’C:\’
        )
        if (!(Test-Path $letter))
            {
        Throw ”Drive $letter does not exist.”
            }
        ([wmi]”Win32_LogicalDisk=’$letter’”).FileSystem
    }

    #executing 
    Get-FileSystem 

#39- Removing Illegal File Name Characters 
$file = ’this*file\\is_illegal<>.txt’
$file
$pattern = ’[{0}]’ -f ([Regex]::Escape([String] `
[System.IO.Path]::GetInvalidFileNameChars()))
$newfile = [Regex]::Replace($file, $pattern,’’)
$newfile

##40- Simple Path Analysis 
#Split-path cmdlet helps in disassembling paths and find interesting information from it

Split-Path E:\CT\Powershell\CodePlay\myprocess.txt
Split-Path E:\CT\Powershell\CodePlay\myprocess.txt -IsAbsolute
Split-Path E:\CT\Powershell\CodePlay\myprocess.txt -Leaf
Split-Path E:\CT\Powershell\CodePlay\myprocess.txt -NoQualifier
Split-Path E:\CT\Powershell\CodePlay\myprocess.txt -Parent
Split-Path E:\CT\Powershell\CodePlay\myprocess.txt -Qualifier


#41-Select Folder-Dialog 
Function Select-Folder{
    param
    (
    $message=’Select a folder’,
    $path = 0
    )
$object = New-Object -ComObject Shell.Application
$folder = $object.BrowseForFolder(0, $message, 0, $path)
if ($folder -ne $null) { $folder.self.Path }
}
Select-Folder ’Select the folder you want!’Select-Folder -message ’Select some folder!’ -path
$env:windir


#42-Getting the Drive Information 
# we use .NET System.IO.DriveInfo 
$drive = New-Object System.io.DriveInfo ‘C:'
$drive.DriveFormat
$drive.DriveType
$drive