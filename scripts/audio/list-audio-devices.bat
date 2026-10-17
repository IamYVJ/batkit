@echo off
rem Lists active playback devices, so you know what to put in the switch-to-*.bat files.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0set-audio-device.ps1"
pause
