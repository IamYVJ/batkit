@echo off
rem Toggles Night light (warm screen colours) on/off.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0night-light-toggle.ps1"
if errorlevel 1 pause
