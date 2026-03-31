#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: [Your Name] | Reg No: [Your Reg No]
# Course: Open Source Software | Capstone Project
# Software Choice: Linux Kernel
# Description: Reads a log file line by line, counts keyword
#              occurrences, prints last 5 matches, and retries
#              if the file is empty.
# Usage: ./script4_log_analyzer.sh [logfile] [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Accept arguments; provide defaults if not given ---
LOGFILE=${1:-"/var/log/syslog"}     # Default log: syslog (common on Ubuntu)
KEYWORD=${2:-"error"}               # Default keyword to search for

COUNT=0           # Counter for matching lines
MAX_RETRY=3       # Maximum retries if file is empty
RETRY=0           # Current retry count

echo "============================================================"
echo "   LOG FILE ANALYZER"
echo "   File    : $LOGFILE"
echo "   Keyword : $KEYWORD"
echo "============================================================"

# --- Check that the file exists before doing anything ---
if [ ! -f "$LOGFILE" ]; then
    echo "ERROR: File '$LOGFILE' not found."
    echo "Try one of these common Linux log files:"
    echo "  /var/log/syslog       (Ubuntu/Debian)"
    echo "  /var/log/messages     (Fedora/RHEL)"
    echo "  /var/log/kern.log     (kernel messages)"
    echo "  /var/log/dmesg        (boot/hardware messages)"
    exit 1
fi

# --- do-while style retry loop: keep trying if file appears empty ---
# In bash, a do-while is simulated with: while true; do ... ; done with a break condition
while true; do
    # Check if the file has any content (wc -l counts lines)
    LINE_COUNT=$(wc -l < "$LOGFILE")

    if [ "$LINE_COUNT" -eq 0 ]; then
        RETRY=$((RETRY + 1))    # Increment retry counter
        echo "WARNING: $LOGFILE appears to be empty. Retry $RETRY of $MAX_RETRY..."
        sleep 1                  # Wait 1 second before retrying

        # If we've exhausted retries, exit gracefully
        if [ "$RETRY" -ge "$MAX_RETRY" ]; then
            echo "File is still empty after $MAX_RETRY retries. Exiting."
            exit 1
        fi
    else
        break   # File has content — exit the retry loop
    fi
done

echo "File has $LINE_COUNT lines. Scanning for '$KEYWORD'..."
echo ""

# --- Read file line by line using while-read loop ---
# IFS= preserves leading/trailing whitespace; -r prevents backslash interpretation
while IFS= read -r LINE; do
    # grep -iq: -i = case-insensitive, -q = quiet (no output, just return code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment match counter
    fi
done < "$LOGFILE"   # Redirect file into the while loop as input

# --- Print summary ---
echo "============================================================"
echo "RESULT: Keyword '$KEYWORD' found $COUNT time(s) in $LOGFILE"
echo "============================================================"

# --- Print last 5 matching lines using grep + tail ---
echo ""
echo "--- Last 5 lines containing '$KEYWORD' ---"
if grep -i "$KEYWORD" "$LOGFILE" | tail -5; then
    :   # colon is a no-op; grep already printed output above
else
    echo "(No matching lines found)"
fi

echo ""

# --- Bonus: Kernel-specific log check ---
# The kernel writes messages to /var/log/kern.log or via dmesg
echo "============================================================"
echo "   KERNEL LOG BONUS — Recent kernel messages (dmesg)"
echo "============================================================"
echo "Searching dmesg output for '$KEYWORD'..."
echo ""

# dmesg reads the kernel ring buffer (live kernel messages)
DMESG_COUNT=$(dmesg 2>/dev/null | grep -ic "$KEYWORD")

if [ "$DMESG_COUNT" -gt 0 ]; then
    echo "Found $DMESG_COUNT match(es) for '$KEYWORD' in kernel ring buffer."
    echo "Last 5 kernel messages containing '$KEYWORD':"
    dmesg 2>/dev/null | grep -i "$KEYWORD" | tail -5
else
    echo "No matches for '$KEYWORD' found in kernel ring buffer (dmesg)."
fi

echo ""
echo "TIP: For kernel boot messages, run: dmesg | less"
echo "     For real-time kernel logs, run: sudo journalctl -k -f"
echo "============================================================"
