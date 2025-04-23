@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul

REM Skript um aus dem Projekt mit git ein portables .zip zu erstellen
REM (C) Adam Skotarczak
REM
REM Version: v1.0.0
REM Github: https://github.com/realAscot/gitcopy

REM -------------------------------------------------------------------

REM Prüfe auf optionalen Parameter "--debug"
set DEBUG=0

if "%~1"=="--debug" (
    set DEBUG=1
    echo [⚠] Debug-Modus aktiv: Ignoriere offene Commits.
)

if "%~1"=="--h" (
    call :show_help
    exit /b 0
)

call :generate_timestamp
set ZIP_NAME=projektarchiv-%TIMESTAMP%.zip

REM -------------------------------------------------------------------

pushd %~dp0

if %DEBUG%==0 (
    echo [*] Prüfe auf uncommitted oder ungetrackte Änderungen...
    set "hasChanges="
    for /f "delims=" %%i in ('git status --porcelain') do (
        set "hasChanges=1"
        goto :has_changes
    )
    echo [✔] Arbeitsverzeichnis ist sauber.
) else (
    echo [⚠] Prüfschritt übersprungen.
)

goto :create_zip

:has_changes
echo .
echo [!] Es sind uncommitted oder ungetrackte Änderungen vorhanden:
git status --short
echo.
echo [✘] Bitte committe oder stash diese Änderungen, bevor du ein ZIP erstellst.
echo [⚠] versuche    --debug    um diese Prüfung zu umgehen aber dann wird das Archiv unvollständig.
endlocal
pause
exit /b 1

:create_zip
echo [*] Erstelle ZIP-Archiv von HEAD...
git archive --format=zip --output="%ZIP_NAME%" HEAD
if errorlevel 1 (
    echo [!] Fehler beim Erstellen des Archivs.
    pause
    exit /b 1
)
echo [✔]  Archiv erfolgreich erstellt: %CD%\%ZIP_NAME%
popd
endlocal
pause
exit /b 0

:generate_timestamp
REM Erzeugt einen Zeitstempel TTMMJJHHMM sicher und universell
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

:show_help
echo.
echo GitCopy – Hilfe
echo =====================
echo Erstellt ein ZIP-Archiv vom aktuellen HEAD-Stand des Git-Repositories.
echo.
echo Verwendung:
echo   gitcopy.bat [Option]
echo.
echo Optionen:
echo   --debug   Überspringt die Prüfung auf uncommitted oder ungetrackte Änderungen.
echo   --h       Zeigt diese Hilfe an.
echo.
pause
goto :eof

endlocal