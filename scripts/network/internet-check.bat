@echo off
rem Tells you whether a problem is your connection or DNS. Pings 1.1.1.1, then looks up one.one.one.one.

echo Testing connection ^(ping 1.1.1.1^)...
ping -4 -n 3 1.1.1.1 | find "TTL=" >nul
if errorlevel 1 (
    echo   FAILED: no internet connection. Check your router or Wi-Fi.
    goto end
)
echo   OK

echo Testing DNS ^(looking up one.one.one.one^)...
powershell -NoProfile -Command "Resolve-DnsName one.one.one.one -ErrorAction Stop | Out-Null" >nul 2>&1
if errorlevel 1 (
    echo   FAILED: the connection works but DNS doesn't. Try flush-dns.bat.
    goto end
)
echo   OK

echo.
echo Everything looks fine.

:end
echo.
pause
