@echo off
rem Turns notification banners back on after focus-mode.bat.
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 1 /f >nul

echo Focus mode off.
timeout /t 2 >nul
