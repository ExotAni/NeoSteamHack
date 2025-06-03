echo off
chcp 1251
title NeoSteamHack
set kostil=%cd%

:again
cls
echo Initialization...

if exist %appdata%\directory.txt goto skip

FOR %%G IN (c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do (

	if exist "%%G:\Program Files\SteamLibrary\steamapps" echo %%G:\Program Files\SteamLibrary\steamapps > %appdata%\directory.txt && goto skip
	if exist "%%G:\Program Files (x86)\SteamLibrary\steamapps" echo %%G:\Program Files (x86^)\SteamLibrary\steamapps > %appdata%\directory.txt && goto skip
	if exist "%%G:\Program Files\Steam\steamapps" echo %%G:\Program Files\Steam\steamapps > %appdata%\directory.txt && goto skip
	if exist "%%G:\Program Files (x86)\Steam\steamapps" echo %%G:\Program Files (x86^)\Steam\steamapps > %appdata%\directory.txt && goto skip
	if exist "%%G:\SteamLibrary\steamapps" echo %%G:\SteamLibrary\steamapps > %appdata%\directory.txt && goto skip
)

for %%K in (d,e,c,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z) do (
	cd /d %%K:\ & dir /s /b steamapps >nul
	if %errorlevel% EQU 0 dir /s /b steamapps > %appdata%\directory.txt && goto skip
)		

:res
cls
echo Can not find Steam path. Do u wanna insert correct path? y\n
set /p choice =">>>"
if %choice% == y goto newpath
if not %choice% == n goto res
exit

:skip
cd /d %kostil%
set /p steamdirect= < %appdata%\directory.txt
set steamdirect=%steamdirect:  =%
set steamdirect=%steamdirect:"=%
if not exist "%steamdirect%\common\Spacewar" goto a

cls
if not "%~1"=="" (
	set exedirect="%~1"
) else (
	echo Your current SteamApps direct is: "%steamdirect%"
	echo.
	echo Put your game ".exe" file here:		    Also you can:
	echo 					 1^) short - shortcut for "SendTo" 
	echo 					 2^) del - delete shortcut from "SendTo" 
	echo 					 3^) path - change the path to "steamapps" 
	echo 					 4^) remove - delete the path to "steamapps"
	echo 					 5^) exit - ...no comments 
	set /p exedirect=">>>"
)

if %exedirect% == short del /f /q %appdata%\Microsoft\Windows\SendTo\NeoSteamHack.lnk && set message=Link succesful created. && call :messagebox && goto short
if %exedirect% == del del /f /q %appdata%\Microsoft\Windows\SendTo\NeoSteamHack.lnk && set message=Link succesful deleted. && call :messagebox && goto again
if %exedirect% == path goto newpath
if %exedirect% == remove goto remove
if %exedirect% == exit exit

set bruh=%exedirect%
set timer=16
:timer
	set /a timer=%timer%-1
		set bruh="%bruh:*\=%"
	if %timer% NEQ 0 goto timer
set bruh=%bruh:"=%

call set workdirect=%%exedirect:%bruh%=%% || set message=Idk, Bug. && call :messagebox && exit
set workdirect="%workdirect:"=%"
set exedirect="%exedirect:"=%"
echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut.vbs
echo sLinkFile = "%steamdirect%\common\Spacewar\game_link.lnk" >> shortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut.vbs
echo oLink.TargetPath = %exedirect% >> shortcut.vbs
echo oLink.WorkingDirectory = %workdirect:~0,-2%" >> shortcut.vbs
echo oLink.Save >> shortcut.vbs
cscript /nologo shortcut.vbs
del shortcut.vbs

xcopy "SteamworksExample.exe" "%steamdirect%\common\Spacewar\" /y>nul
set message=Now u can start Spacewar. && call :messagebox
exit
:a
set message=Install Spacewar and try again. && call :messagebox
:request
cls
echo Do u wanna install Spacewar? y\n	    Also you can:
echo 					 1) path - change the path to steamapps
echo 					 2) remove - delete the path to steamapps
echo 					 3) y - install SpaceWar
echo 					 4) n - exit
set /p choice=">>>"
if %choice% == path goto newpath
if %choice% == remove goto remove
if %choice% == y goto b
if not %choice% == n goto request
exit
:b
start steam://install/480
exit
:short
	echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut2.vbs
	echo sLinkFile = "%appdata%\Microsoft\Windows\SendTo\NeoSteamHack.lnk" >> shortcut2.vbs
	echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut2.vbs
	echo oLink.TargetPath = "%~dp0NeoSteamHack.exe" >> shortcut2.vbs
	echo oLink.WorkingDirectory = "%~dp0" >> shortcut2.vbs
	echo oLink.Save >> shortcut2.vbs
	cscript /nologo shortcut2.vbs
	del shortcut2.vbs
goto again
:newpath
cls
echo Insert your SteamApps path:
set /p newpath=">>>"
echo %newpath% > %appdata%\directory.txt
set message=New path succesful added. && call :messagebox
goto again
:remove
cls
del /f /q %appdata%\directory.txt
set message=The path succesful deleted. && call :messagebox
timeout /t 1 /nobreak>nul
goto again

:messagebox
echo msgbox"%message%">message.vbs
start message.vbs
timeout /t 1 /nobreak>nul
del /f message.vbs
exit /b
