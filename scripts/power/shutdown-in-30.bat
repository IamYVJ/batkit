@echo off
rem Shuts the PC down in 30 minutes. Run cancel-shutdown.bat to stop it.
shutdown /s /t 1800
echo The PC will shut down in 30 minutes. Run cancel-shutdown.bat to cancel.
timeout /t 5 >nul
