@echo off
:NAMEID
echo What would you like to name this config?
set /p id=
if "x%id%"=="x" echo Please don't leave this blank. & GOTO NAMEID

:NAMEUSER
echo What is your computer's user's name?
set /p user=
if "x%user%"=="x" echo Please don't leave this blank. & GOTO NAMEUSER


set LocalPictureFolderName=%id%CloudPapers
set RcloneBatchAutoupdaterName=%id%CloudPapers.bat


rem DOWNLOAD THE FILE FROM THE INTERNET

set link= https://downloads.rclone.org/rclone-current-windows-amd64.zip

echo.
echo.
echo.
echo I'll try to find Rclone and download it for you.
echo It is currently downloading from this link: %link%
echo.
echo.
echo After it downloads your browser should open.

%__APPDIR__%curl.exe -s -o "C:\Users\%user%\Documents\rclone.zip" %link%




rem UNZIP THE FILE [I didn't write this]
Call :UnZipFile "C:\Users\%user%\Documents\rclone" "C:\Users\%user%\Documents\rclone.zip"
exit /b

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%




rem FIND THE FILE, RIGHT WHERE I PUT IT
for /d /r "C:\Users\%user%\Documents\rclone\" %%i in (rclone*) do @if exist "%%i" set path=%%i
cd %path%



rem CREATE THE CONFIGURATION IN RCLONE
rclone config create %id% drive scope=drive config_is_local=true config_change_team_drive=false >nul 2>&1
cls
echo Rclone downloads from this link: %link%
echo id = %id%
echo user = %user%
echo.
echo We've configured rclone for you. Now we need to get the pictures to your computer.


rem ADD PICTURES FROM ONLINE INTO CLOUDPAPERS FOLDER
echo.
echo.
echo What is the name of your google drive folder?
echo (The testing one is "FolderforTestingRclone")
set /p gfold=

if "x%gfold%"=="x" (echo Please don't leave this blank. & GOTO NAMEGDRIVEFOLDER) else (GOTO CONTINUEPROG)

:NAMEGDRIVEFOLDER
set gfold=FolderforTestingRclone
echo What is the name of your google drive folder?
echo (The DEFAULT one is "FolderforTestingRclone")
set /p gfold=

:CONTINUEPROG
rclone copy %id%:%gfold% C:\Users\%user%\Pictures\%LocalPictureFolderName%


rem CHECK
echo.
echo Done! please check your pictures folder "%LocalPictureFolderName%". I'll try to open it for you.
start "" "C:\Users\%user%\Pictures\%LocalPictureFolderName%"
echo.



rem CREATE BAT FILE ON DESKTOP
cd C:\Users\%user%\Desktop
echo ^@echo off > %RcloneBatchAutoupdaterName%
echo cd "%path%" >> %RcloneBatchAutoupdaterName%
echo cmd /c "rclone copy %id%:%gfold% C:\Users\%user%\Pictures\%LocalPictureFolderName%" >> %RcloneBatchAutoupdaterName%
echo.
echo Your desktop now has a .bat file named "%RcloneBatchAutoupdaterName%".
echo Clicking it will update the pictures folder (Pictures\%LocalPictureFolderName%)
echo.



rem AUTOMATIC UPDATE MAKER.
rem Makes the bat file to automatically update and shoves it in the shell:startup folder in file explorer.
rem C:\Users\Jude\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup

echo One more thing!

:AUTOUPDATEWANT
echo Would you like to add automatic updates every time you start your computer? (y/n)
set /p autoup=

if "%autoup%"=="y" (GOTO YESAUTOWANT) else if "%autoup%" == "n" (GOTO NOAUTONOWANT) else (echo Please answer with "y" or "n" & GOTO AUTOUPDATEWANT)

:YESAUTOWANT
echo. >> %RcloneBatchAutoupdaterName%
echo. >> %RcloneBatchAutoupdaterName%
echo rem If you type shell:startup into the address bar on file explorer you can find the bat file and delete it. >> %RcloneBatchAutoupdaterName%
copy "C:\Users\Jude\Desktop\%RcloneBatchAutoupdaterName%" "C:\Users\Jude\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
echo.
start "" "C:\Users\Jude\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
echo.
echo.
echo If you type "shell:startup" into the address bar on file explorer,
echo You can find the same .bat file.
echo.
echo I also attempted to open the folder so you can see it.
echo.
pause
GOTO ENDPROGRAM

:NOAUTONOWANT
echo hi

:ENDPROGRAM
cls
echo Rclone downloads from this link: %link%
echo id = %id%
echo user = %user%

echo.
echo Thank you!
echo There is a folder in your documents called "rclone".
echo Don't delete it (unless you want to stop using this program)!
echo.
echo.
echo Don't forget to set the %LocalPictureFolderName% folder as your wallpaper in Windows settings!
echo.
echo.
echo That's all! If you have any questions contact me.
pause
exit







