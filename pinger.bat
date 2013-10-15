@ECHO OFF

IF NOT EXIST ipaddresslist.txt GOTO missinglist
IF EXIST pingtemp.txt DEL pingtemp.txt
ECHO %DATE% >> pinger_log.txt
ECHO.>> pinger_log.txt


setlocal EnableDelayedExpansion

:pingloop
FOR /F "tokens=1 delims=&&" %%A IN (ipaddresslist.txt) DO (
	ping -n 1 %%A | FIND /I "reply" > pingtemp.txt
	ECHO %%A >> pinger_log.txt
	TYPE pingtemp.txt >> pinger_log.txt
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
	CHOICE /C:YN /M "Would you like to use %ip%? "
	IF ERRORLEVEL 2 (
		ECHO User chose not to use %ip%. >> pinger_log.txt
		GOTO :eof
	)
	IF ERRORLEVEL 1 (
		ECHO Calling ipsetter using %ip%. >> pinger_log.txt
		REM IF ERRORLEVEL 1 CALL ipsetter.bat %ip%
		ECHO "ipsetter template".
	)
	GOTO endX
) ELSE (GOTO :eof)

:missinglist
ECHO ipaddresslist.txt couldn't be found. Will exit after next keypress.
PAUSE
GOTO endX

:SetIP
SET Net_Adapt="Local Area Connection"
SET IP_Addr=%1
SET D_Gate=128.3.1.83
SET Sub_Mask=255.255.0.0
SET DNS_1=128.3.1.32
SET DNS_2=128.3.1.33

ECHO "Setting Static IP Information" 
netsh interface ip set address %Net_Adapt% static %IP_Addr% %Sub_Mask% %D_Gate% 1 
ECHO "Setting DNS"
netsh interface ip set dns %Net_Adapt% static %DNS_1% disabled
netsh interface ip add dns %Net_Adapt% %DNS_2%
ECHO "Configuration complete."
ECHO.
netsh int ip show config 
PAUSE
GOTO endX


:end
ECHO No available IP found.
ECHO Exited without selecting a valid IP.>>pinger_log.txt
PAUSE

:endX
ECHO ------------------------------------------------------>>pinger_log.txt
ECHO.>>pinger_log.txt
EXIT