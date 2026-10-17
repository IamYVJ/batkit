@echo off
rem Switches to the High performance power plan.
powercfg /setactive SCHEME_MIN
if errorlevel 1 (
    echo High performance plan isn't available on this PC ^(common on laptops^).
    echo Run "powercfg /list" to see the plans you have.
    pause
    exit /b 1
)
powercfg /getactivescheme
timeout /t 3 >nul
