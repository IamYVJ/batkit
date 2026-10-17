@echo off
rem Minimizes every open window (same as Win+M). Undo with restore-windows.bat.
powershell -NoProfile -WindowStyle Hidden -Command "(New-Object -ComObject Shell.Application).MinimizeAll()"
