ForEach ($user in $users) {
    Set-ADUser $user -Department "Marketing"
}

# 병렬 처리
$users | ForEach-Object -Parallel { Set-ADUser $user -Department "Marketing"}
