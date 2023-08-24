#! Function

function Test {
    begin
    {
        $i = 0
    }

    process
    {
        "Iteration : $i"
        $i++
        "`tInput: $input"
        "`tAccess Again: $input"
        $input.Reset()
        "`tAfter Reset: $input"
    }
}

"one", "two" | Test
