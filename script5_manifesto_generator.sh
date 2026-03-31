#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: [Your Name] | Reg No: [Your Reg No]
# Course: Open Source Software | Capstone Project
# Software Choice: Linux Kernel
# Description: Interactively asks the user 3 questions and
#              generates a personalised open source philosophy
#              statement, saved to a .txt file.
# ============================================================

# --- Aliases concept demonstrated ---
# In a real session you might run: alias today='date +%d-%B-%Y'
# Here we show the concept in a comment and use the full command below.
# alias today='date +%d-%B-%Y'   # Example alias for date formatting

# --- Colour codes for prettier terminal output ---
# These are ANSI escape codes: \e[1;32m = bold green, \e[0m = reset
GREEN="\e[1;32m"
CYAN="\e[1;36m"
YELLOW="\e[1;33m"
RESET="\e[0m"

echo -e "${CYAN}"
echo "============================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR"
echo "       Linux Kernel — OSS Capstone Project"
echo "============================================================"
echo -e "${RESET}"
echo "Answer three questions honestly. Your answers will be woven"
echo "into a personalised open source philosophy statement."
echo ""

# --- Question 1: Tool they use daily ---
# read -p displays a prompt and stores input in the variable
read -p "1. Name one open-source tool you use every day: " TOOL

# Validate that the user didn't leave it blank
while [ -z "$TOOL" ]; do
    echo "   Please enter a tool name."
    read -p "1. Name one open-source tool you use every day: " TOOL
done

# --- Question 2: What freedom means to them ---
read -p "2. In one word, what does 'freedom' mean to you in software? " FREEDOM

while [ -z "$FREEDOM" ]; do
    echo "   Please enter one word."
    read -p "2. In one word, what does 'freedom' mean to you? " FREEDOM
done

# --- Question 3: What they would build and share ---
read -p "3. Name one thing you would build and share freely: " BUILD

while [ -z "$BUILD" ]; do
    echo "   Please enter something you'd build."
    read -p "3. Name one thing you would build and share freely: " BUILD
done

# --- Gather metadata ---
DATE=$(date '+%d %B %Y')           # e.g. 01 January 2025
AUTHOR=$(whoami)                    # Linux username
OUTPUT="manifesto_${AUTHOR}.txt"   # Output filename based on username

echo ""
echo -e "${YELLOW}Generating your manifesto...${RESET}"
echo ""

# --- Compose the manifesto using string concatenation with echo and >> ---
# > creates/overwrites the file; >> appends subsequent lines

# Write header to file (> creates fresh file)
echo "============================================================" > "$OUTPUT"
echo "  OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Author : $AUTHOR" >> "$OUTPUT"
echo "  Date   : $DATE" >> "$OUTPUT"
echo "  Course : Open Source Software — Linux Kernel Audit" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Write the personalised paragraph by concatenating the user's answers
echo "I believe in the power of open source because every day," >> "$OUTPUT"
echo "tools like $TOOL remind me that the best software is built" >> "$OUTPUT"
echo "not behind locked doors, but in the open — where anyone can" >> "$OUTPUT"
echo "read it, question it, improve it, and share it." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "To me, $FREEDOM is the most important thing software can offer." >> "$OUTPUT"
echo "Not freedom as a marketing word, but the actual ability to" >> "$OUTPUT"
echo "look inside a program, understand what it does, and change it" >> "$OUTPUT"
echo "when it doesn't serve you. The Linux Kernel was built on this" >> "$OUTPUT"
echo "principle in 1991, and it remains its most enduring promise." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "If I were to contribute to the open source world, I would build" >> "$OUTPUT"
echo "$BUILD and release it freely — because the programmers who built" >> "$OUTPUT"
echo "Linux, Git, Firefox, and Python did not ask for permission to" >> "$OUTPUT"
echo "change the world. They just shared their work, and the world changed." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Standing on the shoulders of giants means understanding that the" >> "$OUTPUT"
echo "tools we use today were gifts from people who chose openness over" >> "$OUTPUT"
echo "profit. The least we can do is pass that gift forward." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "------------------------------------------------------------" >> "$OUTPUT"
echo "  Signed: $AUTHOR | $DATE" >> "$OUTPUT"
echo "============================================================" >> "$OUTPUT"

# --- Confirm and display ---
echo -e "${GREEN}Manifesto saved to: $OUTPUT${RESET}"
echo ""
echo "============================================================"
cat "$OUTPUT"   # Print the file contents to terminal
echo "============================================================"
echo ""
echo "To view it again anytime, run:  cat $OUTPUT"
echo "To share it:                    cat $OUTPUT | mail -s 'My Manifesto' you@example.com"
