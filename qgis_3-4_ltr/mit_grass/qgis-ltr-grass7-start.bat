REM QGIS 3.4 LTR (mit GRASS 7) Startdatei für Nutzerbetrieb auf Clients 
REM basiert auf qgis-ltr-start-prepare.bat mit "QGIS_MODE=RUN"

@echo off
call "%~dp0\o4w_env.bat"
call "%OSGEO4W_ROOT%\apps\grass\grass76\etc\env.bat"
call qt5_env.bat
call py3_env.bat
@echo off
path %OSGEO4W_ROOT%\apps\qgis-ltr\bin;%OSGEO4W_ROOT%\apps\grass\grass76\lib;%OSGEO4W_ROOT%\apps\grass\grass76\bin;%PATH%
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/qgis-ltr
set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\qgis-ltr\qtplugins;%OSGEO4W_ROOT%\apps\qt5\plugins

set "QGIS_UDIR=%USERPROFILE%\AppData\Roaming\QGIS\OSGeo4W\qgis-ltr"

REM Modus setzen (RUN|) [leer lassen für Konfigurationsmodus; "RUN" für Nutzerbetrieb]
set "QGIS_MODE=RUN"
call "%OSGEO4W_ROOT%\bin\qgis-ltr-prepare.bat" %QGIS_MODE%

start "QGIS" /B "%OSGEO4W_ROOT%\bin\qgis-ltr-bin-g7.exe" --profiles-path "%QGIS_UDIR%" %*
