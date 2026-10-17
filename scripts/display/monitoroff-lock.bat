@echo off
rem Locks the PC, then turns off all connected monitors. Any mouse movement or key press wakes them again.

rundll32.exe user32.dll,LockWorkStation

rem Brief pause so the lock screen finishes appearing and the launch click/keypress doesn't wake the screens.
timeout /t 2 /nobreak >nul

rem Broadcast WM_SYSCOMMAND / SC_MONITORPOWER with lParam 2 (= power off).
powershell -NoProfile -WindowStyle Hidden -Command "Add-Type -Name M -Namespace W -MemberDefinition '[DllImport(\"user32.dll\")] public static extern int PostMessage(int hWnd, int msg, int wParam, int lParam);'; [W.M]::PostMessage(0xffff, 0x0112, 0xf170, 2)"
