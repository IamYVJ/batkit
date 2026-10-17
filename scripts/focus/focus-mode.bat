@echo off
rem Closes chat apps and turns off notification banners. Run focus-off.bat to undo.
rem Edit APPS to suit you (process names from Task Manager > Details). Apps are force-closed,
rem so don't add ones where you might have unsaved work (e.g. Outlook).
set "APPS=slack.exe Discord.exe Teams.exe ms-teams.exe WhatsApp.exe Telegram.exe"

for %%a in (%APPS%) do taskkill /f /im %%a >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f >nul

echo Focus mode on.
timeout /t 2 >nul
