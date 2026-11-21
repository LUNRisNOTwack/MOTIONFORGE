@echo off
setlocal EnableExtensions
title Motion Forge Studio - diagnostics
set "R=%USERPROFILE%\Desktop\MotionForge-Diagnostics.txt"
set "D=%APPDATA%\MotionForge\Studio"
set "I=%~dp0"
if not exist "%I%runtime\motionforge-studio.exe" set "I=%ProgramFiles%\Motion Forge Studio\"
if not exist "%I%runtime\motionforge-studio.exe" set "I=%ProgramFiles(x86)%\Motion Forge Studio\"
echo Collecting information about Motion Forge Studio. This takes about 30 seconds...
call :report > "%R%" 2>&1
echo.
echo Finished. The report is on your Desktop:
echo    %R%
echo Please send that file.
start "" notepad "%R%"
pause
exit /b 0

:report
echo === Motion Forge Studio diagnostics ===
echo Date: %DATE% %TIME%
echo User: %USERNAME%   Computer: %COMPUTERNAME%
ver
echo Install folder: %I%
echo Data folder: %D%
echo.
echo === Install folder ===
dir "%I%"
dir "%I%runtime"
echo.
echo === Browsers ===
if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" echo Edge found - x86 path
if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" echo Edge found
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" echo Chrome found
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" echo Chrome found - x86 path
if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" echo Chrome found - user install
echo.
echo === Engine version check ===
"%I%runtime\motionforge-studio.exe" -p "process.version+' '+process.arch+' '+process.platform"
echo exit code: %ERRORLEVEL%
echo.
echo === Self test ===
"%I%runtime\motionforge-studio.exe" "%I%studio\selftest.js"
echo exit code: %ERRORLEVEL%
echo.
echo === Running Studio directly for 12 seconds, no window ===
del "%D%\launch.status" "%D%\launch.stage" "%D%\launch.url" 2>nul
set "MF_NO_WINDOW=1"
start "" /b "%I%runtime\motionforge-studio.exe" "%I%studio\main.js" >> "%D%\diag-run.log" 2>&1
ping -n 13 127.0.0.1 >nul
echo launch.status:
type "%D%\launch.status"
echo.
echo launch.stage:
type "%D%\launch.stage"
echo.
echo diag-run.log:
powershell -NoProfile -Command "if (Test-Path '%D%\diag-run.log') { Get-Content '%D%\diag-run.log' -Tail 60 }"
taskkill /f /im motionforge-studio.exe
echo.
echo === studio.log - last 40 lines ===
powershell -NoProfile -Command "if (Test-Path '%D%\studio.log') { Get-Content '%D%\studio.log' -Tail 40 }"
echo.
echo === console.log - last 40 lines ===
powershell -NoProfile -Command "if (Test-Path '%D%\console.log') { Get-Content '%D%\console.log' -Tail 40 }"
echo.
echo === Windows Security ===
powershell -NoProfile -Command "try { Get-MpComputerStatus | Select-Object RealTimeProtectionEnabled,AntivirusEnabled | Format-List; Get-MpThreatDetection | Where-Object { $_.Resources -match 'MotionForge|Motion Forge' } | Select-Object InitialDetectionTime,ThreatID,Resources | Format-List } catch { 'Not available: ' + $_ }"
echo.
echo === Recent Windows application errors mentioning Motion Forge ===
powershell -NoProfile -Command "try { Get-WinEvent -FilterHashtable @{LogName='Application';Level=2,3;StartTime=(Get-Date).AddDays(-2)} -MaxEvents 80 | Where-Object { $_.Message -match 'motionforge' } | Select-Object -First 5 TimeCreated,ProviderName,Message | Format-List } catch { 'Not available: ' + $_ }"
echo.
echo === Listening local ports ===
netstat -ano | findstr LISTENING | findstr 127.0.0.1
echo.
echo Done.
exit /b 0
