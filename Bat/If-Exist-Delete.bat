IF EXIST f:\Temp_F\*.txt (
	del f:\Temp_F\*.txt.
) ELSE (
	echo f:\Temp_F\*.txt. missing.
)