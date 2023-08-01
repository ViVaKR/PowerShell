
# [ 등호, (`i` 대소문자 구분하지 않음, `c` 대소문자 구분) ]
# 널값 확인 $null 을 왼쪽에 배치
# -eq, -ieq, -ceq :  같음
    2 -eq 2 # => True
    "abc" -eq "ABC" # => True
    1, 2, 3 -eq 2 # => 2
    "abc", "def" -eq "abc" # => abc
    "zzz", "def", "zzz" -eq "zzz" # => "zzz" "zzz"
    1 -eq '1.0' # => True
    '1.0' -eq 1 # => False

    $a = $null
    $null -eq $a # True

    $a = 1, 2, $null, 4, 

# -ne, ine, -ceq  : 같지 않믐
    "abc", "def" -ne "abc" # => def

# -gt, igt, -cgt  : 보다 큼
# -ge, -ige, -cge : 보다 크거나 같음
# -lt, -ilt, -clt : 보다 작음
# -le, -ile, -cle : 작거나 같음

# [ Matching ]
# -like, -ilike, -clike :  문자열이 와일드카드 패턴과 일치함
    "PowerShell" -like "shell"
    
# -notlike, -inotlike, -cnotlike : 문자열이 와일드카드 패턴과 일치하지 않음
# -match, -imatch, -icmatch : 문자열이 정규식 패턴과 일치함
# -notmatch, -inotmatch, -icnotmatch : 문자열이 정규식 패턴과 일치하지 않음

# [ 대체 ]
# -replace, -ireplace, -creplace : 정규식 패턴과 일치하는 문자열을 대체함

# [ Containment ]
# -contains, -icontains, -ccontains : 컬렉션에 값이 포함됨
# -notcontains, -inotcontains, -ccontains : 컬렉션에 값이 없음
# -in : 컬렉션에 값이 있음
# -notin : 컬렉션에 값이 없음

# [ Type ]
# -is : 두 개체가 동일한 형식
# -isnot : 두 개체가 동일한 형식이 아님



class FileInfoSet {
    [string]$File
    [Int64]$Size
}

$a = [FileInfoSet]@{File = "hello.exe"; Size = 521mb }
([FileInfoSet]$a).File
([FileInfoSet]$a).Size
