@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

REM Skript, um aus einem Projekt mit git-repo, ein portables .zip zu erstellen
REM 
REM (C) 2025 MIT Adam Skotarczak 
REM
REM Version: v1.1.1
REM Github: https://github.com/realAscot/gitcopy
REM -------------------------------------------------------------------


rem --- Git-Verfügbarkeit prüfen ---
where git >nul 2>nul
if errorlevel 1 (
    echo.
    echo [⚠️] Git ist nicht installiert oder nicht im PATH.
    echo [📦] Bitte installiere Git von https://git-scm.com/download/win
    call :show_help
    echo.
    exit /b 1
)

rem --- Git-Version anzeigen ---
for /f "tokens=*" %%i in ('git --version') do set "GIT_VERSION=%%i"

if defined GIT_VERSION (
    echo.
    echo [✅] Gefundene Git-Version: %GIT_VERSION%
) else (
    echo([⚠️] Konnte Git-Version nicht ermitteln.
)

rem Prüfe auf optionalen Parameter "--debug"
set DEBUG=0

if NOT "%~1"=="" (
    if "%~1"=="--debug" (
        set DEBUG=1
        echo [⚠️] Debug-Modus aktiv: Ignoriere offene Commits.
        exit /b 0
    ) else if "%~1"=="-d" (
        set DEBUG=1
        echo [⚠️] Debug-Modus aktiv: Ignoriere offene Commits.
        exit /b 0
    ) else if "%~1"=="-h" (
        call :show_help
        exit /b 0
    ) else if "%~1"=="--help" (
        call :show_help
        exit /b 0
    ) else (
        rem Parameter vorhanden aber nicht erkannt.
        call :kein_Parameter "%~1"
        exit /b 1
    )
) else (
    call :go "%~1"
)

exit /b 0

:go

call :generate_timestamp
set ZIP_NAME=projektarchiv-%TIMESTAMP%.zip

rem -------------------------------------------------------------------

pushd %~dp0

if %DEBUG%==0 (
    echo [🔍] Prüfe auf uncommitted oder ungetrackte Änderungen...
    set "hasChanges="
    for /f "delims=" %%i in ('git status --porcelain') do (
        set "hasChanges=1"
        goto :has_changes
    )
    echo [✅] Arbeitsverzeichnis ist sauber.
) else (
    echo [⚠️] Prüfschritt übersprungen.
)

goto :create_zip

:has_changes
echo.
echo [⚠️] Es sind uncommitted oder ungetrackte Änderungen vorhanden:
echo.
git status --short
echo.
echo [❌] Bitte committe oder stash diese Änderungen, bevor du ein ZIP erstellst.
echo [⚠️] versuche    --debug    um diese Prüfung zu umgehen aber dann wird das Archiv unvollständig.
echo.
endlocal
pause
exit /b 1

:create_zip
echo [💾] Erstelle ZIP-Archiv von HEAD...
git archive --format=zip --output="%ZIP_NAME%" HEAD
if errorlevel 1 (
    echo [⚠️] Fehler beim Erstellen des Archivs.
    pause
    exit /b 1
)
echo [✅]  Archiv erfolgreich erstellt: %CD%\%ZIP_NAME%
popd
endlocal
pause
exit /b 0

:generate_timestamp
rem Erzeugt einen Zeitstempel TTMMJJHHMM sicher und universell
for /f "tokens=1-4 delims=. " %%d in ('echo %DATE%') do (
    set "TAG=0%%d"
    set "MONAT=0%%e"
    set "JAHR=%%f"
)

for /f "tokens=1-2 delims=: " %%g in ('echo %TIME%') do (
    set "STUNDE=0%%g"
    set "MINUTE=0%%h"
)

set "TAG=!TAG:~-2!"
set "MONAT=!MONAT:~-2!"
set "JAHR=!JAHR:~-2!"
set "STUNDE=!STUNDE:~-2!"
set "MINUTE=!MINUTE:~-2!"

set "TIMESTAMP=!TAG!!MONAT!!JAHR!!STUNDE!!MINUTE!"
goto :eof

:kein_Parameter
echo.
echo [⚠️] Unbekannter Parameter: "%~1" abbruch ...
echo.
call :show_help
exit /b 1

:show_help
echo.
echo ℹ️ GitCopy – Hilfe
echo =====================
echo Erstellt ein ZIP-Archiv vom aktuellen HEAD-Stand des Git-Repositories.
echo.
echo Verwendung:
echo   gitcopy.bat [Option]
echo.
echo Optionen:
echo   --debug / -d  Überspringt die Prüfung auf uncommitted oder ungetrackte Änderungen.
echo   -h / --help   Zeigt diese Hilfe an.
echo.
endlocal
pause
goto :eof

endlocal