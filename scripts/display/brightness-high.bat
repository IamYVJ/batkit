@echo off
rem Sets screen brightness to 100%. Works on laptop screens; most external monitors don't support it.

powershell -NoProfile -Command "$m = Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods -ErrorAction SilentlyContinue; if (-not $m) { exit 1 }; $m | ForEach-Object { $_.WmiSetBrightness(1, 100) } | Out-Null"
if errorlevel 1 (echo Brightness control isn't supported on this display. & pause)
