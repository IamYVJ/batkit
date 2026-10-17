@echo off
rem Hibernates the PC right away. Hibernation must be enabled (admin: powercfg /hibernate on).
shutdown /h
if errorlevel 1 pause
