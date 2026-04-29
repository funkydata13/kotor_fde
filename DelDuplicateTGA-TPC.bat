@echo off

cd /D "%~dp0"
cd override

echo Version 1.1
echo.
echo Please be sure this file is located in the games root folder (where the games .exe is located)
echo and not in the Override folder.
echo.
echo This file deletes duplicate TGA or TPC files in the Override folder.
echo.

Set /P _inputtype= Which type of file should be deleted if a duplicate is found? [tga/tpc]: 
echo.
IF /I "%_inputtype%"=="tga" GOTO :tgaloop
IF /I "%_inputtype%"=="tpc" GOTO :tpcloop
echo Error: Unknown Input, Exiting
echo.
GOTO :errorstate

:tgaloop
Set /P _inputask= Do you want to manually confirm each deletion? [y/n]: 
echo.
IF /I "%_inputask%"=="y" GOTO :tgamanual
IF /I "%_inputask%"=="yes" GOTO :tgamanual
IF /I "%_inputask%"=="n" GOTO :tgaauto
IF /I "%_inputask%"=="no" GOTO :tgaauto
echo Error: Unknown Input, Exiting
echo.
GOTO :errorstate

:tgamanual
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "usebackq delims=" %%i in ( `dir /b /s *.tga` ) do (
    IF EXIST "%%~dpni.tpc" (
	echo "%%i"
	Set /P _inputdel= Delete? [y/n]: 
        IF /I "!_inputdel!"=="y"  (
        DEL "%%i"
        echo Deleted "%%i"
	)
	IF /I "!_inputdel!"=="yes"  (
        DEL "%%i"
        echo Deleted "%%i"
	)
	echo.
    )
)
GOTO :finish

:tgaauto
FOR /F "usebackq delims=" %%i in ( `dir /b /s *.tga` ) do (
    IF EXIST "%%~dpni.tpc" (
        DEL "%%i"
        echo Deleted "%%i"
    )
)
echo.
GOTO :finish

:tpcloop
Set /P _inputask= Do you want to manually confirm each deletion? [y/n]: 
echo.
IF /I "%_inputask%"=="y" GOTO :tpcmanual
IF /I "%_inputask%"=="yes" GOTO :tpcmanual
IF /I "%_inputask%"=="n" GOTO :tpcauto
IF /I "%_inputask%"=="no" GOTO :tpcauto
echo Error: Unknown Input, Exiting
echo.
GOTO :errorstate

:tpcmanual
SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F "usebackq delims=" %%i in ( `dir /b /s *.tpc` ) do (
    IF EXIST "%%~dpni.tga" (
	echo "%%i"
	Set /P _inputdel= Delete? [y/n]: 
        IF /I "!_inputdel!"=="y"  (
        DEL "%%i"
        echo Deleted "%%i"
	)
	IF /I "!_inputdel!"=="yes"  (
        DEL "%%i"
        echo Deleted "%%i"
	)
	echo.
    )
)
GOTO :finish

:tpcauto
FOR /F "usebackq delims=" %%i in ( `dir /b /s *.tpc` ) do (
    IF EXIST "%%~dpni.tga" (
        DEL "%%i"
        echo Deleted "%%i"
    )
)
echo.
GOTO :finish


:finish
echo Finished
echo.
:errorstate
pause
:end