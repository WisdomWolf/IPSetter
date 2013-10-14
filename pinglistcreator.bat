@ECHO OFF

IF EXIST addresses.txt DEL addresses.txt

SET /a oct3 = 10

:loop3
SET /a oct4 = 0
IF %oct3% LEQ 12 (
	ECHO Calling Loop4...
	CALL :loop4
	ECHO Loop4 finished.
	PAUSE
	ECHO Resetting 4th octet.
	ECHO Incrementing 3rd octet.
	SET /a oct3 += 1
	ECHO Starting address is now 128.3.%oct3%.%oct4%
	GOTO loop3)
GOTO end

:loop4
IF %oct4% LSS 100 (
	ECHO 128.3.%oct3%.%oct4% >> addresses.txt
	SET /a oct4 += 1
	GOTO loop4)
GOTO :eof

:end