$Version = 0.9
$FPSName = split-Path $PSCommandPath -Leaf
$FPSName = $FPSName.Substring(0,(($FPSName.Length) - 4))
$UtilVersionList = Invoke-RestMethod "https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/UtilVersion"
$VersionLine = ($UtilVersionList).split([Environment]::NewLine) | Select-String -Pattern "$FPSName" -SimpleMatch
$VersionLine = $VersionLine.ToString()
$VersionMaster = $VersionLine.SubString(($VersionLine.Length) -3)
$NewVersion = Invoke-RestMethod "https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/$FPSName.ps1"

$FluffyUtils = "
   ______     ______       __  ____  _ __  
  / __/ /_ __/ _/ _/_ __  / / / / /_(_) /__
 / _// / // / _/ _/ // / / /_/ / __/ / (_-<
/_/ /_/\_,_/_//_/ \_, /  \____/\__/_/_/___/
                 /___/                     
"

Write-Host $FluffyUtils 
Write-Host "  You Are Running $FPSName v$Version"
Write-Host "    Hosted On Github.com/MrFlufficans"
if ($VersionMaster -gt $Version) {
    Write-Host "`n  There is a New Version Available v$VersionMaster`n        Would you Like to Update?"
    $ConfirmUpdate = Read-Host "`t`t"
    $ConfirmUpdate = ($ConfirmUpdate.ToLower()).ToString()
    If ($ConfirmUpdate -match '^y(es)?$') {
        $Update = 1
    } else {
        $Update = 0    
    }
} else {$Update = 0}

Start-Sleep 1

If ($Update) {
    Write-Host "`nFetching Update"
    Start-Sleep 1
    If (Test-Path -Path ".\$FPSName.ps1" -PathType Leaf) {Clear-Content ".\$FPSName.ps1"}
    $NewVersion >> "$FPSName.ps1"
    Write-Host "Script Updated"
    Start-Sleep 1
    Write-Host "Relaunching in 3"
    Start-Sleep 1
    Write-Host "Relaunching in 2"
    Start-Sleep 1
    Write-Host "Relaunching in 1"
    Start-Sleep 1
    Start-Process powershell ".\$FPSName.ps1"
    Exit
} else {}


#Everything Above is just the Auto Update
#Actual Script Below Here


$ToShow = @()
Write-Host "`n How many Days to you want to Check back?"
$DaysBack = Read-Host "                 "
$DaysBack = [int]$DaysBack
(Get-ChildItem -Attributes !D -exclude Results.txt,!resource_folder.txt,!help_entities.txt,LICENSE_OFL.txt -include *.xml,*.txt -Recurse) | foreach {    
    $ParentFolder = ($_).Directory.Name
    $Name = ($_).Name
    
    if (($_).LastWriteTime.Year -lt (Get-Date).Year) {$Modified = 0} else {
        if (($_).LastWriteTime.Month -lt (Get-Date).Month) {$Modified = 0} else {
            If (($_).LastWriteTime.Day -gt (Get-Date).Day -$DaysBack) {$Modified = 1} else {
                if ($DaysBack -eq 0 -and ($_).LastWriteTime.Day -eq (Get-Date).Day) {
                    if (($_).LastWriteTime.Hour -lt (Get-Date).Hour) {$Modified = 1}
                } else {$Modified = 0}
            }
        }
    }
    
    if ($Modified) {
        if ($Modified) {$Modified = "True"}
        $Object = New-Object -TypeName PSObject
        Add-Member -InputObject $Object -MemberType NoteProperty -Name Modified -Value $Modified
        Add-Member -InputObject $Object -MemberType NoteProperty -Name ParentFolder -Value $ParentFolder
        Add-Member -InputObject $Object -MemberType NoteProperty -Name Name -Value $Name
        $ToShow += $Object
    }
}
If (Test-Path -Path .\Results.txt -PathType Leaf) {Clear-Content Results.txt}
$ToShow | Format-Table -Autosize 
Write-Host "Press Any Key to Output to Text"
cmd /c pause | out-null
$ToShow | Format-Table -Autosize >> Results.txt