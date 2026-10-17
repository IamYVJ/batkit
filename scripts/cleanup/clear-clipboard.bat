@echo off
rem Empties the clipboard, e.g. after copying a password. Doesn't clear Windows clipboard history (Win+V).
powershell -NoProfile -WindowStyle Hidden -Command "Set-Clipboard -Value $null"
