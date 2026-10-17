@echo off
rem Keeps the PC and screen from sleeping until you press Enter or close this window.

rem 2147483651 = ES_CONTINUOUS | ES_SYSTEM_REQUIRED | ES_DISPLAY_REQUIRED
powershell -NoProfile -Command "Add-Type -Name P -Namespace W -MemberDefinition '[DllImport(\"kernel32.dll\")] public static extern uint SetThreadExecutionState(uint flags);'; [W.P]::SetThreadExecutionState(2147483651) | Out-Null; Write-Host 'Keeping the PC awake. Press Enter or close this window to stop.'; Read-Host | Out-Null"
