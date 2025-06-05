::Init
echo off
chcp 1251
setlocal enabledelayedexpansion
color 0a
title NeoSteamHack
cls






:: Creating shortcut in "Send to" by clicking right mouse button to file
if "%~1"=="" call :create_shortcut_sendto



::Finding SteamLibrary with Spacewar
echo Initialization...

pushd "%temp%"

    powershell -command $steamProcess = Get-Process -Name "steam">nul
    if not %errorlevel% == 0 call :messagebox "Сначала стим включи, полудурок" && start steam:: && exit

    powershell -command $steamProcess = Get-Process -Name "steam"; $steamPath = $steamProcess.Path; Write-Host "$steamPath">steam.exe_path.txt
    set /p steam_path=<steam.exe_path.txt
    set steam_path=%steam_path:~0,-10%

popd


set counter=1

:while_path_is_False
    call :for_path %counter%
if %errorlevel% == 449 goto :while_path_is_False
if %errorlevel% == 404 call :have_no_spacewar

set steam_library_path=%steam_library_path:~1,-1%
set steam_library_path=%steam_library_path:\\=\%



::Inputing .exe's path for converting to Spacewar
cls
if not "%~1"=="" (
	set lnk_exe="%~1"
) else (
	echo Your current Steam Library direct is: "%steam_library_path%\steamapps\"
	echo.
	echo Put your game ".exe" file here:		    Also you can:
	echo 					 1^) exit - ...no comments 
	set /p lnk_exe=">>>"
)
if %lnk_exe% == exit exit



::Doing "format-magic" for .exe path 
set temp_path=%lnk_exe%
set counter=16
:loop
	set /a counter=%counter%-1
		set temp_path="%temp_path:*\=%"
	if %counter% NEQ 0 goto :loop
set temp_path=%temp_path:"=%
call set lnk_work_direct=%%lnk_exe:%temp_path%=%% || call :messagebox "Idk, Bug." && exit
set lnk_work_direct="%lnk_work_direct:"=%"
set lnk_exe="%lnk_exe:"=%"



::Creating .lnk file and copying stuff in Spacewar folder
echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut.vbs
echo sLinkFile = "%steam_library_path%\steamapps\common\Spacewar\game_link.lnk" >> shortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut.vbs
echo oLink.TargetPath = %lnk_exe% >> shortcut.vbs
echo oLink.WorkingDirectory = %lnk_work_direct:~0,-2%" >> shortcut.vbs
echo oLink.Save >> shortcut.vbs
cscript /nologo shortcut.vbs
del shortcut.vbs

xcopy "SteamworksExample.exe" "%steam_library_path%\steamapps\common\Spacewar\" /y>nul
call :messagebox "Now u can start Spacewar."
exit










::Definitions :)
:have_no_spacewar
cls
echo Install Spacewar and restart Steam.         Also you can:
echo 					 1) y - install SpaceWar
echo 					 2) n - exit
set /p answer="Wanna install Spacewar? y\n >>>"
if %answer% == y start steam://install/480 && exit
if not %answer% == n goto :have_no_spacewar
exit


:create_shortcut_sendto
	echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut2.vbs
	echo sLinkFile = "%appdata%\Microsoft\Windows\SendTo\NeoSteamHack.lnk" >> shortcut2.vbs
	echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut2.vbs
	echo oLink.TargetPath = "%~dp0NeoSteamHack.bat" >> shortcut2.vbs
	echo oLink.WorkingDirectory = "%~dp0" >> shortcut2.vbs
	echo oLink.Save >> shortcut2.vbs
	cscript /nologo shortcut2.vbs
	del shortcut2.vbs
exit /b


:messagebox
	echo msgbox"%~1">message.vbs
	start message.vbs
	timeout /t 1 /nobreak>nul
	del /f message.vbs
exit /b


:for_path
    for /F "usebackq skip=%1 delims=" %%a in ("%steam_path%\steamapps\libraryfolders.vdf") do (
        set /a counter+=1
        echo %%a|findstr \"path\"
        if not !errorlevel! == 1 (
            call :for_480 !counter!
            if !errorlevel! == 449 exit /b 449
            if !errorlevel! == 218 (
                for /F "tokens=1,* delims=		" %%c in ("%%a") do (set steam_library_path=%%d)
                exit /b 218
            )
        )
    )>nul
exit /b 404


:for_480
    for /F "usebackq skip=%1 delims=" %%b in ("%steam_path%\steamapps\libraryfolders.vdf") do (
        set /a counter+=1
        echo %%b|findstr \"480\"
        if not !errorlevel! == 1 exit /b 218
        echo %%b|findstr "}"
        if not !errorlevel! == 1 exit /b 449
    )>nul
exit /b