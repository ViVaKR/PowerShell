#-> TEST 문자가 뒤에 붙어 있으면 삭제하고, TEST 만 있으면 그대로 유지하기

$pattern = '\w{1,}(TEST)$'

$strs = @('ARSTEST', 'KRW', 'KRWTEST', 'ARS', 'TEST', 'USDTEST')

foreach ($item in $strs) {
    $mc = [regex]::Matches($item, $pattern)
    if ($mc.groups.count -gt 1) {
        $mc.groups[0].value -replace $mc.groups[1].value
    }
    else {
        $item
    }
}
