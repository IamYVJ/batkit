@echo off
rem Repairs corrupted Windows files: DISM restores the component store, then SFC fixes system files.
rem Needs admin, so it asks via UAC. Can take 10 to 30 minutes. DISM downloads repair files from Windows Update.

net session >nul 2>&1 || (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

echo Step 1 of 2: DISM
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo Step 2 of 2: SFC
sfc /scannow
echo.
echo Finished. Restart the PC if repairs were reported.
pause
