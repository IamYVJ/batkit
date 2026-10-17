@echo off
rem Sets the volume to 50%: presses volume-down to reach 0, then volume-up 25 times (2% per step).
powershell -NoProfile -WindowStyle Hidden -Command "$s = New-Object -ComObject WScript.Shell; foreach ($i in 1..50) { $s.SendKeys([char]174) }; foreach ($i in 1..25) { $s.SendKeys([char]175) }"
