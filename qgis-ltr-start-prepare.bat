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

    REM Benutzerverzeichnis vorgeben
    set "QGIS_UDIR=%USERPROFILE%\AppData\Roaming\QGIS\OSGeo4W\qgis-ltr"

    REM Modus setzen (RUN|) [leer lassen für Konfigurationsmodus (=Prepare-Phase); "RUN" für Nutzerbetrieb]
    set "QGIS_MODE="
    call "%OSGEO4W_ROOT%\bin\qgis-ltr-prepare.bat" %QGIS_MODE%

    REM QGIS mit Parameter starten
    start "QGIS" /B "%OSGEO4W_ROOT%"\bin\qgis-ltr-bin.exe --configpath "%QGIS_UDIR%" %*
