$Version = "1.2"
$FPSName = "ModInstaller"
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
Write-Host "   You Are Running $FPSName v$Version"
Write-Host "  Hosted On Github.com/MrFlufficans"
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


if (!(Test-Path -Path ".\README.txt" -PathType Leaf)) {
    Write-Host "`n`n    I couldn't find A ReadMe File"
    Write-Host "       Please Create one and"
    Write-Host " Put The Mods Name on the First Line"
    Start-Sleep 5
    exit
}

$ReadMe = Get-Content ".\README.txt"
$ModName = ($ReadMe).split([Environment]::NewLine) | Select-Object -First 1

if (!(Test-Path -Path ".\$ModName")) {
    Write-Host "`nI can't seem to find the $ModName folder"
    Write-Host "        Is $ModName Correct?"
    Start-Sleep 5
    exit
}

if (Test-Path -Path "$env:LOCALAPPDATA\KillHouseGames\DoorKickers2\mods\$ModName") {Remove-Item "$env:LOCALAPPDATA\KillHouseGames\DoorKickers2\mods\$ModName" -Recurse}
Copy-Item -path ".\$ModName" -Destination "$env:LOCALAPPDATA\KillHouseGames\DoorKickers2\mods\$ModName" -Recurse

Write-Host "`n $ModName has been Installed"
Start-Sleep 3



# SIG # Begin signature block
# MIIFUgYJKoZIhvcNAQcCoIIFQzCCBT8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU4okhvwRvo2ZBUBlNwpbud2OD
# ntSgggL2MIIC8jCCAdqgAwIBAgIQGYoxa96RMZtFJxUw11CCBjANBgkqhkiG9w0B
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
# BgkqhkiG9w0BCQQxFgQUJpe8qx+FDOfONNq9RUNfjO1wSS0wDQYJKoZIhvcNAQEB
# BQAEggEAArHLN9Vl1OocwAZ2WRMeEYifeZCHcySXRFEf1mHlYDGky8gtSafOG6js
# 4Q0c+OWut4kwswAXi7hPlH0qp29DUJfRPZ0PwXaPjW4TzTRHnwJBDktRMc717AhI
# f450HflRVJVGlnp0wSgD8DpCLiVIWcpy5o2ENNtNdzZA82HWBkuwmyEBPUccP+Eh
# TV/VKOFkeTKA26su0C+yue/MI5+4yMotOwnFVlyZmM+4QU8sLzS+Xn+34CVAXLui
# WakQG4y8bfLsNoqrL1nzDTuc7qumMJtWIQGo8a0gG+esO9usd53DF5nZqarY3+Vc
# bw9qarnLuE1RiUYmEjrjnO+lLb9jsQ==
# SIG # End signature block
