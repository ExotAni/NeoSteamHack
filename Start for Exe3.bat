echo off
chcp 1251
title SteamHack
set kostil=%cd%
cls
echo Initialization...

:again
if exist %appdata%\directory.txt set /p check=<%appdata%\directory.txt
if exist %check% goto skip

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
if not exist "%steamdirect%\common\Spacewar" goto a

cls
if not "%~1"=="" (
	set exedirect="%~1"
) else (
	echo Put your game ".exe" file here:
	set /p exedirect=">>>"
)

if %exedirect% == short del /f /q %appdata%\Microsoft\Windows\SendTo\SteamHack.lnk && cls && echo msgbox"Link succesful created." > warning2.vbs && start warning2.vbs && timeout /t 1 /nobreak>nul && del /f /q warning2.vbs && goto short
if %exedirect% == del del /f /q %appdata%\Microsoft\Windows\SendTo\SteamHack.lnk && cls && echo msgbox"Link succesful deleted." > warning2.vbs && start warning2.vbs && timeout /t 1 /nobreak>nul && del /f /q warning2.vbs && goto again
if %exedirect% == path goto newpath
if %exedirect% == exit exit

set bruh=%exedirect%
set timer=16
:timer
	set /a timer=%timer%-1
		set bruh=%bruh:*\=%
	if %timer% EQU 0 goto end
goto timer

:end
call set workdirect=%%exedirect:%bruh%=%% || echo msgbox"The game title contains a prohibited symbol. Bug." > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs && exit
set workdirect=%workdirect:"=% || echo msgbox"The game title contains a prohibited symbol. Bug." > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs && exit
set exedirect=%exedirect:"=% || echo msgbox"The game title contains a prohibited symbol. Bug." > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs && exit
echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut.vbs
echo sLinkFile = "%steamdirect%\common\Spacewar\SteamworksExample.lnk" >> shortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut.vbs
echo oLink.TargetPath = "%exedirect%" >> shortcut.vbs
echo oLink.WorkingDirectory = "%workdirect%" >> shortcut.vbs
echo oLink.Save >> shortcut.vbs
cscript /nologo shortcut.vbs
del shortcut.vbs

echo run "%steamdirect%\common\Spacewar\SteamworksExample.lnk" > SteamworksExample.ahk
Ahk2Exe.exe /in "SteamworksExample.ahk" || echo msgbox"Maybe u haven't the Compiler, maybe incorrect path, idk. Think about it." > warning3.vbs && start warning3.vbs && timeout /t 1 /nobreak>nul && del /f /q warning3.vbs && del /f /q "SteamworksExample.ahk" && exit
xcopy "SteamworksExample.exe" "%steamdirect%\common\Spacewar\" /y
if exist "SteamworksExample.exe" del /f /q "SteamworksExample.exe"
if exist "SteamworksExample.ahk" del /f /q "SteamworksExample.ahk"
echo msgbox"Now u can start Spacewar." > warning4.vbs && start warning4.vbs && timeout /t 1 /nobreak>nul && del /f /q warning4.vbs
exit
:a
echo msgbox"Install Spacewar and try again." > warning5.vbs && start warning5.vbs && timeout /t 1 /nobreak>nul && del /f /q warning5.vbs
:request
cls
echo Do u wanna install Spacewar? y\n
set /p choice=">>>"
if %choice% == y goto b
if not %choice% == n goto request
exit
:b
start SpacewarInstall.exe
exit
:short
	echo Set oWS = WScript.CreateObject("WScript.Shell") > shortcut2.vbs
	echo sLinkFile = "%appdata%\Microsoft\Windows\SendTo\SteamHack.lnk" >> shortcut2.vbs
	echo Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut2.vbs
	echo oLink.TargetPath = "%kostil%\SteamHack3.exe" >> shortcut2.vbs
	echo oLink.WorkingDirectory = "%kostil%" >> shortcut2.vbs
	echo oLink.Save >> shortcut2.vbs
	cscript /nologo shortcut2.vbs
	del shortcut2.vbs
goto again
:newpath
cls
echo Insert your SteamApps path:
set /p newpath=">>>"
echo %newpath% > %appdata%\directory.txt
echo msgbox"New path succesful added." > warning2.vbs && start warning2.vbs && timeout /t 1 /nobreak>nul && del /f /q warning2.vbs
goto again