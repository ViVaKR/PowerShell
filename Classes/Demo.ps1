# 클래스 정의
class Person {
    # Private 필드
    [string]$name
    [int]$age

    # 생성자
    Person([string]$name, [int]$age) {
        $this.name = $name
        $this.age = $age
    }

    # 메서드
    [string] GetInfo() {
        return "Name: $($this.name), Age: $($this.age)"
    }
}

# 객체 생성
$person = [Person]::new("John Doe", 30)

# 속성 사용 (get)
Write-Output "Name: $($person.Name)"
Write-Output "Age: $($person.Age)"

# 속성 사용 (set)
$person.Name = "Jane Doe"
$person.Age = 25

# 메서드 호출
Write-Output $person.GetInfo()

# 유효성 검사 테스트 (Age가 음수일 때 예외 발생)
try {
    $person.Age = -5
}
catch {
    Write-Output $_.Exception.Message
}
