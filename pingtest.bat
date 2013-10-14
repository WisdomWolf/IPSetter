@ECHO OFF

IF NOT EXIST ipaddresslist.txt GOTO missinglist
IF EXIST reply.txt DEL reply.txt


setlocal EnableDelayedExpansion

FOR /F "tokens=1 delims=&&" %%A IN (ipaddresslist3.txt) DO (
	ECHO %%A >> reply.txt
	ping -n 1 %%A | FIND /I "reply" >> reply.txt
	ECHO ------------------------------------------------------------------ >> reply.txt
)
GOTO end
endlocal

:missinglist
ECHO ipaddresslist3.txt couldn't be found.
PAUSE
GOTO end


:end