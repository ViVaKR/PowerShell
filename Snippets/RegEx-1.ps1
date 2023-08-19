
$test = 'asd/111/567/bbb/asd'

# (1) asd 로 시작 문자 변경 = `^(asd)`
$test -replace '^(asd)', 'zzz'

# (2) asd 로 끝나는 문자 변경 = `(asd)$`
$test -replace '(asd)$', 'zzz'

#! Results
# (1) result -> zzz/111/567/bbb/asd
# (2) result -> asd/111/567/bbb/zzz
