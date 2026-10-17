@echo off
rem Clears the "Recent files" list in File Explorer and the recent items in taskbar Jump Lists.

if not defined APPDATA (echo APPDATA is not set; nothing deleted. & pause & exit /b 1)

set "RECENT=%APPDATA%\Microsoft\Windows\Recent"
del /f /q "%RECENT%\*" >nul 2>&1
del /f /q "%RECENT%\AutomaticDestinations\*" >nul 2>&1
del /f /q "%RECENT%\CustomDestinations\*" >nul 2>&1
echo Done.
timeout /t 2 >nul
