@ECHO OFF

IF NOT EXIST ipaddresslist.txt GOTO missinglist
IF EXIST response.txt DEL response.txt


setlocal EnableDelayedExpansion

FOR /F "tokens=1 delims=&&" %%A IN (ipaddresslist.txt) DO (
	ping -n 1 %%A | FIND /I "reply" > response.txt
	FOR /F "tokens=6 delims= " %%B IN (response.txt) DO SET _response=%%B
	CALL :available_check %%A !_response!
)
GOTO end
endlocal

:available_check
SET ip=%1
SET status=%2
IF %status%==unreachable. (
	ECHO %ip% is available.
	PAUSE
	REM CALL ipsetter.bat %ip%
	GOTO endX
) ELSE (GOTO :eof)

:missinglist
ECHO ipaddresslist.txt couldn't be found.
PAUSE
GOTO end


:end
ECHO No available IP found.
PAUSE

:endX
EXIT