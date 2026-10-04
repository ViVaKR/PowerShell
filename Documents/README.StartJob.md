# Start-Job

하하하하! 이름이 둘 다 `Start-`로 시작해서 사촌 같아 보이지만, 두 녀석의 보직은 **하늘과 땅 차이**입니다!

* **`Start-Transcript`**: 터미널 화면을 녹화하는 **'CCTV 카메라'**
* **`Start-Job`**: 내 일을 대신해 줄 **'그림자 분신술 (비동기 백그라운드 일꾼)'**

쉽게 말해, C#에서 쓰시던 **`Task.Run(() => { ... })`**이나 백그라운드 스레드를 파워셸로 그대로 옮겨놓은 것이 바로 **`Start-Job`**입니다!

---

### 1. `Start-Job`은 어떤 상황에 등판하는가?

기본적으로 파워셸은 한 줄이 끝나야 다음 줄로 넘어가는 **동기(Blocking)** 방식입니다.
하지만 살다 보면 **"야, 너 저 뒤에서 그거 천천히 하고 있어. 난 내 일 계속할 테니까!"** 해야 하는 순간들이 생기죠. 이때 등판합니다.

#### 명장면 ① : 병렬 컴파일 (M4 맥북의 멀티코어 일제 사격!)
아까 만드신 오케스트레이터에서 **Rust 빌드**와 **Go 빌드**는 서로 남남(독립적)인데 굳이 하나 끝나길 기다렸다가 다음 걸 돌릴 필요가 있을까요?

```powershell
# 1. Rust 빌드를 백그라운드 분신(Job)에게 시킴 (즉시 다음 줄로 넘어감!)
$jobRust = Start-Job -ScriptBlock { cargo build --release ... }

# 2. Go 빌드도 다른 분신에게 시킴 (동시에 병렬 실행!)
$jobGo   = Start-Job -ScriptBlock { go build ... }

# 3. 메인 스크립트는 다른 일(어셈블리 파싱 등)을 하다가, 두 녀석이 다 끝날 때까지 대기!
Wait-Job $jobRust, $jobGo

# 4. 일꾼들이 작업한 결과(출력 로그)를 회수!
$rustLog = Receive-Job $jobRust
$goLog   = Receive-Job $jobGo

# 5. 일 다 끝난 분신들 퇴근(메모리 해제)
Remove-Job $jobRust, $jobGo
```
* 원래 10초 + 10초 = **20초** 걸리던 빌드가, 두 코어가 동시에 불을 뿜으면서 **10초** 만에 끝나버립니다!

---

#### 명장면 ② : "타임아웃(Timeout)" 걸기 — 5초 안에 안 끝나면 목을 쳐라!
외부 서버에서 데이터를 긁어오거나 무거운 컴파일을 돌릴 때, 프로그램이 멈춰서(Hang) 무한정 대기하는 참사를 막을 때 씁니다.

```powershell
# 백그라운드로 실행
$job = Start-Job -ScriptBlock { Invoke-RestMethod "https://느려터진서버.com/api" }

# 딱 5초만 기다려줌! (C#의 CancellationTokenSource 같은 역할)
if (-not (Wait-Job $job -Timeout 5)) {
    Stop-Job $job
    Write-Warning "⚠️ 5초 초과! 서버가 응답이 없어 작업을 강제 처단했습니다."
} else {
    $data = Receive-Job $job
}
Remove-Job $job
```

---

#### 명장면 ③ : 환경 오염 방지 (일회용 격리 구역)
어떤 작업을 할 때 환경변수(`$env:PATH`)를 마구 뜯어고치거나 메모리를 기가바이트 단위로 쓰는 지저분한 코드가 있다고 해보겠습니다.
* 메인 스크립트에서 돌리면 메인 세션이 오염되지만,
* `Start-Job`으로 돌리면 **완전히 독립된 별도의 파워셸 세션에서 돌고 끝나면 증발**해 버리므로 메인 세션은 순결함을 유지합니다.

---

### 2. `Start-Job` 패밀리의 4단계 의식

C#의 `Task`를 다룰 때 `await task`, `task.Result`를 하듯이, 파워셸 Job도 4단계의 세트 메뉴로 움직입니다.

1. **`Start-Job`**: 일꾼 소환 및 작업 발주 (바로 티켓/Job 객체 반환)
2. **`Wait-Job`**: 일꾼이 작업을 마칠 때까지 대기 (`await`)
3. **`Receive-Job`**: 일꾼이 완료한 결과물(Return 값/출력) 수거 (`task.Result`)
4. **`Remove-Job`**: 일꾼 객체 메모리에서 삭제 (Garbage Collection)

---

### 👑 닷넷 대원수 각하를 위한 특급 비밀: `Start-Job` vs `Start-ThreadJob`

여기서 아주 중요한 닷넷 공학적 반전이 하나 있습니다!

* **전통적인 `Start-Job`의 약점**:
  분신을 만들 때 운영체제의 **새로운 `pwsh` 프로세스를 통째로 하나 더 띄웁니다!**
  아무리 빨라도 프로세스를 새로 띄우는 데 0.2~0.5초가 걸리고 메모리를 50MB씩 먹습니다. (가벼운 작업 여러 개 돌리기엔 좀 무겁죠)

* **PowerShell 7의 구원투수: `Start-ThreadJob` & `ForEach-Object -Parallel`**:
  프로세스를 새로 띄우지 않고, **현재 프로세스 안에서 순수 C# 작업 스레드(Thread)만 파서 광속으로 돌립니다!**

```powershell
# 100개의 작업을 동시에 병렬로 돌릴 때 (Thread 기반 초광속!)
1..100 | ForEach-Object -Parallel {
    # C#의 ThreadPool처럼 0.001초 만에 스레드를 띄워 병렬 사격!
    Write-Host "사격 번호: $_ (스레드 ID: $([System.Threading.Thread]::CurrentThread.ManagedThreadId))"
} -ThrottleLimit 10
```

---

### 결론

* **`Start-Transcript`**가 과거를 낱낱이 기록하는 **사관(역사 기록가)**이라면,
* **`Start-Job`**은 무거운 짐을 대신 짊어지고 전장으로 달려 나가는 **돌격대(비동기 일꾼)**입니다!

빌드 과정에서 Rust나 Go처럼 독립적인 녀석들을 동시에 묶어서 팰 때(?) 등판시키면, M4의 고성능 P코어들이 일제히 불을 뿜으며 빌드 시간을 반토막 내줄 것입니다! 하하하하! 🚀⚡️🧵
