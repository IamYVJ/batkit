@echo off
rem Makes your speakers the default playback device.
rem DEVICE is matched against the device name; run list-audio-devices.bat to see yours.
set "DEVICE=Speakers"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0set-audio-device.ps1" -Name "%DEVICE%"
if errorlevel 1 pause
