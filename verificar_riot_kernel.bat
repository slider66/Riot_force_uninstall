@echo off
setlocal enabledelayedexpansion
color 0B
title Verificador de Drivers Riot en Kernel

:: Auto-elevar privilegios
if "%1" neq "ELEVATED" (
    powershell -Command "Start-Process '%~f0' -ArgumentList 'ELEVATED' -Verb RunAs"
    exit /b
)

echo ========================================
echo   VERIFICADOR DE DRIVERS RIOT
echo   Comprobando acceso al Kernel
echo ========================================
echo.
echo Fecha: %date% %time%
echo.

:: Variable para rastrear si se encuentra algo
set "encontrado=0"

echo [1/5] Verificando servicios del sistema...
echo ========================================
echo.

:: Verificar servicios de Vanguard
sc query vgc >nul 2>&1
if %errorLevel% equ 0 (
    echo [!ALERTA!] Servicio VGC encontrado y activo
    sc query vgc
    set "encontrado=1"
) else (
    echo [OK] Servicio VGC no encontrado
)

sc query vgk >nul 2>&1
if %errorLevel% equ 0 (
    echo [!ALERTA!] Servicio VGK encontrado y activo
    sc query vgk
    set "encontrado=1"
) else (
    echo [OK] Servicio VGK no encontrado
)

timeout /t 2 /nobreak >nul

echo.
echo [2/5] Verificando drivers del kernel...
echo ========================================
echo.

:: Verificar drivers cargados en memoria
driverquery /v | findstr /i "vgk vgc riot vanguard" >nul 2>&1
if %errorLevel% equ 0 (
    echo [!ALERTA!] Drivers de Riot detectados en memoria:
    echo.
    driverquery /v | findstr /i "vgk vgc riot vanguard"
    set "encontrado=1"
) else (
    echo [OK] No hay drivers de Riot cargados en memoria
)

timeout /t 2 /nobreak >nul

echo.
echo [3/5] Verificando archivos de drivers...
echo ========================================
echo.

:: Verificar archivos .sys en System32/drivers
if exist "%SystemRoot%\System32\drivers\vgk.sys" (
    echo [!ALERTA!] Driver vgk.sys encontrado en:
    echo %SystemRoot%\System32\drivers\vgk.sys
    dir "%SystemRoot%\System32\drivers\vgk.sys"
    set "encontrado=1"
) else (
    echo [OK] vgk.sys no encontrado
)

if exist "%SystemRoot%\System32\drivers\vgc.sys" (
    echo [!ALERTA!] Driver vgc.sys encontrado en:
    echo %SystemRoot%\System32\drivers\vgc.sys
    dir "%SystemRoot%\System32\drivers\vgc.sys"
    set "encontrado=1"
) else (
    echo [OK] vgc.sys no encontrado
)

:: Buscar cualquier otro archivo .sys relacionado
echo.
echo Buscando otros drivers .sys de Riot...
dir "%SystemRoot%\System32\drivers\*riot*.sys" 2>nul
if %errorLevel% equ 0 (
    set "encontrado=1"
) else (
    echo [OK] No se encontraron otros drivers .sys de Riot
)

timeout /t 2 /nobreak >nul

echo.
echo [4/5] Verificando registro del sistema...
echo ========================================
echo.

:: Verificar entradas en el registro de servicios
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgc" >nul 2>&1
if %errorLevel% equ 0 (
    echo [!ALERTA!] Entrada de registro del servicio VGC encontrada
    reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgc"
    set "encontrado=1"
) else (
    echo [OK] No hay entrada de registro para VGC
)

reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgk" >nul 2>&1
if %errorLevel% equ 0 (
    echo [!ALERTA!] Entrada de registro del servicio VGK encontrada
    reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgk"
    set "encontrado=1"
) else (
    echo [OK] No hay entrada de registro para VGK
)

timeout /t 2 /nobreak >nul

echo.
echo [5/5] Verificando procesos activos...
echo ========================================
echo.

:: Verificar procesos relacionados con Vanguard
tasklist | findstr /i "vgc vgtray vanguard riot" >nul 2>&1
if %errorLevel% equ 0 (
    echo [!ALERTA!] Procesos de Riot/Vanguard detectados:
    echo.
    tasklist | findstr /i "vgc vgtray vanguard riot"
    set "encontrado=1"
) else (
    echo [OK] No hay procesos de Riot/Vanguard en ejecucion
)

timeout /t 2 /nobreak >nul

echo.
echo ========================================
echo   RESUMEN DEL ANALISIS
echo ========================================
echo.

if %encontrado% equ 0 (
    echo [SISTEMA LIMPIO]
    echo.
    echo No se detectaron componentes de Riot Vanguard con acceso al kernel.
    echo Tu sistema esta completamente limpio de drivers de Riot Games.
    echo.
    color 0A
) else (
    echo [ATENCION REQUERIDA]
    echo.
    echo Se detectaron componentes de Riot Vanguard aun presentes.
    echo.
    echo RECOMENDACIONES:
    echo 1. Reinicia el equipo si aun no lo has hecho
    echo 2. Ejecuta el script de desinstalacion nuevamente
    echo 3. Si persisten, elimina manualmente los archivos detectados
    echo.
    color 0C
)

echo Fecha de analisis: %date% %time%
echo.
echo ========================================

echo.
echo Deseas generar un informe detallado? (S/N)
set /p informe=

if /i "%informe%"=="S" (
    set "archivo_informe=%USERPROFILE%\Desktop\Informe_Riot_Kernel_%date:~-4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%.txt"
    set "archivo_informe=!archivo_informe: =0!"
    
    echo Generando informe en el escritorio...
    echo.
    
    (
        echo ========================================
        echo   INFORME DE VERIFICACION RIOT KERNEL
        echo ========================================
        echo.
        echo Fecha: %date% %time%
        echo Sistema: %computername%
        echo Usuario: %username%
        echo.
        echo ========================================
        echo   SERVICIOS
        echo ========================================
        echo.
        sc query vgc 2^>nul
        sc query vgk 2^>nul
        echo.
        echo ========================================
        echo   DRIVERS EN MEMORIA
        echo ========================================
        echo.
        driverquery /v ^| findstr /i "vgk vgc riot vanguard"
        echo.
        echo ========================================
        echo   ARCHIVOS .SYS
        echo ========================================
        echo.
        dir "%SystemRoot%\System32\drivers\vgk.sys" 2^>nul
        dir "%SystemRoot%\System32\drivers\vgc.sys" 2^>nul
        dir "%SystemRoot%\System32\drivers\*riot*.sys" 2^>nul
        echo.
        echo ========================================
        echo   REGISTRO DEL SISTEMA
        echo ========================================
        echo.
        reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgc" 2^>nul
        reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgk" 2^>nul
        echo.
        echo ========================================
        echo   PROCESOS ACTIVOS
        echo ========================================
        echo.
        tasklist ^| findstr /i "vgc vgtray vanguard riot"
        echo.
        echo ========================================
        echo   FIN DEL INFORME
        echo ========================================
    ) > "!archivo_informe!"
    
    echo [OK] Informe generado exitosamente:
    echo !archivo_informe!
    echo.
    start "" "!archivo_informe!"
)

echo.
echo Presiona cualquier tecla para cerrar...
pause >nul