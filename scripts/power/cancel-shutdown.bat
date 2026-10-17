@echo off
rem Cancels a scheduled shutdown or restart.
shutdown /a
if errorlevel 1 (echo No shutdown was scheduled.) else (echo Shutdown cancelled.)
timeout /t 3 >nul
