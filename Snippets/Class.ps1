<# 
	! 클래스 : 
		런타임에 개체의 인스턴스를 만드는데 사용되는 청사진
	    클래스 이름 : 형식이름

	!생성자
		클래스 인스턴스를 만드는 순간에 기본값을 설정하고 유효성을 검사할 수 있음
		클래스와 동일한 이름을 갖음
		초기화하는 인수가 있을 수 있음
		생성자가 정의 되지 않는 경우 클래스에서는 기본 매개 변수가 없는 생성자가 제공됨, 이생성자는 모든 멤버를 기본값으로 초기화 함
		개체의 형식 및 문자열에느 null 값이 지정됨.
		사용자가 생성자를 생성할 때에는 매개변수가 없는 생성자는 만들어지지 않음
		필요한 경우 매개변수가 없는 생성자를 만들수 있음
#>

class Loc {
	<# Define the class. Try constructors, properties, or methods. #>

	[int]$Id
	[string]$Name
	[int]$Age

	[string]ToString() {
		return ("{0} | {1} | {2}" -f $this.Id, $this.Name, $this.Age)
	}
	
}

$loc = [Loc]::new()
$loc.Id = 1
$loc.Name = "Viv"
$loc.Age = 35
$loc.ToString();

class Device {
	[string]$Brand
	[string]$Model
	[string]$Sku

	[string]ToString() {
		return ("{0} | {1} | {2}" -f $this.Brand, $this.Model, $this.Sku)

	}
}

class Rack {
	[int]$Slots = 8
	[string]$Brand
	[string]$Model
	[string]$Sku
	[string]$AssetId
	[Device[]]$Devices = [Device[]]::new($this.Slots)

	[void] AddDevice([Device]$dev, [int]$slot) {
		$this.Devices[$slot] = $dev
	}

	[void]RemoveDevice([int]$slot) {
		$this.Devices[$slot] = $null;
	}

	[int[]] GetAvailableSlots() {
		[int]$i = 0
		return @($this.Devices.foreach{ if ($_ -eq $null) { $i }; $i++ })
	}
}

$rack = [Rack]::new()

$device = [Device]::new()
$device.Brand = "Viv, Inc."
$device.Model = "V5040"
$device.Sku = "5072641004"

$rack.AddDevice($device, 2)

$rack
$rack.GetAvailableSlots()

class FunWithIntegers {

	[int[]]$Integers = 0..10

	[int[]]GetOddIntegers() {
		return $this.Integers.Where({ ($_ % 2) -eq 0 })
	}
	
	[int[]] GetEventIntergers() {
		return $this.Integers.Where({ ($_ % 2) -eq 1 })
	}

	[string] SayHello() {
		return "Hello World"
	}
}

$ints = [FunWithIntegers]::new()
Write-Output "--------- 짝수 ---------"
$ints.GetOddIntegers()
Write-Output "--------- 홀수 ---------"
$ints.GetEventIntergers()

$ints.SayHello()


<# 생성자 #>

class Viv {
	[int]$Id
	[string]$Name
	[string]$Sku


	Viv(
		[int]$id,
		[string]$name,
		[string]$sku
	) {
		$this.Id = $id
		$this.Name = $name
		$this.Sku = $sku

	}
}

[Viv]$viv = [Viv]::new(
	3, "BJ", "123456"
)

$viv

class Cls_1 {
	hidden [int] $Slot = 8
	[string]$Brand
	[string]$Model
	[int]$Sum

	Cls_1([string]$brand, [string]$model, [int]$sum) {

		$this.Brand = $brand
		$this.Model = $model
		$this.Sum = $this.Slot * $sum
	}
}

[Cls_1]$cls1 = [Cls_1]::new("Viv", "Hello", 45);

$cls1.Sum
$cls1.Brand
$cls1.Model
$cls1

class Cls_2 {
	static [Cls_2[]]$Instance = @()
	static [ValidateNotNullOrEmpty()][string]$Brand

}

enum DeviceType {
	Undefined = 0
	Compute = 1
	Storage = 2
	Networking = 4
	Power = 16
	Rack = 32
}

class Person {
	[int]$Age

	Person([int]$age) {
		$this.Age = $age
	}
}

class Child :Person {
	[string]$School

	Child([int]$a, [string]$s) :base($a) {
		$this.School = $s
	}
}

[Child]$one = [Child]::new(10, "Silver");

$one.Age

Write-Host

switch (1, 2, 3) {
	2 { continue }
	default {$_}
}

DATA TextMsgs {
	ConvertFrom-StringData -StringData @'
	Text001 = Windows 10
	Text002 = Windows Server 2019
'@
}
$TextMsgs

DATA {
	"Thank you for using my PoserShell Organize.pst script."
	"It is provided free of charge to the community."
	"I appreciate your comments and feedback."
}

$aa = $Input
$aa
enum MediaTypes {
	unknown
	music = 10
	mp3
	aac
	ogg = 15
	oga = 15
	mogg = 15
	picture = 20
	jpg
	jpeg = 21
	png
	video = 40
	mpg
	mpeg = 41
	avi
	m4v
   }
[MediaTypes].GetEnumNames()   
Write-Host
[MediaTypes].GetEnumValues()
Write-Host
[MediaTypes].GetEnumName(15)
Write-Host

[MediaTypes].GetEnumNames() | ForEach-Object {
	"{0, -10} {1}" -f $_,[int][MediaTypes]::$_
}

[Flags()] enum FileAttributes {
	Archive	= 1
	Compressed = 2
	Device = 4
	Directory = 8
	Encrypted = 16
	Hidden = 32
}
