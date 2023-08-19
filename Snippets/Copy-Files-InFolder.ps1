# (1) => 파일생성 => copy_paste_view_list.ps1 
# (2) => 위 파일에 (아래)의 내용 붙여넣기
# (3) => 실행 => .\copy_paste_view_list.ps1

#---------- (아래) copy_paste_view_list.ps1 내용 -------#
$srcFolder = "F:\Temp\Demos" # 복사할 원본폴더
$desFolder = "F:\Temp\DemosDes" # 붙여넣을 대상폴더

# 복사 카피
Get-ChildItem -Path $srcFolder | Copy-Item -Destination $desFolder -Recurse -Container -Force

# 파일목록 만든 후 파일에 저장하기
Get-ChildItem -Path $srcFolder -Recurse | ForEach-Object {$_.FullName} | Set-Content file-list.txt

# 대상폴더 열기 (파일 탐색기)
Invoke-Item $desFolder

# 목록 저장된 파일 열기 (메모장)
Invoke-Item .\file-list.txt

#---------- end ----------------#
