@echo off
chcp 65001 >nul
set "FILE=%~dp0index.html"

:: Chrome 경로 찾기
set "CHROME="
if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" (
    set "CHROME=C:\Program Files\Google\Chrome\Application\chrome.exe"
)
if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" (
    set "CHROME=C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
)

if "%CHROME%"=="" (
    echo Chrome을 찾을 수 없습니다. Edge로 시도합니다...
    set "EDGE=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    if exist "%EDGE%" (
        start "" "%EDGE%" --allow-file-access-from-files "%FILE%"
    ) else (
        echo Edge도 찾을 수 없습니다. 브라우저를 직접 열어주세요.
        pause
    )
) else (
    start "" "%CHROME%" --allow-file-access-from-files "%FILE%"
)
