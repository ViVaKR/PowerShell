
clang -std=c17 -g -Wall -o bin/DemoA.exe .\DemoA.c && .\bin\DemoA.exe

Write-Output $LASTEXITCODE

Start-Sleep (New-TimeSpan -Seconds 2) # or Minutes, Hours, Days
$c = [char]0x26A9
switch ($LASTEXITCODE) {
    1 {

        "${c} Completed {0,3} " -f $LASTEXITCODE | Write-Host
        "{0:yyyy-MM-dd}" -f (Get-Date) | Write-Output
    }
    2 {  }
    3 {  }
    Default {}
}
