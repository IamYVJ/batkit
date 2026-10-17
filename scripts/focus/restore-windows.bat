@echo off
rem Brings back the windows hidden by minimize-all.bat (same as Win+Shift+M).
powershell -NoProfile -WindowStyle Hidden -Command "(New-Object -ComObject Shell.Application).UndoMinimizeAll()"
