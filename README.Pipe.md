# 파이프라인 데이터 처리

PowerShell 함수에서 begin, process, end 블록을 사용하는 가장 대표적인 케이스는 바로 "파이프라인(|)을 통해 대량의 데이터(객체)를 넘겨받아 효율적으로 처리할 때"입니다.

이 구조를 사용하면 메모리를 적게 쓰면서도 대량의 데이터를 실시간으로 요리할 수 있는데요, 대표적인 3가지 실제 활용 케이스

------------------------------
## 1. 📊 대량의 데이터 실시간 필터링 및 변환 (가장 대표적)
파이프라인으로 들어오는 데이터를 한 건씩 받아 즉시 처리하고 다음 명령어로 넘겨줄 때 씁니다.

* begin: 결과를 저장할 배열을 초기화하거나 로그를 엽니다 (1번만 실행).

* process: 파이프라인으로 들어오는 데이터($_)를 그때그때 실시간으로 처리합니다 (데이터 개수만큼 반복 실행).

* end: 처리가 모두 끝난 후 최종 요약 정보를 출력합니다 (1번만 실행).

function Convert-Megabytes {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [int64]$Bytes
    )
    begin {
        Write-Host "[시작] 바이트 변환 작업을 시작합니다." -ForegroundColor Cyan
    }
    process {
        # 들어오는 숫자($$_)를 하나씩 실시간으로 MB로 변환해서 출력
        [math]::Round($Bytes / 1MB, 2)
    }
    end {
        Write-Host "[종료] 모든 변환이 완료되었습니다." -ForegroundColor Green
    }
}
## 사용 예시: 대량의 파일 크기를 실시간으로 MB로 변환

```powershell
Get-ChildItem /var/log/*.log | Select-Object -ExpandProperty Length | Convert-Megabytes
```

------------------------------
## 2. 🔌 외부 자원 연결 및 해제 (데이터베이스, 파일, 네트워크)
파일을 읽고 쓰거나, 데이터베이스(DB)에 접속해서 데이터를 넣을 때 매우 유용합니다.

* begin: DB 연결을 맺거나 파일을 엽니다. (매우 무거운 작업이므로 딱 1번만!)
* process: 파이프라인으로 들어오는 회원 정보나 로그 데이터를 DB에 차곡차곡 넣습니다.
* end: 모든 데이터 입력이 끝나면 DB 연결을 안전하게 닫습니다. (안전한 리소스 해제)

function Export-FastLog {
    [CmdletBinding()]
    param([Parameter(ValueFromPipeline = $true)][string]$LogMessage)

    begin {
        # 딱 한 번만 파일을 생성하거나 스트림을 엽니다.
        $stream = [System.IO.StreamWriter]::new("C:\temp\heavy_log.txt", $true)
    }
    process {
        # 데이터가 들어올 때마다 파일에 기록합니다.
        $stream.WriteLine("[$(Get-Date -Format 'HH:mm:ss')] $LogMessage")
    }
    end {
        # 작업이 다 끝나면 열려있던 스트림을 닫아 메모리를 해제합니다.
        $stream.Close()
    }
}

------------------------------
## 3. 📈 합계, 평균 등 통계 및 데이터 누적 계산
들어오는 데이터들의 총합이나 평균을 구해야 할 때 사용합니다. process에서 계속 숫자를 누적했다가 end에서 최종 결과를 빵! 터뜨려주는 방식입니다.

* begin: 합계를 저장할 변수($total)를 0으로 세팅합니다.
* process: 데이터가 들어올 때마다 $total += $_ 로 더해나갑니다 (화면 출력 없음).
* end: 모든 데이터가 지나가고 나면 최종 합계와 평균을 계산해서 화면에 보여줍니다.

------------------------------
## 💡 왜 굳이 나눠서 쓸까요? (이유 요약)
만약 process 블록 없이 일반 함수를 만들면, 파이프라인으로 1만 개의 데이터가 들어왔을 때 1만 개의 데이터가 메모리에 다 올라올 때까지 함수가 대기해야 합니다.
하지만 begin-process-end 구조를 쓰면 데이터가 생성되는 족족 한 건씩 통과(Streaming)하므로, 컴퓨터 메모리를 엄청나게 아낄 수 있고 속도도 압도적으로 빨라집니다.
