@echo off
cd /d "%~dp0"
if not exist MotionForge-Studio-Setup-3.6.0.part1 (echo part1 is missing & pause & exit /b 1)
if not exist MotionForge-Studio-Setup-3.6.0.part2 (echo part2 is missing & pause & exit /b 1)
if not exist MotionForge-Studio-Setup-3.6.0.part3 (echo part3 is missing & pause & exit /b 1)
copy /b MotionForge-Studio-Setup-3.6.0.part1+MotionForge-Studio-Setup-3.6.0.part2+MotionForge-Studio-Setup-3.6.0.part3 MotionForge-Studio-Setup-3.6.0.exe >nul
set "H="
for /f "skip=1 tokens=*" %%h in ('certutil -hashfile MotionForge-Studio-Setup-3.6.0.exe SHA256') do if not defined H set "H=%%h"
set "H=%H: =%"
if /i "%H%"=="22b6b4d9af71b153e1677763b7c0de3316a07fa26969be94b2fa223924883d91" (
  echo The installer was joined correctly: MotionForge-Studio-Setup-3.6.0.exe
  echo Double-click it to install.
) else (
  echo The parts did not join correctly. Download them again.
  del MotionForge-Studio-Setup-3.6.0.exe
)
pause
