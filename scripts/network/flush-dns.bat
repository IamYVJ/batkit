@echo off
rem Clears the DNS cache. Often fixes "site won't load" after a site moves servers.
ipconfig /flushdns
timeout /t 3 >nul
