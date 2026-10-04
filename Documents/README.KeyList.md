# Key List

파워셸에서 `N`, `E`, `D`는
**마이크로소프트 파워셸 엔진이 미리 정의해 둔 예약 키(Key) 이름이자 그 축약형(Alias)**입니다.

파워셸은 타이핑을 줄이기 위해 전체 키 이름의 **첫 글자만 따서 쓰는 축약 표기를 공식 지원**합니다.

기타 파워셸의 **계산된 속성(Calculated Properties)** 및 관련 명령어(`Sort-Object`, `Format-*`, `Select-Object` 등)에서 공식 지원하는 **모든 키 이름과 축약형** 정리

---

### 1. 명령어별 지원하는 모든 키 목록

| 정식 키 이름 | 축약형 | 지원하는 명령어 | 역할 및 설명 |
| :--- | :--- | :--- | :--- |
| **Expression** | `E` | 거의 모든 명령어<br>(`Select`, `Format-*`, `Sort`, `Group`) | **[필수]** 속성 값으로 들어갈 스크립트 블록(`{ ... }`)이나 기존 속성명 문자열 |
| **Name**<br>(또는 **Label**) | `N`<br>`L` | `Format-Table`, `Format-List`,<br>`Select-Object`, `ConvertTo-Html` | 표나 출력 결과에서 열(헤더)에 표시될 이름 |
| **Descending** | `D` | `Sort-Object` | 내림차순 정렬 여부 (`$true` / `$false`) |
| **Ascending** | `A` | `Sort-Object` | 오름차순 정렬 여부 (`$true` / `$false`) |
| **Alignment** | `A` | `Format-Table`, `ConvertTo-Html` | 텍스트 정렬 방식 (`"left"`, `"center"`, `"right"`) |
| **Width** | `W` | `Format-Table`, `ConvertTo-Html` | 열의 고정 너비(글자 수/정수형) 지정 |
| **FormatString**| `F` | `Format-Table`, `Format-List`,<br>`Format-Wide` | `.NET` 서식 문자열 (예: `'{0:C}'`, `'{0:N2}'`) |
| **Depth** | - | `Format-Custom` | 하위 객체를 파고들어 출력할 깊이(정수형) |

---

### 2. 코드에 나오지 않은 주요 키 상세 설명

#### ① `Width` (`W`) — 열 너비 강제 지정
열 너비를 숫자로 딱 못박아 지정할 때 씁니다.
```powershell
Get-Process | Format-Table ProcessName, @{ E = 'Id'; Width = 10 }
```

#### ② `FormatString` (`F`) — 포맷팅 문자열
질문하신 원본 코드에서는 `'{0:N0}' -f ($_.Length)`처럼 Expression 내부에서 문자열을 직접 바꿨지만, `FormatString` 키를 쓰면 더 깔끔하게 서식을 지정할 수 있습니다.
```powershell
# Length를 천 단위 콤마(N0)로 포맷팅
Get-ChildItem | Format-Table Name, @{ N = 'Size'; E = 'Length'; FormatString = '{0:N0}' }

# 숫자를 통화(화폐, C) 형식으로 포맷팅
Get-Process | Format-Table Name, @{ N = 'Memory'; E = 'WorkingSet64'; F = '{0:C}' }
```

#### ③ `Ascending` (`A`) — 오름차순 지정
`Sort-Object`에서 `Descending = $false` 대신 명시적으로 `Ascending = $true`를 쓸 수 있습니다.
```powershell
Get-ChildItem | Sort-Object @{ E = 'Length'; Ascending = $true }
```

---

### 3. 알아두면 좋은 팁

1. **대소문자 구분 없음**: 파워셸의 기본 특성상 `Name`, `name`, `NAME`, `n` 모두 동일하게 인식합니다.
2. **`Select-Object` vs `Format-Table`의 차이**:
   * `Select-Object`는 **데이터 객체 자체**를 새로 만드는 명령어라 서식 옵션(`Alignment`, `Width` 등)은 무시되고 **`Name`과 `Expression`만 지원**합니다.
   * `Format-Table`은 화면에 **예쁘게 보여주기 위한 뷰(View)** 명령어이므로 `Alignment`, `Width`, `FormatString` 같은 디자인 옵션들을 모두 지원합니다.
