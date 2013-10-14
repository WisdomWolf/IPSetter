@ECHO OFF

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
GOTO end
