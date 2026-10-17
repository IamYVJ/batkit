@echo off
rem Restarts into the UEFI/BIOS setup screen after a 5 second countdown. Needs admin and a UEFI PC.
rem Save your work first. Run cancel-shutdown.bat within 5 seconds to abort.

net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

shutdown /r /fw /t 5
if errorlevel 1 (
    echo Couldn't restart into firmware setup. This PC may be using legacy BIOS.
    pause
)
