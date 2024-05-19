# Switch Item : 매개변수 유무에 따른 실행
# Switch-Item -on or -off
# Switch-Item -on:$True
function Switch-Item {
    param ([switch]$on)
    if ($on) { "Switch On" }
    else { "Switch Off" }
}
