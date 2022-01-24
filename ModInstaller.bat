@echo off
echo     ______     ______       __  ____  _ __  
echo    / __/ /_ __/ _/ _/_ __  / / / / /_(_) /__
echo   / _// / // / _/ _/ // / / /_/ / __/ / (_-^<
echo  /_/ /_/\_,_/_//_/ \_, /  \____/\__/_/_/___/
echo                   /___/                     
echo.
echo You are Running Mod Installer Batch Edition v0.1
echo      Hosted on Github.com/MrFlufficans
echo.
echo  Warning, This Batch Script Does not Autoupdate
echo.  
echo  I suggest the Powershell version if you want to
echo    Keep up to date with the Latest Features
echo.
timeout /t 3 /nobreak > NUL
echo Locating Folders
echo Found Folders:
echo.
dir /B /A:-HD
echo.
echo Please Type the Mod Folder
set /p ModFolder=
xcopy "%ModFolder%" "%localappdata%\KillHouseGames\DoorKickers2\mods\%ModFolder%\" /E 
echo Install Complete.
timeout /t 1 /nobreak > NUL
echo.
echo Press Anything to Close this dialog.
pause >nul