#!/bin/bash
# TLP Power Management Setup Script for ThinkPad Z13 Gen 2
# Run: sudo ./setup.sh

set -e

SCRIPT_DIR="$(dirname "$(realpath "$0")")"

echo "=== TLP Power Management Setup ==="
echo ""

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "Run with sudo: sudo ./setup.sh"
   exit 1
fi

# Install TLP if not present
if ! command -v tlp &> /dev/null; then
    echo "[1/6] Installing TLP..."
    pacman -S --noconfirm tlp tlp-rdw
else
    echo "[1/6] TLP already installed"
fi

# Disable conflicting services
echo "[2/6] Disabling conflicting power management services..."
systemctl disable --now power-profiles-daemon.service 2>/dev/null || true
systemctl mask power-profiles-daemon.service 2>/dev/null || true

# Deploy TLP config
echo "[3/6] Deploying TLP configuration..."
cp "$SCRIPT_DIR/tlp-amd.conf" /etc/tlp.d/01-amd-thinkpad.conf
chmod 644 /etc/tlp.d/01-amd-thinkpad.conf

# Deploy sysctl config
echo "[4/6] Deploying sysctl power saving settings..."
cp "$SCRIPT_DIR/99-powersave.conf" /etc/sysctl.d/99-powersave.conf
chmod 644 /etc/sysctl.d/99-powersave.conf
sysctl --system > /dev/null 2>&1

# Enable and start TLP
echo "[5/6] Enabling TLP service..."
systemctl enable tlp.service
systemctl start tlp.service

# Enable radio device switching
systemctl enable tlp-rdw.service 2>/dev/null || true

# Apply TLP settings immediately
echo "[6/6] Applying TLP settings..."
tlp start > /dev/null 2>&1

# Verify
echo ""
echo "=== Current Status ==="
tlp-stat -s | head -15

echo ""
echo "=== Power Consumption ==="
if [[ -f /sys/class/power_supply/BAT0/power_now ]]; then
    POWER=$(cat /sys/class/power_supply/BAT0/power_now 2>/dev/null)
    echo "Current draw: $(awk "BEGIN {printf \"%.2f\", $POWER / 1000000}")W"
fi

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "IMPORTANT: For maximum savings, add these kernel parameters:"
echo "  pcie_aspm=force nowatchdog nmi_watchdog=0 workqueue.power_efficient=1"
echo ""
echo "See: $SCRIPT_DIR/kernel-params.txt for details"
echo ""
echo "Useful commands:"
echo "  tlp-stat -s        # TLP status"
echo "  tlp-stat -b        # Battery info"
echo "  tlp-stat -p        # CPU power info"
echo "  powertop           # Detailed power analysis"
