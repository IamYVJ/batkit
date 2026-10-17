@echo off
rem Deletes everything in your user temp folder. Files that are in use are skipped.

rem Safety check: without TEMP the paths below would point at the drive root.
if not defined TEMP (echo TEMP is not set; nothing deleted. & pause & exit /b 1)

echo Clearing %TEMP% ...
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%d in ("%TEMP%\*") do rd /s /q "%%d" >nul 2>&1
echo Done.
timeout /t 2 >nul
