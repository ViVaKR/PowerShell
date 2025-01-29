# Cmdlet

`[CmdletBinding()]`는 PowerShell 함수를 **고급 함수(Advanced Function)**로 변환하는 데 사용되는 속성입니다. 이 속성을 추가하면 함수가 PowerShell cmdlet과 유사한 동작을 하도록 설정되며, **공통 매개변수(-Verbose, -Debug, -ErrorAction 등)**를 지원하고, 보다 세밀한 제어가 가능해집니다.

---

### 🔍 **주요 기능 및 특징**

1. **공통 매개변수 지원**
   - `-Verbose`, `-Debug`, `-ErrorAction`, `-WarningAction`, `-WhatIf`, `-Confirm` 등을 자동으로 활성화합니다.
   - 예: `Write-Verbose`, `Write-Debug`와 같은 cmdlet과 통합됩니다.

2. **파라미터 위치 지정**
   - 매개변수의 위치(Position)를 지정할 수 있습니다 (예: `Position=0`).

3. **파이프라인 입력 처리**
   - `ValueFromPipeline` 또는 `ValueFromPipelineByPropertyName`을 사용해 파이프라인 입력을 처리합니다.

4. **ShouldProcess 지원**
   - `-WhatIf` 및 `-Confirm`을 통해 **실행 전 확인**을 추가할 수 있습니다.

5. **자동 변수 활성화**
   - `$PSCmdlet`, `$PSBoundParameters` 등의 변수를 사용할 수 있습니다.

---

### 📘 **기본 사용 예제**

#### 1. **공통 매개변수 활성화**

```powershell
[CmdletBinding()]
param()

Write-Verbose "Verbose 메시지 출력"
Write-Debug "Debug 메시지 출력"
```

- **사용 예**:

  ```powershell
  Test-Function -Verbose  # 자세한 정보 출력
  Test-Function -Debug    # 디버그 모드 활성화
  ```

#### 2. **ShouldProcess를 통한 안전한 작업**

```powershell
[CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact="High")]
param(
    [string]$Path
)

process {
    if ($PSCmdlet.ShouldProcess($Path, "파일 삭제")) {
        Remove-Item $Path -Force
        Write-Output "$Path 삭제 완료"
    }
}
```

- **사용 예**:

  ```powershell
  Remove-Safe -Path "C:\Temp\*" -WhatIf  # 실제 삭제 없이 시뮬레이션
  Remove-Safe -Path "C:\Temp\*" -Confirm # 삭제 전 확인
  ```

---

### 📗 **심화 예제**

#### 3. **동적 파라미터 처리**

```powershell
[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$Name,

    [Parameter(ValueFromPipeline=$true)]
    [int[]]$Numbers
)

process {
    $Numbers | ForEach-Object {
        Write-Output "$Name : $_"
    }
}
```

- **사용 예**:

  ```powershell
  1, 2, 3 | Test-Function -Name "ID"  # "ID : 1", "ID : 2", "ID : 3" 출력
  ```

#### 4. **에러 핸들링과 -ErrorAction**

```powershell
[CmdletBinding()]
param()

begin {
    Write-Error "에러 발생!" -ErrorAction Stop
}

end {
    Write-Output "함수 실행 종료"
}
```

- **사용 예**:

  ```powershell
  Test-Function -ErrorAction SilentlyContinue  # 에러 무시
  ```

---

### 📕 **실전 활용 시나리오**

#### 5. **로그 생성 함수 (Verbose + 경고 메시지)**

```powershell
[CmdletBinding()]
param(
    [string]$LogMessage
)

begin {
    Write-Verbose "로그 작성을 시작합니다..."
}

process {
    if ($LogMessage -match "ERROR") {
        Write-Warning "오류 로그가 포함되었습니다!"
    }
    Add-Content -Path "app.log" -Value $LogMessage
}

end {
    Write-Verbose "로그 작성 완료"
}
```

- **사용 예**:

  ```powershell
  Write-Log -LogMessage "ERROR: 시스템 충돌" -Verbose
  ```

---

### ⚙️ **CmdletBinding() 옵션**

| 옵션                  | 설명                                                                 |
|-----------------------|---------------------------------------------------------------------|
| `SupportsShouldProcess` | `-WhatIf` 및 `-Confirm` 활성화 (파괴적인 작업에 사용)               |
| `ConfirmImpact`        | 확인 대화상자의 중요도 설정 (`Low`, `Medium`, `High`)               |
| `DefaultParameterSetName` | 기본 매개변수 세트 지정                                          |
| `PositionalBinding`    | 위치 기반 매개변수 사용 여부 (기본값: `$true`)                     |

---

### ✅ **사용 팁**

- **고급 함수 작성 시 필수**: cmdlet과 동일한 기능을 원한다면 반드시 추가하세요.
- **WhatIf/Confirm**: 파일 삭제, 시스템 변경 등 **위험한 작업**에 적용하면 안전합니다.
- **디버깅**: `-Verbose`와 `-Debug`로 함수 내부 동작을 추적할 수 있습니다.

이를 통해 함수의 신뢰성과 유지 보수성을 크게 높일 수 있습니다! 🚀
