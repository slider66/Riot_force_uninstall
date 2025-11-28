# Riot Games Complete Uninstaller & Kernel Verifier

![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D6?style=flat&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)
![Batch](https://img.shields.io/badge/language-Batch-blue)

[🇺🇸 English Version](README_EN.md)

Herramientas completas para la desinstalación profunda de Riot Games (Valorant, League of Legends, Riot Client) y verificación de componentes residuales en el kernel de Windows.

## 📋 Tabla de Contenidos

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Uso](#-uso)
- [Scripts Incluidos](#-scripts-incluidos)
- [Advertencias Importantes](#-advertencias-importantes)
- [Qué se Elimina](#-qué-se-elimina)
- [FAQ](#-faq)
- [Licencia](#-licencia)

## ✨ Características

### Script de Desinstalación (`desinstalar_riot.bat`)

- ✅ Desinstalación completa de todos los componentes de Riot Games
- ✅ Eliminación de drivers del kernel (Vanguard)
- ✅ Limpieza profunda del registro de Windows
- ✅ Eliminación de archivos temporales y configuraciones
- ✅ Auto-elevación de privilegios de administrador
- ✅ Feedback detallado de cada operación
- ✅ Opción de reinicio automático

### Script de Verificación (`verificar_riot_kernel.bat`)

- ✅ Verificación de servicios en el sistema
- ✅ Detección de drivers en memoria
- ✅ Búsqueda de archivos .sys residuales
- ✅ Análisis del registro del sistema
- ✅ Detección de procesos activos
- ✅ Generación de informe detallado

## 💻 Requisitos

- Windows 10 o Windows 11
- Permisos de administrador (los scripts se auto-elevan)
- PowerShell habilitado (viene por defecto en Windows)

## 📥 Instalación

1. **Descarga los scripts:**

   ```bash
   git clone https://github.com/tu-usuario/riot-uninstaller.git
   cd riot-uninstaller
   ```

2. **O descarga manualmente:**
   - `desinstalar_riot.bat` - Script de desinstalación
   - `verificar_riot_kernel.bat` - Script de verificación

## 🚀 Uso

### Paso 1: Verificación Inicial (Opcional)

Antes de desinstalar, puedes verificar qué componentes de Riot están presentes:

```batch
verificar_riot_kernel.bat
```

### Paso 2: Desinstalación Completa

1. **Cierra todos los juegos de Riot Games** (Valorant, LoL, etc.)
2. **Ejecuta el desinstalador:**
   - Doble clic en `desinstalar_riot.bat`
   - El script se auto-elevará a administrador
3. **Lee la advertencia** y presiona cualquier tecla para continuar
4. **Observa el progreso** de cada fase:
   - [1/6] Deteniendo procesos
   - [2/6] Eliminando servicios
   - [3/6] Ejecutando desinstaladores
   - [4/6] Eliminando carpetas
   - [5/6] Limpiando registro
   - [6/6] Limpieza final
5. **Reinicia tu PC** cuando el script lo solicite

### Paso 3: Verificación Post-Desinstalación

Después de reiniciar, verifica que todo se eliminó correctamente:

```batch
verificar_riot_kernel.bat
```

**Resultado esperado:** `[SISTEMA LIMPIO]`

## 📦 Scripts Incluidos

### 1. `desinstalar_riot.bat`

**Descripción:** Script principal de desinstalación que elimina todos los componentes de Riot Games.

**Proceso:**

```
1. Auto-elevación a administrador
2. Advertencia y confirmación
3. Detención de procesos (RiotClient, Valorant, Vanguard, etc.)
4. Eliminación de servicios del kernel (vgc, vgk)
5. Ejecución de desinstaladores oficiales
6. Eliminación de carpetas:
   - C:\Riot Games\
   - C:\Program Files\Riot Vanguard\
   - %LOCALAPPDATA%\Riot Games\
   - %APPDATA%\Riot Games\
   - %PROGRAMDATA%\Riot Games\
7. Limpieza del registro de Windows
8. Eliminación de accesos directos
9. Limpieza de DNS
10. Opción de reinicio
```

**Salida:**

- `[OK]` - Operación exitosa
- `[INFO]` - Elemento no encontrado (normal)
- `[AVISO]` - Algunos archivos no pudieron eliminarse
- `[EJECUTANDO]` - Operación en proceso

### 2. `verificar_riot_kernel.bat`

**Descripción:** Script de verificación que comprueba la presencia de componentes de Riot en el kernel y sistema.

**Análisis realizado:**

```
1. Verificación de servicios (vgc, vgk)
2. Detección de drivers en memoria
3. Búsqueda de archivos .sys
4. Análisis del registro del sistema
5. Detección de procesos activos
```

**Salida:**

- `[SISTEMA LIMPIO]` - No hay componentes de Riot
- `[ATENCIÓN REQUERIDA]` - Se detectaron componentes residuales

**Opción:** Generación de informe detallado en el escritorio

## ⚠️ Advertencias Importantes

### 🔴 CRÍTICO

- **Proceso irreversible:** Una vez ejecutado, no podrás recuperar los archivos
- **Perderás todo:** Configuraciones, skins descargados, partidas guardadas
- **Requiere reinicio:** Para eliminar completamente los drivers del kernel
- **Cierra los juegos:** Antes de ejecutar el script

### 🟡 IMPORTANTE

- Ejecuta siempre como **administrador**
- **Reinicia el PC** después de la desinstalación
- Si tienes **antivirus activo**, podría interferir
- **Haz backup** de tus configuraciones si las necesitas

### ⚠️ Casos Especiales

**Si el script muestra `[AVISO]`:**

- Algunos archivos están en uso
- Reinicia el PC y ejecuta el script nuevamente
- Verifica que no haya procesos de Riot activos en el Administrador de Tareas

**Si después de reiniciar siguen apareciendo componentes:**

- Ejecuta el script en **Modo Seguro** de Windows
- Elimina manualmente los archivos .sys detectados
- Usa herramientas como `Autoruns` de Sysinternals

## 🗑️ Qué se Elimina

### Aplicaciones

- ✅ Riot Client
- ✅ Riot Vanguard (Anti-cheat)
- ✅ Valorant
- ✅ League of Legends
- ✅ Riot Client Repair Tool
- ✅ Todos los componentes relacionados

### Servicios y Drivers

- ✅ Servicio VGC (Vanguard Client)
- ✅ Servicio VGK (Vanguard Kernel)
- ✅ Driver vgk.sys
- ✅ Driver vgc.sys

### Archivos y Carpetas

```
C:\Riot Games\
C:\Program Files\Riot Vanguard\
C:\Program Files (x86)\Riot Vanguard\
%LOCALAPPDATA%\Riot Games\
%APPDATA%\Riot Games\
%PROGRAMDATA%\Riot Games\
%TEMP%\Riot Games\
```

### Registro de Windows

```
HKLM\SOFTWARE\Riot Games
HKCU\Software\Riot Games
HKLM\SYSTEM\CurrentControlSet\Services\vgc
HKLM\SYSTEM\CurrentControlSet\Services\vgk
HKCR\riotclient
```

### Otros

- Accesos directos del escritorio
- Entradas del menú inicio
- Cache DNS
- Entradas de desinstalación

## ❓ FAQ

### ¿Es seguro usar estos scripts?

Sí, los scripts solo eliminan componentes de Riot Games y no afectan otros programas o archivos del sistema.

### ¿Por qué necesito reiniciar?

Vanguard instala drivers a nivel de kernel que se cargan al inicio. El reinicio es necesario para descargarlos completamente de la memoria.

### ¿Puedo reinstalar Riot Games después?

Sí, puedes descargar e instalar nuevamente desde la página oficial de Riot Games cuando quieras.

### ¿Qué hago si el script no elimina todo?

1. Reinicia el PC
2. Ejecuta el script nuevamente
3. Si persiste, ejecuta en Modo Seguro
4. Usa el script de verificación para identificar componentes residuales

### ¿Funciona en Windows 11?

Sí, ambos scripts son compatibles con Windows 10 y Windows 11.

### ¿Necesito antivirus desactivado?

No es necesario, pero algunos antivirus pueden interferir. Si tienes problemas, desactívalo temporalmente.

### ¿Se eliminan mis datos de cuenta?

No, tus datos de cuenta de Riot Games están en los servidores. Solo se eliminan archivos locales y configuraciones.

### El verificador muestra alertas después de desinstalar

Si acabas de desinstalar pero no has reiniciado, es normal. Los drivers del kernel requieren reinicio para descargarse de memoria.

## 🛠️ Solución de Problemas

### Error: "Este script requiere permisos de administrador"

**Solución:** Clic derecho en el script → "Ejecutar como administrador"

### Algunos archivos no se eliminan

**Solución:**

1. Cierra todos los procesos de Riot en el Administrador de Tareas
2. Reinicia el PC
3. Ejecuta el script nuevamente

### Vanguard sigue apareciendo después de reiniciar

**Solución:**

1. Ejecuta el script en Modo Seguro:
   - Presiona `Win + R`
   - Escribe: `msconfig`
   - Ve a "Arranque" → Marca "Arranque seguro"
   - Reinicia
   - Ejecuta el script
   - Desmarca "Arranque seguro" y reinicia normalmente

### El script se cierra inmediatamente

**Solución:** El script tiene auto-elevación. Si se cierra, revisa:

1. Que PowerShell esté habilitado
2. Que UAC (Control de Cuentas de Usuario) esté activo
3. Ejecuta manualmente como administrador

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/NuevaCaracteristica`)
3. Commit tus cambios (`git commit -m 'Añade nueva característica'`)
4. Push a la rama (`git push origin feature/NuevaCaracteristica`)
5. Abre un Pull Request

## 📝 Changelog

### v1.0.0 (2025-09-30)

- ✨ Release inicial
- ✅ Script de desinstalación completa
- ✅ Script de verificación de kernel
- ✅ Auto-elevación de privilegios
- ✅ Feedback detallado de operaciones
- ✅ Generación de informes

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## ⚖️ Disclaimer

Estos scripts son herramientas de desinstalación independientes y no están afiliados, respaldados ni asociados con Riot Games de ninguna manera.

**Uso bajo tu propio riesgo.** Los autores no se hacen responsables de ningún daño o pérdida de datos. Asegúrate de entender lo que hacen los scripts antes de ejecutarlos.

## 📧 Contacto

Si tienes preguntas, problemas o sugerencias:

- Abre un [Issue](https://github.com/slider66/riot-uninstaller/issues)
- Contribuye con un [Pull Request](https://github.com/slider66/riot-uninstaller/pulls)

---

**⭐ Si estos scripts te fueron útiles, considera darle una estrella al repositorio!**

---

Hecho con ❤️ para la comunidad
