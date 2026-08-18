# Project OS V1 - System Architecture & Component Design

## Overview
Project OS V1 is a lightweight, custom Fedora 42 derivative designed around a modular team-based workflow.

## Component Breakdown

### 1. Build & Installer Layer (Team 1)
- ** Kickstart Recipe**: Located at `configs/kickstart/fedora-os-v1.ks`.
- **Image Builder**: `livemedia-creator` packages package sets (`@gnome-desktop`), user permissions, and custom system configurations into a bootable `ProjectOS-V1.iso`.

### 2. Desktop Environment & Storage (Team 2)
- **GNOME Desktop Defaults**: Managed via dconf profile `configs/dconf/00-projectos`.
- **Storage Subsystem**: `udisks2` and `udisksctl` handle auto-mounting under `/run/media/osuser/`.

### 3. System Control & Privileges (Team 3)
- **Control Scripts**: Helper utilities in `scripts/syscontrol/` (`sys_check.sh`, `service_mgmt.sh`, `user_passwd.sh`, `log_view.sh`).
- **Sudoers Management**: `/etc/sudoers.d/osuser` provides administrative access control.

### 4. Package & Software Management (Team 4)
- **DNF Optimization**: Fast mirror auto-selection and 10 parallel downloads configured in `configs/dnf/dnf.conf`.

### 5. Quality Assurance & Continuous Integration (Team 5)
- **CI Pipelines**: GitHub Actions workflow (`.github/workflows/lint.yml`) validates script syntax (`shellcheck`) and Kickstart integrity (`ksvalid`).
- **Smoke Testing Matrix**: Weekly verification of UEFI boot, Anaconda installation, and post-installation desktop features.
