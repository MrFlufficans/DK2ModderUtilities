$Version = "1.0"
$FPSName = split-Path $PSCommandPath -Leaf
$FPSName = $FPSName.Substring(0,(($FPSName.Length) - 4))
$UtilVersionList = Invoke-RestMethod "https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/UtilVersion"
$VersionLine = ($UtilVersionList).split([Environment]::NewLine) | Select-String -Pattern "$FPSName" -SimpleMatch
$VersionLine = $VersionLine.ToString()
$VersionMaster = $VersionLine.SubString(($VersionLine.Length) -3)

$FluffyUtils = "
   ______     ______       __  ____  _ __  
  / __/ /_ __/ _/ _/_ __  / / / / /_(_) /__
 / _// / // / _/ _/ // / / /_/ / __/ / (_-<
/_/ /_/\_,_/_//_/ \_, /  \____/\__/_/_/___/
                 /___/                     
"

Write-Host $FluffyUtils 
Write-Host "  You Are Running $FPSName v$Version"
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
    $NewVersion = Invoke-RestMethod "https://raw.githubusercontent.com/MrFlufficans/DK2ModderUtilities/master/$FPSName.ps1"
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
(Get-ChildItem -Attributes !D -exclude Results.txt,!resource_folder.txt,!help_entities.txt,LICENSE_OFL.txt -include *.xml,*.txt -Recurse) | ForEach-Object {    
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


# SIG # Begin signature block
# MIIFUgYJKoZIhvcNAQcCoIIFQzCCBT8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU+orJkcOK4ennor2ZPQuginFg
# clmgggL2MIIC8jCCAdqgAwIBAgIQGYoxa96RMZtFJxUw11CCBjANBgkqhkiG9w0B
# AQsFADARMQ8wDQYDVQQDDAZGbHVmZnkwHhcNMjIwMTIzMDkxNjQyWhcNMjMwMTIz
# MDkzNjQyWjARMQ8wDQYDVQQDDAZGbHVmZnkwggEiMA0GCSqGSIb3DQEBAQUAA4IB
# DwAwggEKAoIBAQDYrJ4j7LJFBH+2PvcYWG160G89fRdi/tviqPMyiPUprowIohnF
# M/c+/u0xTa1nO0TuYpKVc9cDZpz8kv3y5khYq+3tXGw0Ic4Oa2IWb/8TS8KzA6KE
# H1bU9oV8pbZDby7wEH0WO1wkupt5Iur+uV5axojCrSmVqe4UNWdOhCwUvs0lwUd6
# nzrZiKLKWbY0C73P7tezjvaRb3cJ9ILYCjfb00W7r5qk6A22lF3tSFHJRGJ1bBpe
# mwLkJt4hgQPbs0sCXxfSPZCP8FFKHb+v2BV/u6NcekmZyI4gBIrW0wtRGBCFOEo1
# Zg6NCzlwqPCexfoobP+OG6aFoRgswVzOvbsdAgMBAAGjRjBEMA4GA1UdDwEB/wQE
# AwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzAdBgNVHQ4EFgQUBsXvFb7RTLzhQ/d5
# cvrwxg8QeFowDQYJKoZIhvcNAQELBQADggEBANaNT+up1MUv0PjNc2/c0jFd0phK
# YW0VzU4xHvZcFUCrwLyvB9F4q+r1XoDgXk/mJKQuUiTjOWATIEU6ceySEsKwAzu7
# WvTyCkc+FUEBJjJXOEbA7q0oF6Jf1Z4LIAnQGIPSa5sFACRKINbcjcSCWcIvDHNf
# FUlDNuCuVdijpBKJITZEicXI00pWevPMtqJyxw+JMJ4Sy+LnrEqrZzah6d5swY1J
# 4grlLMijXaqhMGN5gqOTKjxvtXKy8TopBASyTUMWxqfrWBTKljusAMtX6946yxTp
# nPsylbvixVldBCqn4xlW/59yFJQYOQB8NoR+PWqip3OcKI0w3MUei+f3tmcxggHG
# MIIBwgIBATAlMBExDzANBgNVBAMMBkZsdWZmeQIQGYoxa96RMZtFJxUw11CCBjAJ
# BgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0B
# CQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAj
# BgkqhkiG9w0BCQQxFgQUJdJt+OARL0SbwGaBzePLevf3niUwDQYJKoZIhvcNAQEB
# BQAEggEAnkKxA1eEAv0dO6fYpBH4qB88928SIWqGYjd7B2pu1hu7jlxr7jLcn80q
# S+VDgyrzzgLY1Mir2+go7to5tesnzv1NeSRLvCbNP7DfAGMk15hkcN0qjTO2jbND
# QW2mPWH6M6G2pVZOnv5xgtLHx72eyL37cfFHf4nPkfoWiB6yokDGYZKKNysGlKOr
# HfQOWlzZM/D0dwEI0Pvgg5g5zni2JUnSKn1qiRCCvNVdpwD0Z8Mg0yrfTuDoJFZS
# 1z7n5kwAmsb6q+1z7+3RxtbuM8Cp/v3zZh94mMwfwwdmFmWRNZ26c8OJ/C1PBEp7
# 02Bg9w/l7ofjMsKhgg2V5GuA7K+aDQ==
# SIG # End signature block
