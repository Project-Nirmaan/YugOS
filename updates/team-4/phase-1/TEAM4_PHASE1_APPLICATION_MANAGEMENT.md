# Project OS V1 — Team 4
## Phase 1 — Part 1: DNF & CLI Application Management

**Team:** Team 4 — Application Management  
**Environment:** Fedora 44 Workstation  
**Scope:** DNF verification, configuration, CLI application management, and cleanup

---

## 1. Objective & Workflow

Validate the Fedora DNF package-management workflow:
Repository Verification → DNF Configuration → Repository Access → CLI Package Search → CLI Installation → Installation Verification → Application Launch → CLI Removal → Removal Verification → Autoremove Check.

---

## 2. Environment Verification

* **Fedora Version (`cat /etc/os-release`):** Fedora Linux 44 Workstation Edition.
* **DNF Version (`dnf --version`):** DNF5 (v5.4.2.1) operational.

---

## 3. Fedora Repository & Access Verification

* **Command:** `dnf repolist`, `sudo dnf makecache`, `sudo dnf check`
* **Status:** **PASS**
* **Result:** `fedora`, `fedora-cisco-openh264`, and `updates` repositories loaded successfully. No package consistency errors.

---

## 4. DNF Configuration & Validation

* **File Modified:** `/etc/dnf/dnf.conf` (Backup created at `/etc/dnf/dnf.conf.backup`)
* **Settings Added:**
  ```ini
  max_parallel_downloads=10
  fastestmirror=True
  ```
* **Validation:** Verified via `cat` and `grep`. Subsequent metadata caches loaded successfully. **PASS**

---

## 5. CLI Application Search & Installation

* **Commands:** `dnf search gimp`, `dnf info gimp`, `sudo dnf install -y gimp libreoffice-writer`
* **Status:** **PASS**
* **Result:** GIMP (v3.2.4) installed successfully. LibreOffice Writer was already present. Execution confirmed via `rpm -q` and `dnf list --installed`.

---

## 6. GIMP Installation & Launch Verification

* **Commands:** `ls -l /usr/bin/gimp`, `ls -l /usr/share/applications/gimp.desktop`, `gimp`
* **Status:** **PASS**
* **Result:** Binary link and desktop launcher verified. GIMP launched successfully despite minor Wayland/input terminal warnings.

---

## 7. CLI Application Removal & Verification

* **Commands:** `sudo dnf remove -y gimp libreoffice-writer`, `rpm -q`, `ls -l`
* **Status:** **PASS**
* **Result:** Both packages successfully uninstalled. Binaries and desktop entries completely removed.

---

## 8. Autoremove Check & Final DNF Re-Test

* **Commands:** `sudo dnf autoremove`, `dnf repolist`, `sudo dnf check`
* **Status:** **PASS**
* **Result:** DNF properly flagged 11 orphaned packages (transaction aborted intentionally to save VM state). Final sanity checks confirmed repositories and configurations remained intact.

---

## 9. Errors / Observations

* **LibreOffice Writer:** Already installed; did not halt the transaction.
* **GIMP Launch:** Minor input/device terminal warnings occurred but did not prevent application execution.
* **Autoremove:** Cancelled by choice to avoid altering unrelated system dependencies.
