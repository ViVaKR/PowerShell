#! 파이프 라인

function Get-PipeLine {
    # 파이프 라인에서 함수를 사용하는 경우 
    # 파이프된 개체는 자동변수 $input 에 할당됨
    # 모든 개체는 end 에서 받은후 실행
    begin { 
        "Begin: The input is $input" 
    } # 함수의 시작 부분에서 한번 만 실행

    # process 가 있으면 자동변수 $input 은 $_ 할당되고 삭제됨
    process {
        # 한번에 하나의 파이프라인 개체의 자동변수 `$_` 에 할당
        "The value is : $_"
    }

    end { 
        "End: The input is $input"
    }
    clean { 
        "Clean"
    } 
}
1, 2, 4 | Get-PipeLine 

