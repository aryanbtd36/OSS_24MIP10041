#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: [Your Name] | Reg No: [Your Reg No]
# Course: Open Source Software | Capstone Project
# Software Choice: Linux Kernel
# Description: Loops through important Linux directories and
#              reports permissions, ownership, and disk usage.
#              Also checks kernel-specific directories.
# ============================================================

# --- List of standard Linux system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/boot" "/lib/modules")

echo "============================================================"
echo "         DISK AND PERMISSION AUDITOR"
echo "         System: $(hostname) | Date: $(date '+%d %B %Y')"
echo "============================================================"
printf "%-25s %-20s %-10s %-10s\n" "Directory" "Permissions+Owner" "Group" "Size"
echo "------------------------------------------------------------"

# --- Loop through each directory in the array ---
for DIR in "${DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        # ls -ld gives long listing of directory itself (not its contents)
        # awk extracts: $1=permissions, $3=owner, $4=group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')

        # du -sh gives human-readable size; 2>/dev/null suppresses permission errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # printf for clean column-aligned output
        printf "%-25s %-20s %-10s %-10s\n" "$DIR" "$PERMS $OWNER" "$GROUP" "$SIZE"
    else
        # Directory does not exist on this system
        printf "%-25s %-20s\n" "$DIR" "[NOT FOUND]"
    fi
done

echo "------------------------------------------------------------"

# --- Special section: Linux Kernel-specific directories ---
echo ""
echo "============================================================"
echo "   LINUX KERNEL — Key Directory Audit"
echo "============================================================"

# Array of kernel-specific paths with descriptions
declare -A KERNEL_DIRS
KERNEL_DIRS["/boot"]="Kernel images, initrd, GRUB bootloader"
KERNEL_DIRS["/lib/modules/$(uname -r)"]="Loadable kernel modules for current kernel"
KERNEL_DIRS["/proc"]="Virtual filesystem — live kernel and process info"
KERNEL_DIRS["/sys"]="Virtual filesystem — hardware and driver info"
KERNEL_DIRS["/usr/src/linux-headers-$(uname -r)"]="Kernel header files for module compilation"

for KDIR in "${!KERNEL_DIRS[@]}"; do
    echo ""
    echo "Path    : $KDIR"
    echo "Purpose : ${KERNEL_DIRS[$KDIR]}"

    if [ -d "$KDIR" ]; then
        # Get permissions and ownership
        KPERMS=$(ls -ld "$KDIR" | awk '{print $1, $3, $4}')
        KSIZE=$(du -sh "$KDIR" 2>/dev/null | cut -f1)
        echo "Perms   : $KPERMS"
        echo "Size    : $KSIZE"
        echo "Status  : EXISTS"
    else
        echo "Status  : NOT FOUND (may not be installed)"
    fi
done

echo ""
echo "============================================================"
echo "  SECURITY NOTE:"
echo "  /etc        — config files. Root-owned. Wrong perms = risk."
echo "  /tmp        — world-writable. Malware staging area if unwatched."
echo "  /boot       — kernel lives here. Should NOT be world-writable."
echo "  /lib/modules — kernel modules. Must be root-owned for integrity."
echo "============================================================"

# --- Check /proc/version for running kernel info (kernel exposes this) ---
echo ""
echo "--- Live Kernel Info from /proc/version ---"
if [ -f /proc/version ]; then
    cat /proc/version   # /proc/version contains the full kernel build string
else
    echo "/proc not available on this system."
fi

echo "============================================================"
