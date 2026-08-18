#!/usr/bin/env bash
# user_passwd.sh - Manages user password changes
# Author: Team 3 (Terminal & System Control)

set -euo pipefail

TARGET_USER="${1:-osuser}"

echo "=========================================="
echo " Project OS V1 - User Password Management"
echo "=========================================="
echo "Target User Account: ${TARGET_USER}"
echo ""

if [[ $EUID -ne 0 ]]; then
   echo "Error: Password management requires administrative privileges. Run with sudo." 
   exit 1
fi

if ! id "${TARGET_USER}" >/dev/null 2>&1; then
    echo "Error: User account '${TARGET_USER}' does not exist."
    exit 1
fi

echo "Initiating password change for user: ${TARGET_USER}..."
passwd "${TARGET_USER}"

echo "Password update completed for ${TARGET_USER}."
