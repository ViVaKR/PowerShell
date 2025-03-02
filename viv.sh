#! /usr/bin/env bash

echo "Start..."

echo "PID : $$"
echo "Args Count : $#"

echo "${*}"
echo "${@}"

for i in $* 
do
	echo "Welcome ${i} times"

done

name='Kim Bum Jun'
pwd='B9037!m8947#'
echo "my name is mr.${name}"

printf "%s\n" $pwd

function local_var() {

	local name="ViVaKR"
	echo "local variable : ${name}"
}

local_var

# 변수초기화
unset name

# 읽기 전용 타입 (const)
declare -r var1

# 정수타입
declare -i num1

# 함수타입
declare -f func1

# -A 연관배열 (MAP) 타입
declare -A map1
num1=45
echo "number = $num1"

# 환경 변수 선언
export hello_world="Global Hello, World!"

echo ${hello_world}

# $? : 실행한 뒤의 반환값

echo "$HOME"
echo "$UID"
echo "$USER"
echo "$TERM"
echo "$LANG"

# 계산
n1=15
n2=3

echo `expr $n1 + $n2`
echo `expr $n1 \* $n2`


let add=n1+n2
let sub=n1-n2
let mul=n1*n2
let div=n1/n2

printf "%d, %d, %d, %d\n\n" "$add" "$sub" "$mul" "$div"

echo mul:$((n1 * n2))
echo mod:$((n1 % n2))

echo $[2 << 1]
echo $[++n2]

echo "2^8" | bc


s1="hello"
s2="world"
s3="world"
s4="..."
s5=$NULL

if [ $s2 == $s3 ]; then
	echo "같음"
else
	echo "다름"
fi

if [ -z $s4 ]; then
	echo "is NULL"
else
	echo "is not NULL"
fi

if [ -z $s5 ]; then
	echo "${s5} is null"
fi

if [ -n $s1 ]; then
	echo "${s1} is not null"
fi

value=15

case ${value} in
10)
	echo "is 10"
	;;
15)
	echo "is 15"
	;;
*)
	echo "unknown"
	;;
esac

date=250725

case ${date} in
??06?? | ??07?? | ??08??) echo "여름";;
*) echo "unknown";;
esac

str="abc"

case $str in

	a*) echo "Start with a";;
	a?) echo "Start with one char";;
	a[bc]) echo "Start with a and b or c";;
	*) echo "Unknown";;
esac

for ((i=1; i<=4;i++)); do
	echo $i
done

echo
echo

for x in {1..10} 
do
	echo "${x}"

done

echo
echo

for x in  5 6 7 8 9
do
	echo $x
done


arr=(11 22 33 44 55)

for i in "${arr[@]}"
do
	echo "${i}"
done

echo
echo

for i in `seq 100 105`
do
	echo $i
done


for line in `ls`
do
	echo ${line}
done

count=0

while [ ${count} -le 5 ];

do
	echo ${count}
	count=$(( ${count} + 1 ))

done


count2=0

until [ ${count2} -gt 5 ];
do
	echo "untile ${count2}"
	count2=$(( ${count2} + 1 ))
done





















unset n1
unset n2
