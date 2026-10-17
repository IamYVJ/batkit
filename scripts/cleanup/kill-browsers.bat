@echo off
rem Force-closes all common browsers. Most browsers offer to restore your tabs next time.
for %%b in (chrome.exe msedge.exe firefox.exe brave.exe opera.exe vivaldi.exe) do taskkill /f /im %%b >nul 2>&1
