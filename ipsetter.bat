@ECHO OFF

SET Net_Adapt="Local Area Connection"
SET IP_Addr=%1
SET D_Gate=128.3.1.83
SET Sub_Mask=255.255.0.0
ECHO "Setting Static IP Information" 
netsh interface ip SET address %Net_Adapt% static %IP_Addr% %Sub_Mask% %D_Gate% 1 
netsh int ip show config 
PAUSE
GOTO end
