@echo off
rem Builds a battery health report (design vs. current capacity, usage history) and opens it.
rem On a desktop PC the report still opens, but has no battery data.
set "OUT=%TEMP%\battery-report.html"

powercfg /batteryreport /output "%OUT%" >nul 2>&1
if errorlevel 1 goto nobattery
start "" "%OUT%"
exit /b

:nobattery
echo No battery report available. This is normal on a desktop PC.
pause
