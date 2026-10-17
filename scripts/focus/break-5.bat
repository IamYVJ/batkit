@echo off
rem 5 minute break timer. A message box pops up when time is up. Close this window to cancel.
rem Change MINUTES for a different length.
set "MINUTES=5"

set /a SECS=%MINUTES%*60
title Break timer: %MINUTES% minutes
echo Break for %MINUTES% minutes. Close this window to cancel.
timeout /t %SECS% /nobreak >nul

powershell -NoProfile -Command "Add-Type -AssemblyName System.Windows.Forms; [void][System.Windows.Forms.MessageBox]::Show('Break is over.', 'batkit timer', 'OK', 'Information')"
