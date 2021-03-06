@echo off
call "%~dp0\o4w_env.bat"
call "%OSGEO4W_ROOT%\apps\grass\grass-7.4.2\etc\env.bat"
call qt5_env.bat
call py3_env.bat
@echo off
path %OSGEO4W_ROOT%\apps\qgis-dev\bin;%OSGEO4W_ROOT%\apps\grass\grass-7.4.2\lib;%OSGEO4W_ROOT%\apps\grass\grass-7.4.2\bin;%PATH%
set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/qgis-dev
set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\qgis-dev\qtplugins;%OSGEO4W_ROOT%\apps\qt5\plugins


REM start "QGIS" /B "%OSGEO4W_ROOT%\bin\qgis-bin.exe" %*


REM Version wird aus Pfad ausgelesen ("P:\qgis\v3\..." -> "v3")
REM set "QGIS_VER=%OSGEO4W_ROOT%
REM for %%f in (%QGIS_VER%) do set QGIS_VER=%%~nxf

set "QGIS_UDIR=%USERPROFILE%\AppData\Roaming\QGIS\OSGeo4W\qgis-dev"

REM Modus setzen (RUN|) [leer lassen für Konfigurationsmodus; "RUN" für Nutzerbetrieb]
set "QGIS_MODE=RUN"
call "%OSGEO4W_ROOT%\bin\qgis-dev-prepare.bat" %QGIS_MODE%

REM start "QGIS" /B "%OSGEO4W_ROOT%\bin\qgis-dev-bin-g7.exe" %*
start "QGIS" /B "%OSGEO4W_ROOT%\bin\qgis-dev-bin-g7.exe" --profiles-path "%QGIS_UDIR%" %*

