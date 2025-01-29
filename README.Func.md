# 함수

---

### 📘 **기초 예제**

#### 1. **기본 함수 구조**

```powershell
function Say-Hello {
    Write-Output "Hello, World!"
}

# 사용 예
Say-Hello
```

#### 2. **매개변수 사용**

```powershell
function Get-PersonalizedGreeting {
    param(
        [string]$Name,
        [int]$Age
    )
    Write-Output "Hello, $Name! You are $Age years old."
}

# 사용 예
Get-PersonalizedGreeting -Name "John" -Age 30
```

#### 3. **기본값이 있는 매개변수**

```powershell
function Get-Greeting {
    param(
        [string]$Name = "Guest"
    )
    Write-Output "Welcome, $Name!"
}

# 사용 예
Get-Greeting          # "Welcome, Guest!"
Get-Greeting -Name "Alice"
```

---

### 📗 **중급 예제**

#### 4. **파이프라인 입력 처리**

```powershell
function Get-UppercaseText {
    param(
        [Parameter(ValueFromPipeline)]
        [string]$InputText
    )
    process {
        $InputText.ToUpper()
    }
}

# 사용 예
"hello", "world" | Get-UppercaseText  # "HELLO", "WORLD"
```

#### 5. **반환 값 활용**

```powershell
function Add-Numbers {
    param(
        [double]$a,
        [double]$b
    )
    return $a + $b
}

# 사용 예
$result = Add-Numbers -a 5 -b 3.5  # 8.5
```

#### 6. **유효성 검사 (Validation)**

```powershell
function Get-Square {
    param(
        [ValidateRange(1, 100)]
        [int]$Number
    )
    $Number * $Number
}

# 사용 예
Get-Square -Number 5   # 25
Get-Square -Number 150 # 오류 발생
```

---

### 📕 **고급 예제**

#### 7. **동적 매개변수 (Dynamic Parameters)**

```powershell
function Get-FileInfo {
    [CmdletBinding()]
    param(
        [string]$Path
    )
    dynamicparam {
        # 파일이 존재할 때만 -Encoding 매개변수 추가
        if (Test-Path $Path) {
            $attributes = New-Object System.Management.Automation.ParameterAttribute
            $attributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            $attributeCollection.Add($attributes)

            $dynParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
                "Encoding",
                [string],
                $attributeCollection
            )
            $paramDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
            $paramDictionary.Add("Encoding", $dynParam)
            return $paramDictionary
        }
    }
    process {
        Get-Item $Path
    }
}
```

#### 8. **클래스 기반 함수 (PowerShell 5.0+)**

```powershell
class Calculator {
    [int] Add([int]$a, [int]$b) {
        return $a + $b
    }
    [int] Multiply([int]$a, [int]$b) {
        return $a * $b
    }
}

# 사용 예
$calc = [Calculator]::new()
$calc.Add(10, 5)      # 15
$calc.Multiply(3, 4)  # 12
```

#### 9. **에러 핸들링**

```powershell
function Safe-Divide {
    param(
        [double]$Dividend,
        [double]$Divisor
    )
    try {
        if ($Divisor -eq 0) { throw "Division by zero!" }
        $Dividend / $Divisor
    }
    catch {
        Write-Error $_.Exception.Message
        return $null
    }
}

# 사용 예
Safe-Divide -Dividend 10 -Divisor 0  # 오류 메시지 출력
```

#### 10. **작업 자동화 (파일 처리)**

```powershell
function Backup-Files {
    param(
        [string]$SourceDir,
        [string]$DestinationDir
    )
    $files = Get-ChildItem -Path $SourceDir -File
    foreach ($file in $files) {
        $destPath = Join-Path $DestinationDir $file.Name
        Copy-Item -Path $file.FullName -Destination $destPath -Force
    }
    Write-Output "Backup completed for $($files.Count) files."
}

# 사용 예
Backup-Files -SourceDir "C:\Data" -DestinationDir "D:\Backup"
```

---

### 🔍 **함수 작성 팁**

1. **의미 있는 이름**: `Verb-Noun` 형식 사용 (예: `Get-Process`).
2. **매개변수 유효성 검사**: `[ValidateSet()]`, `[ValidateRange()]` 등 활용.
3. **주석 작성**: `help <함수명>`으로 설명 확인 가능하도록 작성.
4. **파이프라인 지원**: `ValueFromPipeline` 속성 사용.

기본 → 중급 → 고급 순서로 단계별로 연습해 보세요! 😊

```bash
Test-WriteLog -Log "ERROR : $(Get-Date -Format 'yyyy-MM-dd') 시스템 오류발생" -Verbose

Get-Date -DisplayHint Date
Get-Date -UFormat "%A %m/%d/%Y %R %Z"

Get-TimeZone
30000, 56798, 12432 | ForEach-Object -Process {$_/1024}
```
