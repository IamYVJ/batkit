@echo off
rem 25 minute focus timer. A message box pops up when time is up. Close this window to cancel.
rem Change MINUTES for a different length.
set "MINUTES=25"

set /a SECS=%MINUTES%*60
title Focus timer: %MINUTES% minutes
echo Focus for %MINUTES% minutes. Close this window to cancel.
timeout /t %SECS% /nobreak >nul

powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; [void][System.Windows.Forms.MessageBox]::Show('%MINUTES% minutes are up.', 'batkit timer', 'OK', 'Information')"
