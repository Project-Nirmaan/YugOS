#!/usr/bin/env bash
# service_mgmt.sh - Restarts network services and checks status
# Author: Team 3 (Terminal & System Control)

set -euo pipefail

SERVICE_NAME="${1:-NetworkManager}"

echo "=========================================="
echo " Project OS V1 - Service Management"
echo "=========================================="
echo "Target Service: ${SERVICE_NAME}"
echo ""

if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root or with sudo." 
   exit 1
fi

echo "Restarting service: ${SERVICE_NAME}..."
systemctl restart "${SERVICE_NAME}"

echo "Checking status of ${SERVICE_NAME}..."
systemctl status "${SERVICE_NAME}" --no-pager || true

echo "Service operation completed."
