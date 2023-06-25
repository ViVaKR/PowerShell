$nums = 1..10

foreach ($n in $nums) {
	if($n -eq 5) {
		return $n * 10
	}
}
