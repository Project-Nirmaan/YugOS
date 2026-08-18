# Project OS V1 - Installation Guide

## 1. Prerequisites (Host Machine)
- **Hardware Specs**: 8GB+ RAM, 4 CPU cores, 35GB+ free SSD disk space.
- **BIOS/UEFI**: Enable Virtualization (Intel VT-x or AMD-V).
- **Linux Host Permissions**:
  ```bash
  sudo usermod -aG kvm,libvirt $USER
  ```
  *(Log out and log back in for group changes to take effect).*

---

## 2. Dev Environment Setup (Dev VM Sandbox)

### Step 1: Install Hypervisor
- **Linux (Fedora/RHEL)**:
  ```bash
  sudo dnf install -y qemu-kvm virt-manager
  ```
- **Linux (Ubuntu/Debian)**:
  ```bash
  sudo apt install -y qemu-kvm virt-manager
  ```
- **Windows / macOS**: Download and install [VirtualBox 7+](https://www.virtualbox.org/).

### Step 2: Create Baseline Fedora Dev VM
1. Download official **Fedora Workstation 42 Live ISO**.
2. Create VM: 4GB RAM, 2 vCPUs, 30GB Disk space, UEFI Firmware enabled.
3. Install OS (User: `osuser` / Password: `ospassword`).
4. **Take Snapshot**: Name snapshot `00-clean-baseline`.

### Step 3: Install Essential Helper Tools Inside Dev VM
Open a terminal inside your new Dev VM and execute:
```bash
# Update system & install tools
sudo dnf update -y && sudo dnf install -y git shellcheck pykickstart dconf-editor udisks2

# Setup SSH key for GitHub
ssh-keygen -t ed25519 -C "your.email@example.com"
cat ~/.ssh/id_ed25519.pub
```
Add the SSH key to **GitHub -> Settings -> SSH Keys**.

---

## 3. ISO Build Command (Team 1)

To compile the master `ProjectOS-V1.iso` from the Kickstart recipe:

```bash
# 1. Validate Kickstart file syntax
ksvalid configs/kickstart/fedora-os-v1.ks

# 2. Package into bootable Live ISO
sudo livemedia-creator \
  --make-iso \
  --ks=configs/kickstart/fedora-os-v1.ks \
  --iso-only \
  --iso-name=ProjectOS-V1.iso \
  --releasever=42 \
  --macboot

# 3. Test ISO boot in QEMU
qemu-system-x86_64 -m 4096 -enable-kvm -bios /usr/share/OVMF/OVMF_CODE.fd -cdrom ProjectOS-V1.iso
```
