Write-Host "`e[2J`e[H"  # Clear screen and move cursor to home position
Write-Output "`e[48;5;163m[ Start ANSI ]`e[0m" # Background color
Start-Sleep 3

Write-Output "ASCII Art`e[?25l"

$asciiArt = @"
`e[31m
  _______ _                 _     _ _ _
 |__   __| |               | |   | | | |
    | |  | |__   __ _ _ __ | |__ | | | |
    | |  | '_ \ / _\`e[32m | '_ \| '_ \| | | |
    | |  | | | | (_  | | | | |_) | | | | |
    |_|  |_| |_|\__,_|_| |_|_.__/|_|_|_|  `e[0m
"@

Write-Output $asciiArt
Start-Sleep 1

# Write-Output "`e[1m$pwd`e[2A"; Start-Sleep 2

$text = 'Hello, World!'
# Write-Host "`e[1;35m$text`e[0m"
# Write-Host "`e[H"
# Write-Host "`e[1;36mHi, Everyone`e[0m"

# Write-Output "`e[3S$text `e[3s"
# Write-Output "`e[0m"
# WRite-Output "`e[s$text`e[u`e[1P"
Clear-Host

Write-Output "`e[15;15H"
Write-Output "Moves cursor to line, column"
Write-Output "`e[10C$Text"
Clear-Host

$array = @('One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten')
for ($i = 0; $i -lt $array.Count; $i++) {
    Write-Output "`e[1;$($i + 30)m`e[$($i * 2 + 1)C $($array[$i]) - 'e[$($i + 30)m'"you
}
Write-Host "`e[0m"

Write-Output "`e[10Amove cursor up #A"

# $continue = Read-Host -Prompt "Continue? [y/n]"
# Clear-Host
# if ($continue -eq 'y') {
#     Write-Output "`e[10Bmove cursor down #B"
#     Start-Sleep 2
#     Write-Output "`e[10Cmove cursor right #C"
#     Start-Sleep 2
#     Write-Output "`e[10Dmove cursor left #D"
#     Start-Sleep 2
#     Write-Output "`e[10Emove cursor down #E"
#     Start-Sleep 2
#     Write-Output "`e[10Fmove cursor up #F"
#     Start-Sleep 2
#     Write-Output "`e[10Gmove cursor to column #G"
#     Start-Sleep 2
#     Write-Output "`e[10;10Hmove cursor to line, column #;H"
#     Start-Sleep 2
#     Write-Output "`e[10;10fmove cursor to line, column #;f"
#     Start-Sleep 2
#     Write-Output "`e[10;10rset scrolling region #;r"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20Hmove cursor to line, column #;H"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20fmove cursor to line, column #;f"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20rset scrolling region #;r"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20;30;30Hmove cursor to line, column #;H"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20;30;30fmove cursor to line, column #;f"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20;30;30rset scrolling region #;r"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20;30;30;40;40Hmove cursor to line, column #;H"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20;30;30;40;40fmove cursor to line, column #;f"
#     Start-Sleep 2
#     Write-Output "`e[10;10;20;20;30;30;40;40rset scrolling region #;r"
# }

Clear-Host
# 메뉴 선택
$title = 'Question'
$question = 'Do you want to continue?'
$choice = '&Yes', '&No', '&Cancel'
$decision = $Host.UI.PromptForChoice($title, $question, $choice, 1)


if ($decision -eq 0) {
    Write-Host "`e[1;38;5;198mYou Selected Yes"
    Write-Host "`e[38;5;198mYou Selected Yes"
    for ($i = 0; $i -lt 256; $i++) {
        # Write-Host -NoNewline
        # "`e[38;5;$($i)m $($i) " | Format-Table  | Write-Host -NoNewline
        # `e[38;5;$($i)m
        "`e[48;5;$($i)m {0,3} " -f $i | Write-Host -NoNewline



        if (($i + 1) % 12 -eq 0) {
            Write-Output ""
        }
    }
    write-host "`e[0m"
    for ($i = 0; $i -lt 256; $i++) {
        # Write-Host -NoNewline
        # "`e[38;5;$($i)m $($i) " | Format-Table  | Write-Host -NoNewline
        # `e[38;5;$($i)m
        "`e[1;38;5;$($i)m {0,3} " -f $i | Write-Host -NoNewline



        if (($i + 1) % 12 -eq 0) {
            Write-Output ""
        }
    }
}
elseif ($decision -eq 1) {
    Write-Output "You Selected No"
    [System.Environment]::Exit(0)
}
else {
    Write-Output "You Selected Cancel"
}
Write-Output "`e[0m"

Write-Output "Format Scpecifiers"
"|{0,-10}| |{1,10}|" -f "hello", "world" | Write-Output

"D -> {0:D}" -f 1234567890 | Write-Output

Write-Host "`e[?25h"
Get-ChildItem -Path . -File | Format-Table -AutoSize

clear-host
Write-Output "`e[?25l" # Hide cursor
Write-Host "Hide cursor for 2 seconds"
Start-Sleep 2

"`e[HHome" # Move cursor to home position
Start-Sleep 1


"`e[30BDown" # Move cursor down 10 lines
Start-Sleep 1

"`e[30CRight" # Move cursor right 10 columns
Start-Sleep 1

"`e[25A`e[30CUp" # Move cursor up 10 lines
Start-Sleep 1

"`e[10DLeft" # Move cursor left 10 columns
Start-Sleep 1

Write-Output "`e[?25h"  # Show cursor
<#
[?25l
[?25h

[38;2;{r};{g};{b}m

--> Cursor
H : Move cursor to home position
A : Move cursor up
B : Move cursor down
C : Move cursor right
D : Move cursor left
E : Move cursor to beginning of next line
F : Move cursor to beginning of previous line
G : Move cursor to column
#>
