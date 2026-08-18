# YugOS -Project OS V1 Prototype

Main repository for **Project OS V1 Prototype** (Phase 0 development and testing).

---

## 📁 Repository Structure

```
.
├── .github/
│   └── workflows/
│       └── lint.yml             # GitHub Actions CI (shellcheck & ksvalid)
├── configs/
│   ├── kickstart/
│   │   └── fedora-os-v1.ks      # Master Kickstart installer recipe (Team 1)
│   ├── dconf/
│   │   └── 00-projectos         # GNOME desktop wallpaper/dock/hotkey profile (Team 2)
│   ├── dnf/
│   │   └── dnf.conf             # DNF package manager speedup settings (Team 4)
│   └── sudoers/
│       └── osuser               # Administrator permissions snippet (Team 3)
├── scripts/
│   └── syscontrol/
│       ├── sys_check.sh         # Network status & IP checker (Team 3)
│       ├── service_mgmt.sh      # System service management (Team 3)
│       ├── user_passwd.sh       # User password management (Team 3)
│       └── log_view.sh          # System error log viewer (Team 3)
├── docs/
│   ├── INSTALLATION_GUIDE.md    # Dev VM and ISO build guide (Team 5)
│   └── ARCHITECTURE_NOTE.md     # Architecture documentation (Team 5)
├── .gitignore                   # Excludes ISOs, VM disks, build artifacts
└── README.md                    # Project README
```

---

## 👥 Team Assignments & Workflow

- **Team 1 (Build & Boot)**: Maintain `configs/kickstart/fedora-os-v1.ks` and build ISO.
- **Team 2 (Desktop & Storage)**: Maintain `configs/dconf/00-projectos` and USB auto-mounts.
- **Team 3 (Terminal & System Control)**: Maintain `scripts/syscontrol/` scripts and sudoers.
- **Team 4 (App Management)**: Maintain `configs/dnf/dnf.conf` and package testing.
- **Team 5 (CI/CD & QA)**: Maintain CI linter, test Friday ISOs, and update `docs/`.

---

## 🚀 Quick Start for Developers

1. **Clone repo**:
   ```bash
   git clone git@github.com:Project-OS/os-prototype-v1.git
   cd os-prototype-v1
   ```
2. **Checkout feature branch**:
   ```bash
   git checkout dev
   git checkout -b feature/team<NUMBER>-<FEATURE-NAME>
   ```
3. **Test locally in Fedora Dev VM** (Snapshot state: `00-clean-baseline`).
4. **Push changes & open PR to `dev`**:
   ```bash
   git push origin feature/team<NUMBER>-<FEATURE-NAME>
   ```
