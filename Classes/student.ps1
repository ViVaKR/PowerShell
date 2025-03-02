class student {
    [string]$Name
    [int]$Age

    student([string]$name, [int]$age) {
        $this.name = $name
        $this.age = $age
    }

    [string] GetStudent() {

        return "$($this.name) is $($this.age) years old"
    }

    [void] SetStudent([string]$name, [int]$age) {
        $this.name = $name
        $this.age = $age
    }
}
