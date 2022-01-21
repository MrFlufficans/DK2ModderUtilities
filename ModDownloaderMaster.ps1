$Version = 0.1
$UtilVersionList = Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/UtilVersion
$VersionLine = ($UtilVersionList).split([Environment]::NewLine) | Select-String -Pattern "ModDownloader" -SimpleMatch
$VersionLine = $VersionLine.ToString()
$VersionMaster = $VersionLine.SubString(($VersionLine.Length) -3)
$NewVersion = Invoke-RestMethod https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/ModDownloaderMaster.ps1

$FluffyUtils = "
   ______     ______       __  ____  _ __  
  / __/ /_ __/ _/ _/_ __  / / / / /_(_) /__
 / _// / // / _/ _/ // / / /_/ / __/ / (_-<
/_/ /_/\_,_/_//_/ \_, /  \____/\__/_/_/___/
                 /___/                     
"

If (Test-Path -Path .\ModDownloaderMaster.ps1 -PathType Leaf) {
    rm .\ModDownloaderMaster.ps1
    $NewVersion >> .\ModDownloader.ps1
    If (Test-Path -Path .\ModDownloaderMaster.ps1 -PathType Leaf) {
        rm .\ModDownloader.ps1
        $NewVersion >> .\ModDownloader.ps1
    }
}

Write-Host $FluffyUtils 
Write-Host "  You Are Running Mod Downloader v$Version"
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
    If (Test-Path -Path .\ModDownloader.ps1 -PathType Leaf) {Clear-Content -Path .\ModDownloader.ps1}
    $NewVersion >> ModDownloader.ps1
    Write-Host "Script Updated"

    Write-Host "Relaunching in 3"
    Start-Sleep 1
    Write-Host "Relaunching in 2"
    Start-Sleep 1
    Write-Host "Relaunching in 1"
    Start-Sleep 1
    Start-Process powershell .\ModDownloader.ps1
    Exit
} else {}

if (Test-Path -Path ".\AuthorSig*" -PathType Leaf) {
 $AuthorSig = (Get-Content ".\AuthorSig*").split([Environment]::NewLine)
 if (($AuthorSig | Select-Object -Index 0) -match "https://github.com/*") {$GithubURL = ($AuthorSig | Select-Object -Index 0)} else {
    $AuthorName = $AuthorSig | Select-Object -Index 0
    $ModName = $AuthorSig | Select-Object -Index 1
    $BranchName = $AuthorSig | Select-Object -Index 2
 }
} else {
    Write-Host "`nI couldn't Find the Author Signature File"
    Write-Host "           Please Create one"
    Start-Sleep 3
    exit
}

if ($GithubURL -eq $null) {$GithubURL = "https://github.com/$AuthorName/$ModName/archive/refs/heads/$BranchName.zip"}
sleep 5

Invoke-RestMethod -uri "$GithubURL" -OutFile .\$ModName.zip
