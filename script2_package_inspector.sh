#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: [Your Name] | Reg No: [Your Reg No]
# Course: Open Source Software | Capstone Project
# Software Choice: Linux Kernel
# Description: Checks if a package is installed, shows its
#              version and license, and prints a philosophy
#              note about it using a case statement.
# ============================================================

# --- Package to inspect (Linux Kernel related tools) ---
PACKAGE=${1:-"linux-headers-$(uname -r)"}   # Accept package name as argument, default to current kernel headers

# --- Detect package manager: apt (Debian/Ubuntu) or rpm (Fedora/RHEL) ---
detect_pkg_manager() {
    if command -v apt &>/dev/null; then
        echo "apt"
    elif command -v rpm &>/dev/null; then
        echo "rpm"
    else
        echo "unknown"
    fi
}

PKG_MANAGER=$(detect_pkg_manager)   # Store the detected package manager

echo "================================================"
echo "   FOSS Package Inspector"
echo "   Package Manager Detected: $PKG_MANAGER"
echo "================================================"

# --- Check if package is installed using appropriate package manager ---
if [ "$PKG_MANAGER" = "apt" ]; then
    # dpkg -l lists installed packages; grep -w matches exact package name
    if dpkg -l "$PACKAGE" &>/dev/null; then
        echo "[INSTALLED] $PACKAGE"
        echo ""
        echo "--- Package Details ---"
        # dpkg-query formats output; %f\n ensures fields appear on new lines
        dpkg-query -W -f='Version: ${Version}\nMaintainer: ${Maintainer}\nDescription: ${Description}\n' "$PACKAGE" 2>/dev/null
    else
        echo "[NOT INSTALLED] $PACKAGE is not installed on this system."
        echo "To install, try: sudo apt install $PACKAGE"
    fi

elif [ "$PKG_MANAGER" = "rpm" ]; then
    # rpm -q returns 0 if package is installed, non-zero otherwise
    if rpm -q "$PACKAGE" &>/dev/null; then
        echo "[INSTALLED] $PACKAGE"
        echo ""
        echo "--- Package Details ---"
        # rpm -qi gives full info; grep filters only the useful fields
        rpm -qi "$PACKAGE" | grep -E "Version|License|Summary|Packager"
    else
        echo "[NOT INSTALLED] $PACKAGE is not installed on this system."
        echo "To install, try: sudo dnf install $PACKAGE"
    fi

else
    echo "Could not detect a supported package manager (apt or rpm)."
    echo "Showing kernel version directly from uname:"
    uname -r
fi

echo ""
echo "--- Kernel Version Currently Running ---"
echo "Kernel: $(uname -r)"         # Always show running kernel regardless of package check
echo "Architecture: $(uname -m)"

# --- Case statement: philosophy note based on package/software name ---
echo ""
echo "--- Open Source Philosophy Note ---"

# Simplify package name for matching by stripping version numbers
PKG_BASE=$(echo "$PACKAGE" | sed 's/[-_][0-9].*//')   # Remove version suffixes

case "$PKG_BASE" in
    linux*|kernel*)
        echo "Linux Kernel: The foundation of the free world — Linus Torvalds"
        echo "started this in 1991 as a student project. GPL v2 ensures it"
        echo "stays free forever. Today it powers servers, phones, and space."
        ;;
    httpd|apache*)
        echo "Apache HTTP Server: The open web server that proved open source"
        echo "could power the internet. Apache 2.0 license — permissive and free."
        ;;
    mysql|mariadb*)
        echo "MySQL/MariaDB: Dual-licensed under GPL and commercial — a classic"
        echo "example of open source meeting business needs."
        ;;
    vlc*)
        echo "VLC: Built by students at École Centrale Paris to stream video"
        echo "over their campus network. LGPL/GPL — plays anything, anywhere."
        ;;
    firefox*)
        echo "Firefox: Mozilla's answer to browser monopoly. MPL 2.0 license,"
        echo "a nonprofit fighting for an open, user-respecting web."
        ;;
    git*)
        echo "Git: Linus built this in 2005 in just two weeks after BitKeeper"
        echo "revoked free access to the kernel team. GPL v2, now used by all."
        ;;
    python*)
        echo "Python: PSF License — community-driven, open governance. Proof"
        echo "that a language shaped entirely by volunteers can rule the world."
        ;;
    *)
        echo "$PACKAGE: An open-source tool — explore its license at spdx.org"
        echo "and its source code at github.com or its official repository."
        ;;
esac

echo "================================================"
