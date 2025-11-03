class Device {
    #Class properties
    [string] $Brand
}

$dev = [Device]::new()
$dev.Brand = "Viv"
$dev.Brand
