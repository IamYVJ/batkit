@echo off
rem Restarts Windows Explorer. Fixes a frozen or glitchy taskbar/Start menu.
taskkill /f /im explorer.exe >nul
start explorer.exe
