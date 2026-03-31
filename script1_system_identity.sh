#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: [Your Name] | Reg No: [Your Reg No]
# Course: Open Source Software | Capstone Project
# Software Choice: Linux Kernel
# Description: Displays a formatted welcome screen showing
#              key system information and license details.
# ============================================================

# --- Student Info (fill these in) ---
STUDENT_NAME="Aryan Mishra"
REG_NUMBER="24MIP10041"
SOFTWARE_CHOICE="Linux Kernel"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                        # Full kernel version string
ARCH=$(uname -m)                          # System architecture (x86_64, etc.)
USER_NAME=$(whoami)                        # Currently logged-in user
HOME_DIR=$HOME                             # Home directory of current user
UPTIME=$(uptime -p)                        # Human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y')      # e.g. Monday, 01 January 2025
CURRENT_TIME=$(date '+%H:%M:%S')          # 24-hour current time
HOSTNAME=$(hostname)                       # Machine hostname

# --- Detect Linux distribution name ---
# /etc/os-release is the standard file for distro identification
if [ -f /etc/os-release ]; then
    DISTRO=$(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown Linux Distribution"
fi

# --- License information for the Linux Kernel ---
KERNEL_LICENSE="GNU General Public License version 2 (GPL v2)"
LICENSE_MEANING="You are free to run, study, modify, and redistribute this OS."

# --- Display the report ---
echo "================================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY REPORT"
echo "================================================================"
echo " Student  : $STUDENT_NAME ($REG_NUMBER)"
echo " Project  : $SOFTWARE_CHOICE"
echo "----------------------------------------------------------------"
echo " Hostname : $HOSTNAME"
echo " Distro   : $DISTRO"
echo " Kernel   : $KERNEL"
echo " Arch     : $ARCH"
echo "----------------------------------------------------------------"
echo " User     : $USER_NAME"
echo " Home Dir : $HOME_DIR"
echo " Uptime   : $UPTIME"
echo " Date     : $CURRENT_DATE"
echo " Time     : $CURRENT_TIME"
echo "----------------------------------------------------------------"
echo " OS License : $KERNEL_LICENSE"
echo " What this means:"
echo "   $LICENSE_MEANING"
echo "================================================================"
echo " The Linux Kernel — built openly, shared freely, runs the world."
echo "================================================================"
