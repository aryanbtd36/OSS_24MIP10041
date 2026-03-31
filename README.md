# The Open Source Audit: Git

**Course:** Open Source Software (NGMC) | VIT Bhopal University | AY 2025-26  
**Student:** Aryan Mishra| Registration No. 24MIP10041
  

---

## Table of Contents

- [Project Overview](#project-overview)
- [Report Summary](#report-summary)
- [Shell Scripts](#shell-scripts)
- [Prerequisites](#prerequisites)
- [How to Run](#how-to-run)
- [Project Structure](#project-structure)
- [References](#references)
- [License](#license)

---

## Project Overview

This project is a complete audit of Git, the world's most widely used distributed version control system. It examines Git not just as a technical tool, but as a case study in why open source software matters — tracing its origin, its license, its ethics, its Linux footprint, and comparing it against its closest proprietary alternative.

The project has two main deliverables: a written audit report and five practical Linux shell scripts that demonstrate hands-on system administration and Bash scripting skills.

---

## Report Summary

**1. Origin and History**  
Git was created in 2005 by Linus Torvalds after the Linux kernel team lost access to BitKeeper overnight due to a licensing dispute. Torvalds wrote the first working version in approximately ten days. Git was designed to be fast, fully distributed, and cryptographically secure. Today over 93% of professional developers use it.

**2. The GPL v2 License**  
Git is released under the GNU General Public License version 2. This license gives every user four freedoms: to run the software for any purpose, to study and modify it, to redistribute copies, and to distribute modified versions provided those modifications also remain open source. This copyleft clause is what prevents anyone from taking Git, improving it, and releasing a closed proprietary version.

**3. Ethics of Open Source**  
The report examines whether it is ethical to build profitable businesses on community-maintained infrastructure, using GitHub's acquisition by Microsoft for 7.5 billion dollars as a case study. It also explores the broader question of whether shared infrastructure should always be open, and argues that tools an entire industry depends on should not be owned by any single vendor.

**4. Git on Linux**  
This section covers how Git is installed and managed on major Linux distributions, its directory structure after installation, how it handles user permissions using the principle of least privilege, how it integrates with existing system services rather than running as its own daemon, and how security patches are disclosed and distributed through a fully public and auditable process.

**5. Git vs Perforce Helix Core**  
A side-by-side comparison of Git and Perforce Helix Core across cost, security, freedom to modify, community governance, handling of large binary files, and vendor lock-in risk. The conclusion is that Git is the right choice for almost any software development context, with Perforce having a genuine advantage only in workflows centered around very large binary assets.

---

## Shell Scripts

All five scripts are located in the sh_codes directory of this repository.

**Script 1 - System Identity Report**  
Displays key information about the Linux system including distribution name, kernel version, architecture, hostname, logged-in user, uptime, and current date and time. Also prints the license that covers the Linux kernel and summarizes the four GPL freedoms. Demonstrates variables, command substitution, conditional file checks, and formatted output.

**Script 2 - FOSS Package Inspector**  
Checks whether a given package is installed on the system and displays version and maintainer details. Works on both Debian and Ubuntu systems using dpkg, and on Fedora and RHEL systems using rpm. Prints a short philosophy note about the package using a case statement. Demonstrates if-then-else logic, command detection, nested conditionals, and pattern matching.

**Script 3 - Disk and Permission Auditor**  
Loops through a set of important Linux system directories and prints a formatted table showing disk usage, permissions, owner, and group for each one. Also checks Git-specific installation paths and detects whether the current directory contains a Git repository. Demonstrates Bash arrays, for loops, disk usage commands, and column-aligned output formatting.

**Script 4 - Log File Analyzer**  
Accepts a log file path and a search keyword as command-line arguments. Reads the file line by line, counts how many lines contain the keyword, calculates the match percentage, and prints the last five matching lines. Includes a retry mechanism if the file path is invalid. Demonstrates while read loops, command-line arguments, parameter expansion, integer arithmetic, and do-while style retry logic.

**Script 5 - Open Source Manifesto Generator**  
Asks the user three interactive questions about their relationship with open source software, then composes a personalized philosophy statement and saves it to a text file named after the current user. Demonstrates interactive input with read, input validation, string interpolation, and writing output to files.

---

## Prerequisites

- A Linux operating system such as Ubuntu, Debian, Fedora, Arch Linux, or openSUSE
- Bash shell
- Standard Linux core utilities including grep, awk, sed, df, ls, stat, uptime, whoami, and date

No additional packages need to be installed on a standard modern Linux system.

---

## How to Run

Step 1 - Navigate to the project root directory and make all scripts executable.

Step 2 - Run each script using the bash command followed by the script path.

    Script 1 displays system identity and license information.
    Script 2 inspects the Git package installation on your system.
    Script 3 audits key system directories and Git-specific paths.
    Script 4 takes a log file path and a search keyword as arguments.
    Script 5 runs interactively and saves a manifesto text file on completion.

Detailed usage examples and argument descriptions are available inside each script as comments at the top of the file.

---

## Project Structure

    Linux_OSS_Git/
    |
    |-- sh_codes/
    |   |-- script1_system_identity.sh
    |   |-- script2_package_inspector.sh
    |   |-- script3_disk_permission_auditor.sh
    |   |-- script4_log_analyzer.sh
    |   |-- script5_manifesto_generator.sh
    |
    |-- project_report.pdf
    |-- README.md
    |-- LICENSE

---


