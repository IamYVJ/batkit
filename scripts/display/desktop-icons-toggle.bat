@echo off
rem Shows or hides all desktop icons. Explorer restarts to apply it, so the taskbar flickers briefly.

set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

reg query "%KEY%" /v HideIcons | find "0x1" >nul
if %errorlevel%==0 (set HIDE=0) else (set HIDE=1)

reg add "%KEY%" /v HideIcons /t REG_DWORD /d %HIDE% /f >nul
taskkill /f /im explorer.exe >nul
start explorer.exe
