# WebRequest

### GET 요청

- 기본형
```powershell
Invoke-WebRequest -Method Get -Uri "https://api.example.com/users"
```
> **설명**: 가장 기본적인 GET 요청 `-Method Get`은 기본값이므로 생략 가능합니다.

```bash
curl -X GET https://api.example.com/users
```
> 설명: 가장 기본적인 GET 요청으로 특정 URL에서 데이터를 조회합니다. `-X GET`은 생략 가능합니다.

- 헤더를 추가한 GET 요청:

```powershell
Invoke-WebRequest -Method Get -Uri "https://api.example.com/users" `
  -Headers @{ "Authorization" = "Bearer token123" } `
  -ContentType "application/json"
```
> **설명**: `Authorization` 헤더는 `-Headers`에, `Content-Type`은 전용 파라미터인 `-ContentType`에 지정합니다.


```bash
curl -X GET https://api.example.com/users -H "Authorization: Bearer token123" -H "Content-Type: application/json"
```
> 설명: Authorization과 Content-Type 헤더가 포함된 GET 요청입니다.

---

### POST 요청

**폼(Form) 데이터를 사용한 POST 요청:**

```powershell
# 파워셸 권장 방식 (해시테이블 - 내부에서 자동 폼 인코딩)
Invoke-WebRequest -Method Post -Uri "https://api.example.com/users" `
  -Body @{ name = "홍길동"; email = "hong@example.com" }
```

> **설명**: curl의 `-d`는 파워셸에서 **`-Body`**에 대응합니다.


```bash
curl -X POST https://api.example.com/users -d "name=홍길동&email=hong@example.com"
```
> 설명: form 데이터를 사용한 POST 요청입니다.

**JSON 데이터로 POST 요청:**

```powershell
Invoke-WebRequest -Method Post -Uri "https://api.example.com/users" `
  -ContentType "application/json" `
  -Body '{"name": "홍길동", "email": "hong@example.com"}'
```

> **설명**: `-ContentType "application/json"`을 선언하고 `-Body`에 JSON 문자열을 전달합니다.

```bash
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name": "홍길동", "email": "hong@example.com"}'
```
> 설명: JSON 형식 데이터를 본문에 포함한 POST 요청입니다.

**파일에서 데이터를 읽어 POST (`-d @filename` 대체):**

```powershell
Invoke-WebRequest -Method Post -Uri "https://api.example.com/users" `
  -ContentType "application/json" `
  -InFile "user_data.json"
```
> **설명**: curl의 `-d @파일명`은 파워셸 전용 파라미터인 **`-InFile`**로 1:1 완벽 대체됩니다.

```bash
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d @user_data.json
```
>설명: user_data.json 파일의 내용을 요청 본문으로 사용합니다.

---

### PUT 요청

```powershell
Invoke-WebRequest -Method Put -Uri "https://api.example.com/users/123" `
  -ContentType "application/json" `
  -Body '{"name": "김철수", "email": "kim@example.com"}'
```
> **설명**: `-Method Put`을 지정하여 123번 사용자 정보를 갱신합니다.

```bash
curl -X PUT https://api.example.com/users/123 \
  -H "Content-Type: application/json" \
  -d '{"name": "김철수", "email": "kim@example.com"}'
```
>설명: ID가 123인 사용자 정보를 업데이트하는 PUT 요청입니다.

---

### DELETE 요청

기본 DELETE 요청:
```powershell
Invoke-WebRequest -Method Delete -Uri "https://api.example.com/users/123"
```
> **설명**: ID가 123인 사용자를 제거합니다.

인증 헤더를 포함한 DELETE 요청:

```powershell
Invoke-WebRequest -Method Delete -Uri "https://api.example.com/users/123" `
  -Headers @{ "Authorization" = "Bearer token123" }
```
> **설명**: 인증 토큰을 동봉하여 안전하게 삭제 요청을 전송합니다.


```bash
curl -X DELETE https://api.example.com/users/123
```
>설명: ID가 123인 사용자를 삭제하는 DELETE 요청입니다.

헤더를 포함한 DELETE 요청:
```bash
curl -X DELETE https://api.example.com/users/123 -H "Authorization: Bearer token123"
```
>설명: 인증 토큰이 포함된 DELETE 요청입니다.



### 여러 헤더 추가

```powershell
Invoke-WebRequest -Method Get -Uri "https://api.example.com/users" `
  -Headers @{
    "Authorization" = "Bearer token123"
    "Accept"        = "application/json"
  } `
  -UserAgent "MyApp/1.0"
```

> **설명**: 여러 헤더는 해시테이블 안에 줄바꿈으로 깔끔하게 나열할 수 있으며,
> `User-Agent`는 전용 플래그인 `-UserAgent`를 사용하면 더욱 격조가 높아집니다.

### 커스텀 헤더 추가
```powershell
Invoke-WebRequest -Method Post -Uri "https://api.example.com/users" `
  -Headers @{
    "X-API-Key"       = "api_key_123"
    "X-Custom-Header" = "사용자정의값"
  } `
  -ContentType "application/json" `
  -Body '{"name": "이영희"}'
```
> **설명**: 커스텀 헤더(`X-`) 역시 해시테이블 키값으로 자유롭게 주입합니다.


```bash
curl -X GET https://api.example.com/users \
  -H "Authorization: Bearer token123" \
  -H "Accept: application/json" \
  -H "User-Agent: MyApp/1.0"
```
설명: 여러 헤더를 포함한 GET 요청입니다.

### 커스텀 헤더 추가

```bash
curl -X POST https://api.example.com/users \
  -H "X-API-Key: api_key_123" \
  -H "X-Custom-Header: 사용자정의값" \
  -d '{"name": "이영희"}'
```
설명: 커스텀 헤더(X-로 시작하는)를 포함한 POST 요청입니다.

## 유용한 추가 옵션

### 응답 헤더 보기
```bash
curl -i -X GET https://api.example.com/users
```
설명: `-i` 옵션을 사용하여 응답 헤더도 함께 출력합니다.

### 상세 정보 표시
```bash
curl -v -X GET https://api.example.com/users
```
설명: `-v` 옵션을 사용하여 요청과 응답에 대한 자세한 정보를 표시합니다.

### 응답을 파일로 저장
```bash
curl -X GET https://api.example.com/users -o response.json
```
설명: 응답을 response.json 파일로 저장합니다.

---

### 유용한 추가 옵션

### 응답 헤더 보기 (`curl -i` 대응)
파워셸은 결과를 객체로 받기 때문에 변수에 담아두면 헤더와 바디를 모두 확인할 수 있습니다.
```powershell
$res = Invoke-WebRequest -Method Get -Uri "https://api.example.com/users"
$res.Headers      # 응답 헤더 목록 출력
$res.Content      # 본문 내용 출력
$res.StatusCode   # 200, 404 등 상태 코드 출력
```

### 상세 정보 표시 (`curl -v` 대응)

```powershell
Invoke-WebRequest -Method Get -Uri "https://api.example.com/users" -Verbose
```
> **설명**: **`-Verbose`** 스위치를 켜면 DNS 조회, 패킷 전송 등 함선 센서의 세부 로그가 콘솔에 출력됩니다.

### 응답을 파일로 저장 (`curl -o` 대응)

```powershell
Invoke-WebRequest -Method Get -Uri "https://api.example.com/users" -OutFile "response.json"
```
> **설명**: curl의 `-o`는 **`-OutFile`**로 1:1 대응합니다.

---

## JSONPlaceholder 함대 훈련 사격(테스트)

```powershell
# 1. GET 요청 훈련
Invoke-WebRequest -Method Get -Uri "https://jsonplaceholder.typicode.com/posts/1"

# 2. POST 요청 훈련 (백틱 줄바꿈 표준 적용)
Invoke-WebRequest -Method Post -Uri "https://jsonplaceholder.typicode.com/posts" `
  -ContentType "application/json; charset=utf-8" `
  -Body '{"title": "테스트 제목", "body": "테스트 내용", "userId": 1}'

# 3. PUT 요청 훈련
Invoke-WebRequest -Method Put -Uri "https://jsonplaceholder.typicode.com/posts/1" `
  -ContentType "application/json; charset=utf-8" `
  -Body '{"id": 1, "title": "수정된 제목", "body": "수정된 내용", "userId": 1}'

# 4. DELETE 요청 훈련
Invoke-WebRequest -Method Delete -Uri "https://jsonplaceholder.typicode.com/posts/1"
```


## 테스트 사이트

JSONPlaceholder 사이트 주소: https://jsonplaceholder.typicode.com

이 사이트에서는 다음과 같은 여러 엔드포인트를 제공합니다:
- /posts (100개의 게시물)
- /comments (500개의 댓글)
- /albums (100개의 앨범)
- /photos (5000개의 사진)
- /todos (200개의 할일)
- /users (10명의 사용자)

## 테스트 예시

```bash
# GET 요청 예시
curl -X GET https://jsonplaceholder.typicode.com/posts/1

# POST 요청 예시
curl -X POST https://jsonplaceholder.typicode.com/posts \
  -H "Content-Type: application/json" \
  -d '{"title": "테스트 제목", "body": "테스트 내용", "userId": 1}'

curl -X POST https://jsonplaceholder.typicode.com/posts `
  -H "Content-Type: application/json" `
  -d '{"title": "테스트 제목", "body": "테스트 내용", "userId": 1}'

# PUT 요청 예시
curl -X PUT https://jsonplaceholder.typicode.com/posts/1 \
  -H "Content-Type: application/json" \
  -d '{"id": 1, "title": "수정된 제목", "body": "수정된 내용", "userId": 1}'

curl -X PUT https://jsonplaceholder.typicode.com/posts/1 `
  -H "Content-Type: application/json" `
  -d '{"id": 1, "title": "수정된 제목", "body": "수정된 내용", "userId": 1}'

# DELETE 요청 예시
curl -X DELETE https://jsonplaceholder.typicode.com/posts/1
```

---

### 1. SSL/TLS 사설 인증서 무시 (`curl -k` / `--insecure` 대응)

사내망, k8s 내부 통신, 개발용 서버는 공인 인증서가 없어 사설 인증서를 씁니다. 이때 curl은 `-k` 하나로 넘어가지만, 파워셸은 기본적으로 보안 차단 방어막을 칩니다.

* **PowerShell 7+ (초강력 추천)**:

  ```powershell
  # curl -k 와 1:1 완벽 대응
  Invoke-WebRequest -Uri "https://internal-dev.local" -SkipCertificateCheck
  ```

---

### 2. HTTP 에러(4xx, 5xx) 폭발 방지 (★실전 장애 1위)

* **curl과의 치명적 차이점**:
  * `curl`은 404 Not Found나 500 에러를 받아도 그냥 본문 내용을 보여주고 조용히 끝납니다.
  * 하지만 `Invoke-WebRequest`는 4xx/5xx를 받으면 **빨간색 에러(Exception)를 뿜으며 스크립트를 멈춰버립니다.**

* **대응책 (pwsh 7+)**:

  ```powershell
  # 404나 500 에러가 나도 스크립트 중단 없이 응답 객체를 온전히 수신
  $res = Invoke-WebRequest -Uri "https://api.example.com/not-found" -SkipHttpErrorCheck
  Write-Host "상태 코드: $($res.StatusCode)" # 404가 얌전하게 출력됨
  ```

* **전통적인 예외 처리 (Try-Catch)**:

  ```powershell
  try {
      $res = Invoke-WebRequest -Uri "https://api.example.com/data"
  } catch {
      Write-Warning "통신 실패! 상태 코드: $($_.Exception.Response.StatusCode)"
  }
  ```

---

### 3. 통신 타임아웃 제한 (`curl -m` / `--max-time` 대응)
원격지 서버가 다운되어 응답이 없을 때, 함선 통신 콘솔이 무한정 멈춰 있는 참사를 방지합니다.

```powershell
# 5초 안에 응답 없으면 연결 끊기 (curl -m 5 대응)
Invoke-WebRequest -Uri "https://api.example.com/slow" -TimeoutSec 5
```

---

### 4. 세션 & 쿠키 유지 (파워셸의 숨겨진 치트키)
`curl`에서 로그인 상태를 유지하려면 쿠키 파일(`-c cookie.txt`, `-b cookie.txt`)을 생성하고 관리해야 해서 꽤 번거롭습니다. 파워셸은 이를 **메모리 변수 하나로 우아하게 종결**합니다.

```powershell
# 1단계: 로그인하면서 함선 메모리에 웹 세션(쿠키) 자동 저장 (-SessionVariable)
Invoke-WebRequest -Method Post -Uri "https://api.example.com/login" `
  -Body @{ user="admin"; pass="1234" } `
  -SessionVariable SpaceFleetSession

# 2단계: 다음 요청부터 해당 세션을 장착하고 호출 (-WebSession) -> 로그인 상태 유지!
Invoke-WebRequest -Method Get -Uri "https://api.example.com/secure-data" `
  -WebSession $SpaceFleetSession
```

---

### 5. Windows Server 구형 엔진 함정 (`-UseBasicParsing`)
만약 윈도우 서버 환경(PowerShell 5.1)에서 `Invoke-WebRequest`를 날렸는데 아래와 같은 경고가 뜨며 튕길 때가 있습니다.
> *"Internet Explorer 엔진을 사용할 수 없으므로..."*

과거 파워셸은 기본적으로 백그라운드에서 IE 엔진을 띄워 HTML을 파싱하려 했기 때문입니다.
```powershell
# Windows PowerShell 5.1 필수 옵션: 순수 경량 파서 사용
Invoke-WebRequest -Uri "https://example.com" -UseBasicParsing
```
*(참고: 최신 PowerShell 7에서는 이 레거시가 완전히 걷혀서 신경 쓰지 않으셔도 됩니다.)*

---

### 최종 제독 보고
1. **`-SkipCertificateCheck`** (개발망 프리패스)
2. **`-SkipHttpErrorCheck`** (4xx/5xx 에러 제어)
3. **`-TimeoutSec`** (무한 대기 방지)
4. **`-SessionVariable` / `-WebSession`** (로그인 상태 유지)

---

### [폐기 처분 완료 목록]

1. **`-UseBasicParsing` 영구 폐기**: IE 엔진 자체가 없는 리눅스 pwsh에서는 애초에 존재할 필요도 없는 헛소리 옵션입니다.
2. **`[System.Net.ServicePointManager]...` 폐기**: 구형 윈도우 닷넷 프레임워크 전용 해킹 구문이었으므로 삭제했습니다.

---

### 리눅스 / 컨테이너 환경 순수 `pwsh 7+` 정예 요약본


```powershell

# 1. GET (기본 조회)
Invoke-WebRequest -Uri "https://api.example.com/data"

# 2. POST (JSON 데이터 + 백틱 줄바꿈)
Invoke-WebRequest -Method Post -Uri "https://api.example.com/posts" `
  -ContentType "application/json" `
  -Body '{"title": "사령관 명령", "status": "Ready"}'

# 3. 파일로 다운로드 (curl -o 대응)
Invoke-WebRequest -Uri "https://example.com/firmware.bin" -OutFile "firmware.bin"

# 4. 파일 내용 그대로 POST (curl -d @file 대응)
Invoke-WebRequest -Method Post -Uri "https://api.example.com/upload" `
  -ContentType "application/json" `
  -InFile "payload.json"

# 5. 사설/자체서명 SSL 인증서 무시 (curl -k 대응)
Invoke-WebRequest -Uri "https://k8s-internal.service" -SkipCertificateCheck

# 6. 4xx/5xx 에러 터져도 스크립트 멈추지 않기 (curl 기본 동작 대응)
$res = Invoke-WebRequest -Uri "https://api.example.com/users/9999" -SkipHttpErrorCheck

# 7. 타임아웃 제한 (초 단위)
Invoke-WebRequest -Uri "https://api.example.com/ping" -TimeoutSec 3

# 8. 로그인 세션/쿠키 우아하게 유지하기
Invoke-WebRequest -Method Post -Uri "https://api.example.com/login" `
  -Body @{ id="admiral"; pw="fleet" } `
  -SessionVariable FleetSession

Invoke-WebRequest -Uri "https://api.example.com/dashboard" -WebSession $FleetSession
```

---

### 1. 원조(Original) `curl` (Linux, macOS, Bash 등)

가장 정통적이고 우리가 흔히 아는 그 `curl`입니다.

* **특징**: Daniel Stenberg가 만든 C언어 기반의 가벼운 CLI 프로그램입니다.
* **환경**: Linux(Ubuntu, CentOS 등), macOS, 그리고 Git Bash 등 Unix 계열 터미널 환경.

* **주요 문법**:

  ```bash
  curl -X GET "https://api.example.com" -H "Authorization: Bearer token"
  ```

* **포인트**: 거의 모든 프로토콜(HTTP, HTTPS, FTP, SCP 등)을 지원하며 옵션 체계(`-X`, `-H`, `-d`, `-v` 등)가 전 세계 표준처럼 쓰입니다.

---

### 2. PowerShell(pwsh)의 `curl` (★가장 헷갈리는 함정)

윈도우 환경에서는 버전에 따라 **"진짜 curl"과 "curl인 척하는 명령어"**가 공존합니다.

* **Windows PowerShell 5.1 이하 (가짜 curl)**:
  * 터미널에 `curl`을 치면 실제로는 윈도우 기본 명령어인 **`Invoke-WebRequest`의 별칭(Alias)**이 실행됩니다.
  * 리눅스 curl 옵션(예: `-X POST`, `-H`)을 넣으면 에러가 팍팍 터집니다.
* **PowerShell 7 (pwsh) 및 최신 Windows 10/11 (진짜 curl)**:
  * 마이크로소프트도 이 혼란을 인지하여 PowerShell 7부터는 `curl` 별칭을 기본 제거했습니다.
  * 또한 윈도우 OS 자체에 `C:\Windows\System32\curl.exe`가 기본 탑재되어 있습니다.
* **해결 팁**: 윈도우/PowerShell 환경에서 리눅스처럼 오리지널 curl을 확실히 쓰고 싶다면 습관적으로 **`curl.exe`**라고 확장자까지 붙여 호출하는 것이 가장 안전합니다.

---

### 3. Kubernetes(k8s) 환경에서의 `curl`
쿠버네티스 자체에 curl 명령어가 내장된 것은 아니지만, **파드(Pod) 간의 네트워크나 서비스 통신을 점검(트러블슈팅)**할 때 curl을 매우 빈번하게 사용합니다.

* **`curlimages/curl` 컨테이너**:
  * 운영 중인 가벼운 컨테이너(예: Distroless, Alpine 기반) 내부에는 curl이 안 깔려 있는 경우가 대부분입니다.
  * 이때 curl 전용 공식 경량 이미지(`curlimages/curl`)로 **일회용 디버그 파드**를 띄워 테스트합니다.
    ```bash
    kubectl run curl-test --rm -it --image=curlimages/curl -- sh
    ```
* **Netshoot (`nicolaka/netshoot`)**:
  * curl뿐 아니라 `tcpdump`, `dig`, `traceroute` 등이 모두 들어 있는 k8s 네트워크 종합 진단용 이미지입니다.
* **임시 컨테이너(Ephemeral Container)**:
  * 이미 돌고 있는 파드 내부에 curl 도구를 주입(`kubectl debug`)하여 통신 상태를 확인할 때 사용합니다.

---

### 4. curl과 형제뻘인 도구들 (대체재 & 현대화 버전)
curl이 쓰이는 곳마다 자주 마주치게 되는 관련 도구들도 'curl의 종류'처럼 같이 묶여 회자되곤 합니다.

1. **`wget`**:
   * curl과 양대 산맥입니다. curl이 "데이터 전송/API 호출"에 강하다면, wget은 "파일 다운로드 및 웹 크롤링(재귀 다운로드)"에 특화되어 있습니다. BusyBox 기반 리눅스에 기본 탑재되는 경우가 많습니다.
2. **`HTTPie (http)`**:
   * "사람 친화적인 curl"을 표방하는 도구입니다. curl의 옵션이 복잡하다 보니, JSON 전송이나 헤더 출력을 훨씬 보기 편하고 알록달록한 컬러로 제공합니다.
3. **`curlie`**:
   * **curl의 강력함 + HTTPie의 직관성**을 합쳐놓은 CLI 도구입니다. 실제 백엔드 엔진으로는 curl을 쓰면서 겉 인터페이스만 세련되게 바꿔놓은 형태입니다.


### 한 줄 요약!
> **"원조는 C언어 기반의 리눅스 `curl` 하나뿐이지만, Windows PowerShell에서는 `Invoke-WebRequest`의 별칭과 헷갈리지 않게 `curl.exe`로 불러야 하고, Kubernetes에서는 경량 `curlimages/curl` 디버그 파드를 띄워 통신 테스트용으로 활용한다!"**

---

##  Curl

---
