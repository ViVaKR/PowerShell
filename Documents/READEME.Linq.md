# Linq Lamda

하하하하! 역시 C#의 진정한 영혼은 **LINQ(Language Integrated Query)**에 있지요!

C#에서 밥 먹듯이 쓰던 바로 그 구문:
```csharp
.Select(x => new {
    Age   = x.Key,
    Count = x.Count(),
    Total = x.Sum(y => y.Age)
})
```

이 **`x => new { ... }` (람다 + 익명 객체 프로젝션)**을 파워셸로 1:1 완벽하게 옮겨오는 방법이 당연히 있습니다!

결론부터 말씀드리면 파워셸에서는 딱 두 개의 기호만 치환하시면 C#과 100% 똑같이 돌아갑니다:
1. **`x =>` (람다 식)** $\rightarrow$ **`ForEach-Object { ... }`** (여기서 `$_`가 바로 `x`)
2. **`new { ... }` (익명 객체 생성)** $\rightarrow$ **`[PSCustomObject]@{ ... }`**

---

### 1. C# LINQ 감성 100% 재현 코드 (가장 추천하는 방식)

`Group-Object`를 통과한 객체는 **`$_.Name`**(그룹 키), **`$_.Count`**(개수), **`$_.Group`**(그룹에 속한 원본 객체들의 배열)을 가지고 있습니다.

이를 이용해 C# 스타일로 빚어내면 이렇습니다:

```powershell
$data = @(
  @{ Name = 'a'; Age = 15 },
  @{ Name = 'b'; Age = 27 },
  @{ Name = 'c'; Age = 27 },
  @{ Name = 'd'; Age = 45 },
  @{ Name = 'e'; Age = 27 }
)

$result = $data |
    Group-Object -Property Age |
    ForEach-Object {
        # C#의 new { ... } 와 완전히 동일한 익명 객체 투영!
        [PSCustomObject]@{
            Age      = [int]$_.Name
            Count    = $_.Count
            Names    = ($_.Group.Name -join ', ')                      # 그룹에 속한 이름들 묶기
            TotalAge = ($_.Group.Age | Measure-Object -Sum).Sum       # C#의 .Sum(x => x.Age)
        }
    } |
    Sort-Object -Property Count -Descending

$result | Format-Table -AutoSize
```

#### 🖥️ 출력 결과:
```text
Age Count Names   TotalAge
--- ----- -----   --------
 27     3 b, c, e       81
 15     1 a             15
 45     1 d             45
```
* 27세 그룹은 총 3명(b, c, e)이고 나이의 합계(`Sum`)가 81인 것까지 완벽하게 계산되어 C#의 DTO 객체처럼 튀어나옵니다!

---

### 2. 앞서 배운 `Select-Object` 계산된 속성 방식

만약 `ForEach-Object` 대신 우리가 맨 처음에 배웠던 `Select-Object` 파이프라인의 미학을 그대로 살리고 싶다면 이렇게도 가능합니다:

```powershell
$data | Group-Object -Property Age | Select-Object `
    @{ Name = 'Age';      Expression = { [int]$_.Name } },
    Count,
    @{ Name = 'Names';    Expression = { $_.Group.Name -join ', ' } },
    @{ Name = 'TotalAge'; Expression = { ($_.Group.Age | Measure-Object -Sum).Sum } } |
    Sort-Object -Property Count -Descending
```
* 내부적으로는 1번 방식과 완전히 동일하게 동작합니다.

---

### 3. C# LINQ vs 파워셸 1:1 완벽 대응 사전

이 대응표만 가슴에 품고 계시면 C#에서 쓰던 모든 쿼리를 파워셸로 즉시 치환하실 수 있습니다!

| C# LINQ 메서드 | 파워셸 (PowerShell) 대응 구문 |
| :--- | :--- |
| `.Where(x => x.Age > 20)` | `Where-Object { $_.Age -gt 20 }` |
| `.GroupBy(x => x.Age)` | `Group-Object -Property Age` |
| **`.Select(x => new { ... })`** | **`ForEach-Object { [PSCustomObject]@{ ... } }`** |
| `.OrderByDescending(x => x.Count)` | `Sort-Object -Property Count -Descending` |
| `.Take(5)` | `Select-Object -First 5` |
| `.Skip(2)` | `Select-Object -Skip 2` |
| `.Sum(x => x.Age)` | `($_.Age \| Measure-Object -Sum).Sum` |
| `.Any()` / `.All()` | `-contains` 또는 조건문 결합 |

---

### 결론: 장남들의 언어는 통한다!

C#의 익명 객체(`new { ... }`)를 동적 언어인 파워셸로 완벽히 계승한 것이 바로 **`[PSCustomObject]@{ ... }`**입니다.

타입 안전성을 유지하면서도 필요할 때 즉석에서 객체의 뼈대를 조립해 파이프라인으로 쏴주는 이 방식이야말로, C# 개발자가 파워셸을 잡았을 때 맛볼 수 있는 가장 극상의 카타르시스입니다! 하하하하!
