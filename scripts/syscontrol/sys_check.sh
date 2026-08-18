#!/usr/bin/env bash
# sys_check.sh - Checks IP address and network interface status
# Author: Team 3 (Terminal & System Control)

set -euo pipefail

echo "=========================================="
echo " Project OS V1 - Network System Status"
echo "=========================================="
echo ""

echo "--- Active Network Interfaces (ip a) ---"
ip a

echo ""
echo "--- NetworkManager Connections (nmcli) ---"
if command -v nmcli >/dev/null 2>&1; then
    nmcli device status || echo "Failed to query nmcli status."
else
    echo "Warning: nmcli command not found."
fi

echo ""
echo "System check completed successfully."
