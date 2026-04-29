@echo off
setlocal enabledelayedexpansion

:: --- CONFIGURATION ---
:: Indique ici le chemin de ton dossier de backup
set "BACKUP_DIR=I:\GameMods\Kotor\Backup"
:: Le dossier actuel (où se trouve le script)
set "GAME_DIR=%~dp0"

:MENU
cls
echo ======================================================
echo           KOTOR MODDING - GESTIONNAIRE DE BACKUP
echo                   by funky version 1.0
echo ======================================================
echo  Source  : !GAME_DIR!
echo  Backup  : !BACKUP_DIR!
echo ------------------------------------------------------
echo  1. [SAUVEGARDER] Jeu --^> Backup (Incrémentiel)
echo  2. [RESTAURER]    Backup --^> Jeu (Incrémentiel)
echo  3. Quitter
echo ------------------------------------------------------
set /p choice="Choisis une option (1-3) : "

if "%choice%"=="1" goto BACKUP
if "%choice%"=="2" goto RESTORE
if "%choice%"=="3" exit
goto MENU

:BACKUP
echo.
echo --- SAUVEGARDE EN COURS (Jeu vers Backup) ---
:: Dossiers
robocopy "!GAME_DIR!override" "!BACKUP_DIR!\override" /MIR /MT:8 /R:3 /W:5
robocopy "!GAME_DIR!modules"  "!BACKUP_DIR!\modules"  /MIR /MT:8 /R:3 /W:5
:: Fichiers spécifiques
if exist "swkotor.exe" copy /Y "swkotor.exe" "!BACKUP_DIR!\swkotor.exe"
if exist "dialog.tlk"  copy /Y "dialog.tlk"  "!BACKUP_DIR!\dialog.tlk"
if exist "kotor_fde_preset.ini"  copy /Y "kotor_fde_preset.ini"  "!BACKUP_DIR!\kotor_fde_preset.ini"
echo.
echo Sauvegarde terminee.
pause
goto MENU

:RESTORE
echo.
echo --- RESTAURATION EN COURS (Backup vers Jeu) ---
echo ATTENTION : Tu vas ecraser les fichiers du jeu avec le backup !
set /p confirm="Tu es sur ? (O/N) : "
if /i not "%confirm%"=="O" goto MENU

:: Dossiers (Inversion des chemins)
robocopy "!BACKUP_DIR!\override" "!GAME_DIR!override" /MIR /MT:8 /R:3 /W:5
robocopy "!BACKUP_DIR!\modules"  "!GAME_DIR!modules"  /MIR /MT:8 /R:3 /W:5
:: Fichiers spécifiques
if exist "!BACKUP_DIR!\swkotor.exe" copy /Y "!BACKUP_DIR!\swkotor.exe" "!GAME_DIR!swkotor.exe"
if exist "!BACKUP_DIR!\kotor_fde_preset.ini"  copy /Y "!BACKUP_DIR!\kotor_fde_preset.ini"  "!GAME_DIR!kotor_fde_preset.ini"
echo.
echo Restauration terminee.
pause
goto MENU