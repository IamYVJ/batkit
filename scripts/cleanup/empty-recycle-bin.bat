@echo off
rem PERMANENTLY empties the Recycle Bin on every drive. Asks first, and deleted files can't be recovered.

choice /c YN /n /m "Permanently empty the Recycle Bin? [Y/N] "
if errorlevel 2 exit /b

powershell -NoProfile -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"
echo Done.
timeout /t 2 >nul
