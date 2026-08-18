# Project OS V1 Master Kickstart Recipe
# Target OS: Fedora Workstation 42

lang en_US.UTF-8
keyboard us
timezone UTC --utc

# Network configuration
network --bootproto=dhcp --device=link --activate

# Root password and user account setup
rootpw --plaintext ospassword
user --name=osuser --password=ospassword --plaintext --gecos="Project OS User" --groups=wheel

# System bootloader and partition setup
bootloader --location=mbr --boot-drive=vda
clearpart --all --initlabel
autopart --type=thin

# Package installation selection
%packages
@gnome-desktop
anaconda
kernel
gnome-terminal
nautilus
dnf
git
shellcheck
pykickstart
dconf
udisks2
%end

# Post-installation system configuration
%post --erroronfail
echo "Configuring Project OS V1 Defaults..."

# Ensure osuser has passwordless sudo permission setup directory
mkdir -p /etc/sudoers.d
echo "osuser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/osuser
chmod 0440 /etc/sudoers.d/osuser

# Tune DNF configuration for fast downloads
cat << 'EOF' >> /etc/dnf/dnf.conf
max_parallel_downloads=10
fastestmirror=True
EOF

echo "Project OS V1 Setup Complete."
%end
