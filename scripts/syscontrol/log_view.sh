#!/usr/bin/env bash
# log_view.sh - Queries system error logs
# Author: Team 3 (Terminal & System Control)

set -euo pipefail

PRIORITY="${1:-err}"

echo "=========================================="
echo " Project OS V1 - System Error Log Viewer"
echo "=========================================="
echo "Filtering logs for boot session with priority: ${PRIORITY}"
echo ""

if command -v journalctl >/dev/null 2>&1; then
    journalctl -b -p "${PRIORITY}" --no-pager -n 50 || echo "Failed to fetch logs."
else
    echo "Error: journalctl tool is not available on this system."
    exit 1
fi

echo ""
echo "Log query complete."
