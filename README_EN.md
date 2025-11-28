# Riot Games Complete Uninstaller & Kernel Verifier

![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D6?style=flat&logo=windows&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green)
![Batch](https://img.shields.io/badge/language-Batch-blue)

[🇪🇸 Versión en Español](README.md)

Complete tools for the deep uninstallation of Riot Games (Valorant, League of Legends, Riot Client) and verification of residual components in the Windows kernel.

## 📋 Table of Contents

- [Features](#-features)
- [Requirements](#-requirements)
- [Installation](#-installation)
- [Usage](#-usage)
- [Included Scripts](#-included-scripts)
- [Important Warnings](#-important-warnings)
- [What gets Removed](#-what-gets-removed)
- [FAQ](#-faq)
- [License](#-license)

## ✨ Features

### Uninstallation Script (`desinstalar_riot.bat`)

- ✅ Complete uninstallation of all Riot Games components
- ✅ Removal of kernel drivers (Vanguard)
- ✅ Deep cleaning of the Windows Registry
- ✅ Removal of temporary files and configurations
- ✅ Auto-elevation of administrator privileges
- ✅ Detailed feedback for each operation
- ✅ Automatic restart option
- ✅ **New:** Creates a System Restore Point before starting

### Verification Script (`verificar_riot_kernel.bat`)

- ✅ Verification of system services
- ✅ Detection of drivers in memory
- ✅ Search for residual .sys files
- ✅ System registry analysis
- ✅ Detection of active processes
- ✅ Detailed report generation

## 💻 Requirements

- Windows 10 or Windows 11
- Administrator permissions (scripts auto-elevate)
- PowerShell enabled (default in Windows)

## 📥 Installation

1. **Download the scripts:**

   ```bash
   git clone https://github.com/slider66/riot-uninstaller.git
   cd riot-uninstaller
   ```

2. **Or download manually:**
   - `desinstalar_riot.bat` - Uninstallation script
   - `verificar_riot_kernel.bat` - Verification script

## 🚀 Usage

### Step 1: Initial Verification (Optional)

Before uninstalling, you can verify which Riot components are present:

```batch
verificar_riot_kernel.bat
```

### Step 2: Complete Uninstallation

1. **Close all Riot Games** (Valorant, LoL, etc.)
2. **Run the uninstaller:**
   - Double click on `desinstalar_riot.bat`
   - The script will auto-elevate to administrator
3. **Read the warning** and press any key to continue
4. **Watch the progress** of each phase:
   - [1/7] Creating System Restore Point
   - [2/7] Stopping processes
   - [3/7] Removing services
   - [4/7] Running uninstallers
   - [5/7] Removing folders
   - [6/7] Cleaning registry
   - [7/7] Final cleanup
5. **Restart your PC** when the script requests it

### Step 3: Post-Uninstallation Verification

After restarting, verify that everything was removed correctly:

```batch
verificar_riot_kernel.bat
```

**Expected Result:** `[SYSTEM CLEAN]`

## 📦 Included Scripts

### 1. `desinstalar_riot.bat`

**Description:** Main uninstallation script that removes all Riot Games components.

**Process:**

```
1. Auto-elevation to administrator
2. Warning and confirmation
3. Creation of System Restore Point
4. Stopping processes (RiotClient, Valorant, Vanguard, etc.)
5. Removal of kernel services (vgc, vgk)
6. Execution of official uninstallers
7. Removal of folders:
   - C:\Riot Games\
   - C:\Program Files\Riot Vanguard\
   - %LOCALAPPDATA%\Riot Games\
   - %APPDATA%\Riot Games\
   - %PROGRAMDATA%\Riot Games\
8. Cleaning of Windows Registry
9. Removal of shortcuts
10. DNS Cleanup
11. Restart option
```

### 2. `verificar_riot_kernel.bat`

**Description:** Verification script that checks for the presence of Riot components in the kernel and system.

**Analysis performed:**

```
1. Service verification (vgc, vgk)
2. Detection of drivers in memory
3. Search for .sys files
4. System registry analysis
5. Detection of active processes
```

**Output:**

- `[SYSTEM CLEAN]` - No Riot components found
- `[ATTENTION REQUIRED]` - Residual components detected

**Option:** Detailed report generation on the desktop

## ⚠️ Important Warnings

### 🔴 CRITICAL

- **Irreversible process:** Once executed, you cannot recover the files (unless you use the System Restore Point)
- **You will lose everything:** Configurations, downloaded skins, saved games
- **Requires restart:** To completely remove kernel drivers
- **Close games:** Before running the script

### 🟡 IMPORTANT

- Always run as **administrator**
- **Restart PC** after uninstallation
- If you have an **active antivirus**, it might interfere
- **Backup** your settings if you need them

## 🗑️ What gets Removed

### Applications

- ✅ Riot Client
- ✅ Riot Vanguard (Anti-cheat)
- ✅ Valorant
- ✅ League of Legends
- ✅ Riot Client Repair Tool
- ✅ All related components

### Services and Drivers

- ✅ VGC Service (Vanguard Client)
- ✅ VGK Service (Vanguard Kernel)
- ✅ vgk.sys Driver
- ✅ vgc.sys Driver

### Files and Folders

```
C:\Riot Games\
C:\Program Files\Riot Vanguard\
C:\Program Files (x86)\Riot Vanguard\
%LOCALAPPDATA%\Riot Games\
%APPDATA%\Riot Games\
%PROGRAMDATA%\Riot Games\
%TEMP%\Riot Games\
```

### Windows Registry

```
HKLM\SOFTWARE\Riot Games
HKCU\Software\Riot Games
HKLM\SYSTEM\CurrentControlSet\Services\vgc
HKLM\SYSTEM\CurrentControlSet\Services\vgk
HKCR\riotclient
```

## ❓ FAQ

### Is it safe to use these scripts?

Yes, the scripts only remove Riot Games components. Plus, it now creates a System Restore Point for added safety.

### Why do I need to restart?

Vanguard installs kernel-level drivers that load at startup. Restarting is necessary to completely unload them from memory.

### Can I reinstall Riot Games later?

Yes, you can download and install again from the official Riot Games website whenever you want.

## 📄 License

This project is under the MIT License. See the `LICENSE` file for more details.

## ⚖️ Disclaimer

These scripts are independent uninstallation tools and are not affiliated, endorsed, or associated with Riot Games in any way.

**Use at your own risk.** The authors are not responsible for any damage or data loss. Make sure you understand what the scripts do before running them.
