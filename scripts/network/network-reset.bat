@echo off
rem Releases/renews the IP address, flushes DNS and resets Winsock. Needs admin, so it asks via UAC.
rem You'll drop offline for a few seconds; restart afterwards to finish the Winsock reset.

net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo Releasing IP address...
ipconfig /release >nul
echo Flushing DNS...
ipconfig /flushdns >nul
echo Renewing IP address...
ipconfig /renew >nul
echo Resetting Winsock...
netsh winsock reset
echo.
echo Done. Restart the PC to finish the reset.
pause
