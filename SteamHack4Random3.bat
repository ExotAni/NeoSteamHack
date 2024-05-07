echo off
title SteamHack
chcp 1251
cls


REM ----------------------------------------------Сам вставляй сюда свой ебучий путь к стиму
set steamdirect=D:\1337\Steam\steamapps

if not exist "%steamdirect%\common\Spacewar\" echo msgbox"Install Spacewar for work: (steam://install/480)" > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs && exit

:again
if not "%~1"=="" (
    set exedirect="%~1"
) else (
set /p exedirect=">>>"
)

if %exedirect% == short del /f /q %appdata%\Microsoft\Windows\SendTo\SteamHack.lnk && cls && echo Link succesful created. && goto short
if %exedirect% == del del /f /q %appdata%\Microsoft\Windows\SendTo\SteamHack.lnk && cls && echo Link succesful deleted. && goto again
if %exedirect% == exit exit

set bruh=%exedirect%
set timer=16
:timer
	set /a timer=%timer%-1
		set bruh=%bruh:*\=%
	if %timer% EQU 0 goto end
goto timer
:end
call set workdirect=%%exedirect:%bruh%=%%


set workdirect=%workdirect:"=%
set exedirect=%exedirect:"=%
echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut.vbs
echo sLinkFile = "%steamdirect%\common\Spacewar\SteamworksExample.lnk" >> shortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut.vbs
echo oLink.TargetPath = "%exedirect%" >> shortcut.vbs
echo oLink.WorkingDirectory = "%workdirect%" >> shortcut.vbs
echo oLink.Save >> shortcut.vbs
cscript /nologo shortcut.vbs
del shortcut.vbs
echo run "%steamdirect%\common\Spacewar\SteamworksExample.lnk" > SteamworksExample.ahk

REM ----------------------------------------------И сюда вставляй свой ебучий путь к AHK, гандон
Compiler\Ahk2Exe.exe /in "SteamworksExample.ahk" || echo msgbox"Maybe u haven't the Compiler, maybe incorrect path, idk. Подумай." > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs && del /f /q SteamworksExample.ahk && exit

xcopy "SteamworksExample.exe" "%steamdirect%\common\Spacewar\" /y
if exist "SteamworksExample.exe" del /f /q "SteamworksExample.exe"
if exist "SteamworksExample.ahk" del /f /q "SteamworksExample.ahk"
echo msgbox"Complete." > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs
exit
:short
	echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut2.vbs
	echo sLinkFile = "%appdata%\Microsoft\Windows\SendTo\SteamHack.lnk" >> shortcut2.vbs
	echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut2.vbs
	echo oLink.TargetPath = "%~dp0SteamHack4Random2.bat" >> shortcut2.vbs
	echo oLink.WorkingDirectory = "%~dp0" >> shortcut2.vbs
	echo oLink.Save >> shortcut2.vbs
	cscript /nologo shortcut2.vbs
	del shortcut2.vbs
goto again