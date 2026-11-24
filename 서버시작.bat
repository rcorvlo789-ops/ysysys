@echo off
chcp 65001 >nul
echo 서버를 시작합니다...
powershell -ExecutionPolicy Bypass -File "%~dp0서버시작.ps1"
pause
