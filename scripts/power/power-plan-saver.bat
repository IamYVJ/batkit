@echo off
rem Switches to the Power saver plan.
powercfg /setactive SCHEME_MAX
if errorlevel 1 (
    echo Power saver plan isn't available on this PC.
    echo Run "powercfg /list" to see the plans you have.
    pause
    exit /b 1
)
powercfg /getactivescheme
timeout /t 3 >nul
