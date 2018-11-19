echo off
chcp 1252

REM Text for the desktop shortcut. Change for new versions
set "QGIS_TEXT=QGIS LTR 2.18 (serverbasiert, OSGeo4W)"

REM Running mode: if parameter 1 is "RUN" or "run" then execute the "run" part of this script, otherwise do the "prepare" part
if #%1==#RUN goto run
if #%1==#run goto run

REM ==================================================================
REM PREPARE part of the script....
REM ==================================================================

REM Disregard permanent value for user-dir pointer and set it to template directory
set "QGIS_UDIR=%OSGEO4W_ROOT%\qgis_ltr_template"

REM Patch QGIS-EPSG-DB for German BeTA-2007-Transformation (GK2/3/4/5->UTM32/33)
"%OSGEO4W_ROOT%"\bin\sqlite3.exe "%OSGEO4W_ROOT%"\apps\qgis-ltr\resources\srs.db < "%OSGEO4W_ROOT%"\apps\qgis-ltr\resources\BETA2007.sql

exit /b

:run
REM ==================================================================
REM RUN part of the script....
REM ==================================================================

REM If the user directory exists ==> Start Qgis normally
if exist %QGIS_UDIR% goto start_qgis

REM ==================================================================
REM First time use of QGIS on a user-pc ==> Do installation of user-directory....
REM ==================================================================

echo Installing directory for user settings........

REM Prepare variables for path replacement...
set "QGIS_PDIR_ORG=%OSGEO4W_ROOT%"
set "QGIS_UDIR_ORG=%USERPROFILE%"

set "PN=%OSGEO4W_ROOT:"=%"
set "PN=%PN:\=/%"

set "PO=%QGIS_PDIR_ORG:"=%"
set "PO=%PO:\=/%"

set "QO=%QGIS_UDIR_ORG:"=%"
set "QO=%QO:\=/%"

set "QN=%USERPROFILE:\=/%"

set "UN=%QGIS_UDIR:"=%"
set "UN=%UN:\=/%"

set "UO=%PO%/qgis_ltr_template"

REM Copy user dir template to the final path on user-pc 
xcopy "%PN%/qgis_ltr_template" "%UN%" /e /i

REM Replace original paths in the settings ini-file to the correct path on user pc 
copy "%UN%\QGIS\QGIS2.ini" "%UN%\QGIS\QGIS2.org"
minised "s#%UO%#%UN%#g;s#%UO:/=\\\\%#%UN:/=\\\\%#g;s#%PO%#%PN%#g;s#%PO:/=\\\\%#%PN:/=\\\\%#g;s#%QO%#%QN%#g;s#%QO:/=\\\\%#%QN:/=\\\\%#g" "%UN%\QGIS\QGIS2.org" > "%UN%\QGIS\QGIS2.ini"

if not exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\QGIS\%QGIS_TEXT%.lnk" (
   if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\QGIS\%QGIS_TEXT%.lnk" (
      nircmd shortcut """%OSGEO4W_ROOT%""\bin\qgis-ltr-start.bat" "~$folder.programs$\QGIS" "%QGIS_TEXT%" "" """%OSGEO4W_ROOT%""\icons\QGIS.ico" "0" "min" """%OSGEO4W_ROOT%""\bin" ""
      )
    )

if not exist "%ProgramData%\Microsoft\Windows\Start Menu\Programs\QGIS\OSGeo4W Shell.lnk" (
   if not exist "%USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\QGIS\OSGeo4W Shell.lnk" (
      nircmd shortcut """%OSGEO4W_ROOT%""\OSGeo4W.bat" "~$folder.programs$\QGIS" "OSGeo4W Shell" "" """%OSGEO4W_ROOT%""\OSGeo4W.ico" "" "" """\" ""
      )
    )

REM Create shortcut on desktop for user
if not exist "%PUBLIC%\Desktop\%QGIS_TEXT%.lnk" (
   if not exist "%USERPROFILE%\Desktop\%QGIS_TEXT%.lnk" (
      nircmd shortcut """%OSGEO4W_ROOT%""\bin\qgis-ltr-start.bat" "~$folder.desktop$" "%QGIS_TEXT%" "" """%OSGEO4W_ROOT%""\icons\QGIS.ico" "0" "min" """%OSGEO4W_ROOT%""\bin" ""
      )
   )

:start_qgis
exit /b
