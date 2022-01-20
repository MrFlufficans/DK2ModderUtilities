$Version = 0.3
$Update = 0
$ConfirmUpdate = $null
$Things = Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/UtilVersion
$VersionLine = ($Things).split([Environment]::NewLine) | Select-String -Pattern "ModInstaller" -SimpleMatch
$VersionLine = $VersionLine.ToString()
$VersionMaster = $VersionLine.SubString(($VersionLine.Length) -3)

If (Test-Path -Path ./ModInstallerMaster.ps1 -PathType Leaf) {
    rm ./ModInstallerMaster.ps1
    Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/ModInstallerMaster.ps1 >> ModInstaller.ps1
}

(Invoke-RestMethod "https://artii.herokuapp.com/make?text=Fluffy+Utils&font=smslant") | Write-Host 
Write-Host "`n   You Are Running Mod Installer v$Version"
Write-Host "   Hosted On Github.com/MrFlufficans"
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
    If (Test-Path -Path ./ModInstaller.ps1 -PathType Leaf) {rm ./ModInstaller.ps1}
    Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/ModInstallerMaster.ps1 >> ModInstaller.ps1
    Write-Host "Script Updated"

    Write-Host "Relaunching in 3"
    Start-Sleep 1
    Write-Host "Relaunching in 2"
    Start-Sleep 1
    Write-Host "Relaunching in 1"
    Start-Sleep 1
    Start-Process powershell ./ModInstaller.ps1
    Exit
} else {}

if (!(Test-Path -Path .\README.txt)) {
    Write-Host "`n`n    I couldn't find A ReadMe File"
    Write-Host "       Please Create one and"
    Write-Host " Put The Mods Name on the First Line"
    Start-Sleep 6
    exit
}
$ReadMe = Get-Content .\ReadMe.txt
$ModName = ($ReadMe).split([Environment]::NewLine) | Select -First 1

if (Test-Path -Path $env:LOCALAPPDATA\KillHouseGames\DoorKickers2\mods\$ModName) {rm $env:LOCALAPPDATA\KillHouseGames\DoorKickers2\mods\$ModName -Recurse}
Copy-Item -path .\$ModName -Destination $env:LOCALAPPDATA\KillHouseGames\DoorKickers2\mods -Recurse

Write-Host "`n $ReadMe has been Installed"
Start-Sleep 3