@echo off
rem Shows a short summary of this PC: Windows version, CPU, memory, uptime and free disk space.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0system-info.ps1"
echo.
pause
