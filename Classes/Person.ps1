# 부모 클래스
class Person {


    # 속성 정의와 검증
    [string] $Name

    [int] $Age

    # 생성자(Constructor)
    Person([string]$name, [string]$age) {
        $this.Name = $name
        $this.Age = $age
    }

    # 메서드(Method) 정의
    [string] GetInfo() {
        return "이름: $($this.Name), 나이: $($this.Age)"
    }
}

# 자식 클래스
class Student : Person {
    [string] $School

    # 생성자(Constructor)
    Student([string]$name, [string]$age, [string]$school) : base($name, $age) {
        $this.School = $school
    }

    # 메서드(Method) 정의
    [string] ToString() {
        return "이름: $($this.Name), 나이: $($this.Age), 학교: $($this.School)"
    }
}
