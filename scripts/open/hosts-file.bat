@echo off
rem Opens the hosts file in Notepad with admin rights, so you can save changes. Asks via UAC.
powershell -NoProfile -Command "Start-Process -FilePath notepad.exe -ArgumentList '%SystemRoot%\System32\drivers\etc\hosts' -Verb RunAs"
