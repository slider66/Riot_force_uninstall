@echo off
setlocal enabledelayedexpansion
color 0A
title Desinstalacion Completa de Riot Games

:: Mantener ventana abierta y auto-elevar privilegios
if "%1" neq "ELEVATED" (
    powershell -Command "Start-Process '%~f0' -ArgumentList 'ELEVATED' -Verb RunAs"
    exit /b
)

echo ========================================
echo   DESINSTALADOR COMPLETO RIOT GAMES
echo ========================================
echo.
echo Este script eliminara:
echo - Riot Client
echo - Riot Vanguard
echo - Valorant
echo - League of Legends
echo - Todos los archivos y registros relacionados
echo.
echo ADVERTENCIA: Esta accion es IRREVERSIBLE
echo.
echo Presiona cualquier tecla para continuar o cierra esta ventana para cancelar...
pause >nul

cls
echo.
echo Iniciando proceso de desinstalacion...

echo.
echo [1/7] Creando Punto de Restauracion del Sistema...
echo ========================================
echo.
echo Esto puede tardar unos momentos...
powershell -Command "Checkpoint-Computer -Description 'Antes de Desinstalar Riot' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
if %errorLevel% equ 0 (
    echo [OK] Punto de restauracion creado exitosamente
) else (
    echo [AVISO] No se pudo crear el punto de restauracion.
    echo Asegurate de que la Proteccion del Sistema este habilitada.
    echo Continuando con la desinstalacion...
)
timeout /t 2 /nobreak >nul

echo.
echo [2/7] Deteniendo procesos de Riot Games...
echo ========================================

:: Detener todos los procesos relacionados
set "procesos_detenidos=0"
taskkill /F /IM "RiotClientServices.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "RiotClientUx.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "RiotClientCrashHandler.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "Valorant.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "VALORANT-Win64-Shipping.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "LeagueClient.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "LeagueClientUx.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "vgtray.exe" >nul 2>&1 && set /a procesos_detenidos+=1
taskkill /F /IM "vgc.exe" >nul 2>&1 && set /a procesos_detenidos+=1

echo [OK] %procesos_detenidos% procesos detenidos
timeout /t 2 /nobreak >nul

echo.
echo [3/7] Deteniendo y eliminando servicios...
echo ========================================

:: Detener y eliminar servicios de Vanguard
sc stop vgc >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Servicio vgc detenido) else (echo [INFO] Servicio vgc no estaba activo)
sc stop vgk >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Servicio vgk detenido) else (echo [INFO] Servicio vgk no estaba activo)
sc delete vgc >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Servicio vgc eliminado) else (echo [INFO] Servicio vgc no encontrado)
sc delete vgk >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Servicio vgk eliminado) else (echo [INFO] Servicio vgk no encontrado)

timeout /t 2 /nobreak >nul

echo.
echo [4/7] Desinstalando aplicaciones...
echo ========================================

:: Buscar y ejecutar desinstaladores oficiales
if exist "C:\Program Files\Riot Vanguard\uninstall.exe" (
    echo [EJECUTANDO] Desinstalador de Riot Vanguard...
    "C:\Program Files\Riot Vanguard\uninstall.exe" /S
    timeout /t 3 /nobreak >nul
    echo [OK] Desinstalador de Vanguard ejecutado
) else (
    echo [INFO] Desinstalador de Vanguard no encontrado
)

if exist "C:\Riot Games\Riot Client\RiotClientServices.exe" (
    echo [EJECUTANDO] Desinstalador de Riot Client...
    "C:\Riot Games\Riot Client\RiotClientServices.exe" --uninstall
    timeout /t 3 /nobreak >nul
    echo [OK] Desinstalador de Riot Client ejecutado
) else (
    echo [INFO] Desinstalador de Riot Client no encontrado
)

timeout /t 2 /nobreak >nul

echo.
echo [5/7] Eliminando carpetas de instalacion...
echo ========================================

:: Eliminar carpetas principales
if exist "C:\Riot Games\" (
    echo [ELIMINANDO] C:\Riot Games\...
    rd /s /q "C:\Riot Games\" 2>nul
    if not exist "C:\Riot Games\" (echo [OK] Carpeta eliminada) else (echo [AVISO] Algunos archivos no pudieron eliminarse)
) else (
    echo [INFO] C:\Riot Games\ no existe
)

if exist "C:\Program Files\Riot Vanguard\" (
    echo [ELIMINANDO] C:\Program Files\Riot Vanguard\...
    rd /s /q "C:\Program Files\Riot Vanguard\" 2>nul
    if not exist "C:\Program Files\Riot Vanguard\" (echo [OK] Carpeta eliminada) else (echo [AVISO] Algunos archivos no pudieron eliminarse)
) else (
    echo [INFO] Riot Vanguard (Program Files) no existe
)

if exist "C:\Program Files (x86)\Riot Vanguard\" (
    echo [ELIMINANDO] C:\Program Files (x86)\Riot Vanguard\...
    rd /s /q "C:\Program Files (x86)\Riot Vanguard\" 2>nul
    if not exist "C:\Program Files (x86)\Riot Vanguard\" (echo [OK] Carpeta eliminada) else (echo [AVISO] Algunos archivos no pudieron eliminarse)
) else (
    echo [INFO] Riot Vanguard (Program Files x86) no existe
)

:: Eliminar datos de usuario
if exist "%LOCALAPPDATA%\Riot Games\" (
    echo [ELIMINANDO] Datos locales de usuario...
    rd /s /q "%LOCALAPPDATA%\Riot Games\" 2>nul
    if not exist "%LOCALAPPDATA%\Riot Games\" (echo [OK] Datos locales eliminados) else (echo [AVISO] Algunos archivos no pudieron eliminarse)
) else (
    echo [INFO] No hay datos locales
)

if exist "%APPDATA%\Riot Games\" (
    echo [ELIMINANDO] Configuracion de usuario...
    rd /s /q "%APPDATA%\Riot Games\" 2>nul
    if not exist "%APPDATA%\Riot Games\" (echo [OK] Configuracion eliminada) else (echo [AVISO] Algunos archivos no pudieron eliminarse)
) else (
    echo [INFO] No hay datos de configuracion
)

if exist "%PROGRAMDATA%\Riot Games\" (
    echo [ELIMINANDO] Datos del sistema...
    rd /s /q "%PROGRAMDATA%\Riot Games\" 2>nul
    if not exist "%PROGRAMDATA%\Riot Games\" (echo [OK] Datos del sistema eliminados) else (echo [AVISO] Algunos archivos no pudieron eliminarse)
) else (
    echo [INFO] No hay datos del sistema
)

:: Eliminar carpetas temporales
if exist "%TEMP%\Riot Games\" (
    echo [ELIMINANDO] Archivos temporales...
    rd /s /q "%TEMP%\Riot Games\" 2>nul
    echo [OK] Temporales procesados
)

timeout /t 2 /nobreak >nul

echo.
echo [6/7] Limpiando registro de Windows...
echo ========================================

:: Eliminar claves del registro
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Riot Games" /f >nul 2>&1
if %errorLevel% equ 0 (echo [OK] HKLM\SOFTWARE\Riot Games eliminado) else (echo [INFO] Clave no encontrada)

reg delete "HKEY_CURRENT_USER\Software\Riot Games" /f >nul 2>&1
if %errorLevel% equ 0 (echo [OK] HKCU\Software\Riot Games eliminado) else (echo [INFO] Clave no encontrada)

reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgc" /f >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Servicio vgc del registro eliminado) else (echo [INFO] Clave no encontrada)

reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgk" /f >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Servicio vgk del registro eliminado) else (echo [INFO] Clave no encontrada)

reg delete "HKEY_CLASSES_ROOT\riotclient" /f >nul 2>&1
if %errorLevel% equ 0 (echo [OK] Protocolo riotclient eliminado) else (echo [INFO] Protocolo no encontrado)

echo [BUSCANDO] Entradas de desinstalacion...
:: Buscar y eliminar entradas de desinstalacion
set "entradas_eliminadas=0"
for /f "tokens=*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Riot" 2^>nul ^| findstr "HKEY"') do (
    reg delete "%%a" /f >nul 2>&1
    set /a entradas_eliminadas+=1
)

for /f "tokens=*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Riot" 2^>nul ^| findstr "HKEY"') do (
    reg delete "%%a" /f >nul 2>&1
    set /a entradas_eliminadas+=1
)

echo [OK] %entradas_eliminadas% entradas de desinstalacion eliminadas

timeout /t 2 /nobreak >nul

echo.
echo [7/7] Limpieza final...
echo ========================================

:: Eliminar accesos directos
set "accesos_eliminados=0"
del "%PUBLIC%\Desktop\Valorant.lnk" >nul 2>&1 && set /a accesos_eliminados+=1
del "%PUBLIC%\Desktop\Riot Client.lnk" >nul 2>&1 && set /a accesos_eliminados+=1
del "%USERPROFILE%\Desktop\Valorant.lnk" >nul 2>&1 && set /a accesos_eliminados+=1
del "%USERPROFILE%\Desktop\Riot Client.lnk" >nul 2>&1 && set /a accesos_eliminados+=1
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Riot Games\*.lnk" >nul 2>&1
rd /s /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Riot Games\" >nul 2>&1

echo [OK] %accesos_eliminados% accesos directos eliminados
echo [EJECUTANDO] Limpieza de cache DNS...

:: Limpiar cache de DNS
ipconfig /flushdns >nul 2>&1
echo [OK] Cache DNS limpiado

timeout /t 2 /nobreak >nul

echo.
echo ========================================
echo   DESINSTALACION COMPLETADA
echo ========================================
echo.
echo Todos los componentes de Riot Games han sido eliminados.
echo.
echo IMPORTANTE: Se recomienda ENCARECIDAMENTE reiniciar el equipo
echo para completar la eliminacion de drivers y servicios del kernel.
echo.
echo Deseas reiniciar ahora? (S/N)
set /p reiniciar=

if /i "%reiniciar%"=="S" (
    echo.
    echo Reiniciando el sistema en 10 segundos...
    echo Presiona Ctrl+C para cancelar
    shutdown /r /t 10
) else (
    echo.
    echo Por favor, reinicia manualmente tu equipo cuando sea posible.
)

echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul