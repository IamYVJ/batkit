@echo off
rem Shows this PC's IPv4 address, default gateway and DNS servers for each network adapter.
ipconfig /all | findstr /i /c:"adapter" /c:"IPv4" /c:"Default Gateway" /c:"DNS Servers"
echo.
pause
