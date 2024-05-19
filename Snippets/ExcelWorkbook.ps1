
# 엑셀 인스턴스 생성
$excel = New-Object -comobject Excel.Application
# 바탕화면에 샘플파일 하나 생성 => e.g. DmmoExcel.xlsx
$FilePath = 'C:\Desktop\DemoExcel.xlsx'
$workbook = $excel.Workbooks.Open($FilePath)
$excel.Visible = $true
# 워크북에 첫번째 시트 할당
$sheet = $workbook.Worksheets[1]

# 시트 활성화
$sheet.Activate 

# 행번호 초기화, foreach loop 용
$index = 1

# Temp 폴더에서 10메가 이상인 것 추리기
$files = $(Get-ChildItem $env:TEMP | Where-Object {$_.Length -gt 10})
foreach ($item in $files) {
    $sheet.Cells[$index,1] = $item.FullName
    $sheet.Cells[$index,2] = $item.CreationTime.ToShortDateString();
    $sheet.Cells[$index++,3] = $item.Length.ToString("#,##0");
}
# 컬럼 자동폭 조절
$sheet.Columns.AutoFit()

#! => 실행 `.\ExcelWorkbook.ps1`
