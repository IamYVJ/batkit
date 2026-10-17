@echo off
rem Toggles Windows and apps between dark and light mode. Some open apps update only after a restart.

set "KEY=HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

reg query "%KEY%" /v AppsUseLightTheme | find "0x0" >nul
if %errorlevel%==0 (set LIGHT=1) else (set LIGHT=0)

reg add "%KEY%" /v AppsUseLightTheme /t REG_DWORD /d %LIGHT% /f >nul
reg add "%KEY%" /v SystemUsesLightTheme /t REG_DWORD /d %LIGHT% /f >nul
