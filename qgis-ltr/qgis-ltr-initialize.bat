REM Batch-Datei for initialize QGIS LTR
echo on
chcp 1252

REM Change directory to start the command "nircmd"
cd /D Q:\OSGeo4W64\bin

REM Text for the desktop shortcut.
set "QGIS_TEXT=QGIS LTR 2.18 (serverbasiert, OSGeo4W)"
set "OSGEO4W_ROOT=Q:\OSGeo4W64"

REM Create shortcut in the programs group for all user (public)
if not exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\QGIS\%QGIS_TEXT%.lnk" (
   nircmd shortcut """%OSGEO4W_ROOT%""\bin\qgis-ltr-start.bat" "%ProgramData%\Microsoft\Windows\Start Menu\Programs\QGIS" "%QGIS_TEXT%" "" """%OSGEO4W_ROOT%""\icons\QGIS.ico" "0" "min" """%OSGEO4W_ROOT%""\bin" ""
   )

if not exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\QGIS\OSGeo4W Shell.lnk" (
   nircmd shortcut """%OSGEO4W_ROOT%""\OSGeo4W.bat" "%ProgramData%\Microsoft\Windows\Start Menu\Programs\QGIS" "OSGeo4W Shell" "" """%OSGEO4W_ROOT%""\OSGeo4W.ico" "" "" """\" ""
   )

REM Create shortcut on desktop for all user (public)
if not exist "%PUBLIC%\Desktop\%QGIS_TEXT%.lnk" (
   nircmd shortcut """%OSGEO4W_ROOT%""\bin\qgis-ltr-start.bat" "%PUBLIC%\Desktop" "%QGIS_TEXT%" "" """%OSGEO4W_ROOT%""\icons\QGIS.ico" "0" "min" """%OSGEO4W_ROOT%""\bin" ""
   )

REM Create file and icon associations 
start/wait regedit -s "%OSGEO4W_ROOT%\bin\qgis.ltr.reg"

assoc .qgs=QGIS Project
assoc .qlr=QGIS Layer Definition
assoc .qml=QGIS Layer Settings
assoc .qpt=QGIS Composer Template

REM Install Symbol-Fonts 
REM copy /Y \\<Netzwerkpfad zur Font-Datei>\<Name der Fontdatei>.ttf C:\Windows\Fonts\<Name der Fontdatei>.ttf

REM Registry Symbol-Fonts
REM start /wait regedit -s "%OSGEO4W_ROOT%\bin\<Name der Reg-Datei>.reg"

exit /b
