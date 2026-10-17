@echo off
rem Mutes/unmutes the system volume (same as the keyboard mute key).
powershell -NoProfile -WindowStyle Hidden -Command "(New-Object -ComObject WScript.Shell).SendKeys([char]173)"
