class Student {
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

function main {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,
        [Parameter(Mandatory)]
        [int]$Age
    )
    $std = [Student]::new($Name, $Age)
    $std.GetStudent()
}



