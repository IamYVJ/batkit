@echo off
rem Switches to the Balanced power plan.
powercfg /setactive SCHEME_BALANCED
if errorlevel 1 (pause & exit /b 1)
powercfg /getactivescheme
timeout /t 3 >nul
