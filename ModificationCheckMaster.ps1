$Version = 0.4
$Update = 0
$ConfirmUpdate = $null
$Things = Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/UtilVersion
$VersionLine = ($Things).split([Environment]::NewLine) | Select-String -Pattern "ModificationCheck" -SimpleMatch
$VersionLine = $VersionLine.ToString()
$VersionMaster = $VersionLine.SubString(($VersionLine.Length) -3)

(Invoke-RestMethod "https://artii.herokuapp.com/make?text=Fluffy+Utils&font=smslant") | Write-Host 
Write-Host "`n  You Are Running ModificationCheck v$Version"
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
    If (Test-Path -Path ./ModificationCheck.ps1 -PathType Leaf) {rm ./ModificationCheck.ps1}
    Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/ModificationCheckMaster.ps1 >> ModificationCheck.ps1
    Write-Host "Script Updated"

    Write-Host "Relaunching in 3"
    Start-Sleep 1
    Write-Host "Relaunching in 2"
    Start-Sleep 1
    Write-Host "Relaunching in 1"
    Start-Sleep 1
    Start-Process powershell ./ModificationCheck.ps1
    Exit
} else {}


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
If (Test-Path -Path ./Results.txt -PathType Leaf) {Clear-Content Results.txt}
$ToShow | Format-Table -Autosize 
Write-Host "Press Any Key to Output to Text"
$ToShow | Format-Table -Autosize >> Results.txt
cmd /c pause | out-null