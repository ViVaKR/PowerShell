ForFiles /P "<Path>" /D -2 /C "CMD /C if @ISDIR==TRUE echo RD /Q /S @FILE &;;RD /Q /S @FILE"
exit
