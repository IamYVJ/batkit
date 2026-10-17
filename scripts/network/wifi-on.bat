@echo off
rem Turns Wi-Fi back on by enabling the adapter. Needs admin, so it asks via UAC.
rem If your adapter isn't called "Wi-Fi", change ADAPTER (see: netsh interface show interface).
set "ADAPTER=Wi-Fi"

net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

netsh interface set interface name="%ADAPTER%" admin=enabled
if errorlevel 1 pause
