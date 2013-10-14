@ECHO OFF

IF NOT EXIST ipaddresslist.txt GOTO missinglist
IF EXIST pingtemp.txt DEL pingtemp.txt


setlocal EnableDelayedExpansion

:pingloop
FOR /F "tokens=1 delims=&&" %%A IN (ipaddresslist.txt) DO (
	ping -n 1 %%A | FIND /I "reply" > pingtemp.txt
	FOR /F "tokens=6 delims= " %%B IN (pingtemp.txt) DO SET _response=%%B
	DEL pingtemp.txt
	CALL :available_check %%A !_response!
)
GOTO end
endlocal

:available_check
SET ip=%1
SET status=%2
IF %status%==unreachable. (
	ECHO %ip% is available.
	CHOICE /C:YN /t 10 /d Y /M "Would you like to use %ip%? "
	IF ERRORLEVEL 2 GOTO pingloop
	IF ERRORLEVEL 1 CALL ipsetter.bat %ip%
	REM CALL ipsetter.bat %ip%
	GOTO endX
) ELSE (GOTO :eof)

:missinglist
ECHO ipaddresslist.txt couldn't be found. Will exit after next keypress.
PAUSE
GOTO end


:end
ECHO No available IP found.
PAUSE
EXIT

:endX
EXIT