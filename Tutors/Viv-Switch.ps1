#! Switch

#- 값 일치
$choice = 2
switch ($choice) {
    1 { Write-Host "You Selected Menu item 1" }
    2 { Write-Host "You Selected Menu item 2" }
    3 { Write-Host "You Selected Menu item 3" }
    Default { Write-Host "You did not select a valid option"}
}

#- 패턴일치
$ip = "10.20.1.1"
switch -WildCard ($ip) {
    "10.*" { Write-Host "This computer is on the internal network" }
    "10.1" { Write-Host "This computer is in Seoul" }
    Default { Write-Host "This computer is not on the internal network"}
}
