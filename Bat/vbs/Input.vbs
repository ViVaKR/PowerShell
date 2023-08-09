option explicit

dim str
dim sstr
dim tot

str=inputbox("첫번째 숫자를 넣어주세요")
sstr=inputbox("두번째 숫자를 넣어 주세요")
tot=int(str)+int(sstr)
msgbox "두 수의 합계는" & tot & "입니다."