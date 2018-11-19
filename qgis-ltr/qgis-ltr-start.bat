@echo off
call "%~dp0\o4w_env.bat"
@echo off
path %OSGEO4W_ROOT%\apps\qgis-ltr\bin;%PATH%
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/qgis-ltr
set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\qgis-ltr\qtplugins;%OSGEO4W_ROOT%\apps\qt4\plugins

REM Version wird aus Pfad ausgelesen ("P:\qgis\stable\..." -> "stable")
REM set "QGIS_VER=%OSGEO4W_ROOT%
REM for %%f in (%QGIS_VER%) do set QGIS_VER=%%~nxf

REM set "QGIS_UDIR=%USERPROFILE%\.qgis_%QGIS_VER%"
set "QGIS_UDIR=%USERPROFILE%\AppData\Roaming\QGIS\OSGeo4W\qgis-ltr"

REM Modus setzen (RUN|) [leer lassen für Konfigurationsmodus; "RUN" für Nutzerbetrieb]
set "QGIS_MODE=RUN"
REM set "QGIS_MODE="
call "%OSGEO4W_ROOT%\bin\qgis-ltr-prepare.bat" %QGIS_MODE%

start "QGIS" /B "%OSGEO4W_ROOT%"\bin\qgis-ltr-bin.exe --configpath "%QGIS_UDIR%" %*