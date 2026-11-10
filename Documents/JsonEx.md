# JSON(JavaScript Object Notation)

JSON은 **데이터를 저장하거나 주고받기 위해** 가장 널리 쓰이는 가벼운 텍스트 포맷입니다. 핵심은 **키-값(Key-Value) 쌍**으로 이루어져 있다는 점이죠.

상황별로 자주 쓰이는 **다양한 JSON 예시 5가지** 예시

---

### 1. 기본형 (단순 정보)

가장 기본적인 형태로, 이름, 나이, 결혼 여부 등 단순한 값들을 담고 있습니다.

```json
{
  "name": "홍길동",
  "age": 30,
  "isMarried": false,
  "city": "서울"
}

```

### 2. 배열(Array)이 포함된 형태

하나의 키에 여러 개의 값(목록)을 담고 싶을 때는 대괄호(`[...]`)를 사용합니다.

```json
{
  "username": "developer_kim",
  "skills": ["PowerShell", "Python", "Docker", "Git"],
  "experienceYears": 5
}

```

### 3. 중첩 객체(Nested Object) 형태

정보가 계층적이거나 복잡할 때, 객체 안에 또 다른 객체(`{...}`)를 넣어서 표현합니다.

```json
{
  "orderId": "ORD-2026-001",
  "customer": {
    "name": "김철수",
    "email": "chulsoo@example.com"
  },
  "shippingAddress": {
    "city": "부산",
    "zipCode": "48099"
  }
}

```

### 4. 객체의 배열 형태 (REST API에서 가장 흔한 구조)

여러 개의 데이터(예: 회원 목록, 상품 목록 등)를 주고받을 때 가장 많이 쓰는 리스트 형태입니다.

```json
[
  {
    "id": 1,
    "title": "PowerShell 완벽 가이드",
    "views": 1250
  },
  {
    "id": 2,
    "title": "REST API 기초 이해하기",
    "views": 3400
  }
]

```

### 5. 복합 형태 (실무형 API 응답)

위에서 본 모든 요소(문자열, 숫자, 불리언, 배열, 중첩 객체)가 복합적으로 섞인, 실제 API에서 흔히 볼 수 있는 형태입니다.

```json
{
  "status": "success",
  "code": 200,
  "data": {
    "user": "이지은",
    "roles": ["admin", "user"],
    "preferences": {
      "theme": "dark",
      "notifications": true
    }
  }
}

```

---

### 💡 JSON 작성 시 꼭 기억해야 할 3가지 규칙!

1. **모든 문자열(Key와 값)은 반드시 쌍따옴표(`"`)로 감싸야 합니다.** (홑따옴표 `'`는 허용되지 않습니다.)
2. **Key와 Value는 콜론(`:`)으로 구분합니다.**
3. **마지막 데이터 뒤에는 쉼표(`,`)를 붙이면 안 됩니다.** (오류의 주범입니다!)

이 정도만 알면 PowerShell에서 `Invoke-RestMethod`로 JSON을 다룰 때 막히는 부분이 없을 거예요. 또 궁금한 점 있으신가요?
