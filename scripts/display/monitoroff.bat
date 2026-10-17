@echo off
rem Turns off all connected monitors. Any mouse movement or key press wakes them again.

rem Brief pause so the click/keypress used to launch this doesn't wake the screens right away.
timeout /t 2 /nobreak >nul

rem Broadcast WM_SYSCOMMAND / SC_MONITORPOWER with lParam 2 (= power off).
powershell -NoProfile -WindowStyle Hidden -Command "Add-Type -Name M -Namespace W -MemberDefinition '[DllImport(\"user32.dll\")] public static extern int PostMessage(int hWnd, int msg, int wParam, int lParam);'; [W.M]::PostMessage(0xffff, 0x0112, 0xf170, 2)"
