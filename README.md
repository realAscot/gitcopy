# ⚙️ GitCopy – All in One

![gitCopy Logo](./media/gitcopy_logo_300x300.png)

[![Lizenz: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Plattform: Windows](https://img.shields.io/badge/platform-Windows%2010%2F11-blue.svg)](#voraussetzungen)
[![Status: Stable](https://img.shields.io/badge/status-stable-brightgreen.svg)](#)

> **GitCopy** ist ein minimalistisches CLI-Tool, das ein ZIP-Archiv aus dem aktuellen Stand eines Git-Repositories erstellt – optimiert für schnelle Übergaben, Archivierungen und Analysen.

---

## 📑 Inhaltsverzeichnis

- [⚙️ GitCopy – All in One](#️-gitcopy--all-in-one)
  - [📑 Inhaltsverzeichnis](#-inhaltsverzeichnis)
  - [💬 Über das Projekt](#-über-das-projekt)
  - [🔧 Voraussetzungen](#-voraussetzungen)
  - [📦 Projektstruktur](#-projektstruktur)
  - [⚙️ Installation \& Verwendung](#️-installation--verwendung)
    - [Optionale Parameter:](#optionale-parameter)
  - [🤝 Beitragende](#-beitragende)
  - [⚠️ Lizenz](#️-lizenz)
  - [💡 Hinweise](#-hinweise)

---

## 💬 Über das Projekt

**GitCopy** richtet sich an alle, die schnell und unkompliziert den aktuellen Stand eines Git-Repositories als saubere ZIP-Datei exportieren möchten.  
Typische Anwendungsfälle:
- Übergabe von Projektständen an KIs oder externe Systeme
- Archivierung von Quellcodes ohne Git-Historie
- Erstellung sauberer, analysierbarer Snapshots

Das Ziel ist ein robuster, schlanker Prozess ohne zusätzliche Abhängigkeiten oder komplexe Konfiguration.

---

## 🔧 Voraussetzungen

- **Betriebssystem:** Windows 10 oder höher
- **Installiertes Git:**  
  Git muss auf dem System verfügbar sein (`git` im Pfad).  
  [Git Download-Seite](https://git-scm.com/download/win)
- **Konsole:**  
  Standard `cmd.exe`, Windows Terminal oder kompatible Umgebungen (z. B. PowerShell).

Hinweis:  
Das Skript berücksichtigt `.gitignore` automatisch – nur Dateien, die von Git tatsächlich verfolgt werden, landen im ZIP.

---

## 📦 Projektstruktur

Projektdateien und Verzeichnisse:

```cmd
.
📁 gitcopy/                          # Projektverzeichnis
├── 📁 assets                        # Medien und Icons
│   ├── 📄 gitcopy-original.png      # Originalgrafik
│   ├── 📄 gitcopy_icon.ico          # Icon für Windows-Verknüpfungen
│   └── 📄 gitcopy_logo_300x300.png  # Logo für Dokumentationen
├── 📄 .gitignore                    # Ausschlussdatei für Git
├── 📄 LICENSE                       # Lizenzinformation (MIT)
├── 📄 README.md                     # Diese Dokumentation
├── 📄 VERSION                       # Aktuelle Versionsnummer
├── 📄 gitcopy.bat                   # Hauptskript
```

---

## ⚙️ Installation & Verwendung

1. Repository klonen oder `gitcopy.bat` in ein beliebiges Arbeitsverzeichnis kopieren.
2. Konsole öffnen und das Skript ausführen:

```cmd
gitcopy.bat
```

### Optionale Parameter:

| Parameter      | Beschreibung |
|----------------|---------------|
| `-d`, `--debug` | Aktiviert den Debug-Modus (prüft nicht auf uncommitted Änderungen) |
| `-h`, `--help`  | Zeigt eine Hilfeseite an |

Beispiel:

```cmd
gitcopy.bat --debug
```

---

## 🤝 Beitragende

- [@realAscot](https://github.com/realAscot) – Idee, Konzept und Umsetzung

Beiträge und Verbesserungsvorschläge sind jederzeit willkommen!

---

## ⚠️ Lizenz

Dieses Projekt steht unter der **MIT-Lizenz**.  
Details findest du in der Datei [LICENSE](LICENSE).

---

## 💡 Hinweise

- Das ZIP-Archiv enthält **nur** Dateien, die von Git getrackt werden.  
  Dateien, die in `.gitignore` ausgeschlossen sind, werden **nicht** mit aufgenommen.
- Nicht committed oder nicht getrackte Änderungen werden in der Standardkonfiguration geprüft.
- Im Debug-Modus (`--debug`) werden offene Änderungen ignoriert.

---
