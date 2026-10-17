@echo off
rem Shows the saved password for the Wi-Fi network you're connected to. Needs admin, so it asks via UAC.
rem Parses netsh output, so it expects English Windows.
setlocal

net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

set "SSID="
for /f "tokens=1,* delims=:" %%a in ('netsh wlan show interfaces ^| findstr /r /c:"^ *SSID "') do set "SSID=%%b"
if not defined SSID (
    echo Not connected to Wi-Fi.
    pause
    exit /b 1
)
set "SSID=%SSID:~1%"

set "KEY="
for /f "tokens=1,* delims=:" %%a in ('netsh wlan show profile name^="%SSID%" key^=clear ^| findstr /c:"Key Content"') do set "KEY=%%b"

echo Network:  %SSID%
if defined KEY (echo Password:%KEY%) else (echo Password: none saved ^(open network?^))
echo.
pause
