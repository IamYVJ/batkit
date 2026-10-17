@echo off
rem Lists the Wi-Fi networks in range, with security type and signal strength.
netsh wlan show networks mode=bssid
echo.
pause
