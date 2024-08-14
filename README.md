

# Born2BeRoot

## Table of Contents
1. [Project Overview](#project-overview)
2. [Requirements](#requirements)
3. [Virtual Machine Setup](#virtual-machine-setup)
4. [Partitioning](#partitioning)
5. [User and Group Management](#user-and-group-management)
6. [Security Configuration](#security-configuration)
7. [System Monitoring and Logs](#system-monitoring-and-logs)
8. [Grading Checklist](#grading-checklist)
9. [Useful Commands](#useful-commands)
10. [Resources](#resources)

## Project Overview

**Born2BeRoot** is a system administration project designed to familiarize you with fundamental Linux concepts and commands. In this project, you will be required to set up a virtual machine (VM), configure its partitions, manage users and groups, set up security measures, and ensure system monitoring through logs and services.

### Objectives:
- Set up and configure a Linux system on a virtual machine.
- Properly partition the disk.
- Configure users and groups, and set appropriate security settings.
- Implement security measures such as firewall configuration and sudo rules.
- Ensure that the system is properly monitored and logs are configured.

## Requirements

- A working installation of VirtualBox or UTM (Mac users).
- You can choose between **Debian** or **CentOS** (This guide will use Debian for examples).
- Install and configure essential services like SSH and UFW.
- Set up proper partitioning schemes with LVM.
- Implement system monitoring with cron jobs or monitoring tools.

## Virtual Machine Setup

### 1. Installing the Virtual Machine:
- Download the Debian/CentOS ISO from their official website.
- Install VirtualBox (or UTM) and create a new VM.
  - **Name:** Born2BeRoot
  - **Type:** Linux
  - **Version:** Debian (64-bit) / CentOS (64-bit)
  - **Memory Size:** Minimum 1024MB (1GB) recommended.
  - **Hard Disk:** Use VDI (VirtualBox Disk Image) with a dynamically allocated size of around 10GB.

### 2. OS Installation:
- Boot your VM using the downloaded ISO.
- Follow the installation steps.
- Set up your root and standard user accounts.

### 3. Configure Networking:
- Ensure the VM is using a bridged adapter or NAT for internet access.

## Partitioning

### 1. Partition Scheme:
- You need to create the following partitions:
  - **/ (root):** Main partition where your system is installed (minimum 5GB).
  - **swap:** Space for swapping memory (1GB recommended).
  - **/home:** Partition for user data (2GB or more).
  - **/var:** For system logs and variable data (1GB or more).
  - **/boot:** Partition for boot files (512MB).

### 2. LVM (Logical Volume Management):
- Set up LVM to manage disk partitions more flexibly. Use LVM to create, resize, and manage partitions.

Example commands to set up LVM:
```bash
# Create a physical volume
sudo pvcreate /dev/sdaX

# Create a volume group
sudo vgcreate vg_name /dev/sdaX

# Create logical volumes for root, home, var, and swap
sudo lvcreate -L 5G -n root_lv vg_name
sudo lvcreate -L 1G -n swap_lv vg_name
sudo lvcreate -L 2G -n home_lv vg_name
sudo lvcreate -L 1G -n var_lv vg_name
```

## User and Group Management

### 1. User Setup:
- Create a new user and set up appropriate permissions using `sudo`:
```bash
sudo adduser username
sudo usermod -aG sudo username
```

- Modify sudo permissions:
```bash
sudo visudo
```
Uncomment the line to allow passwordless sudo for your user:
```bash
username ALL=(ALL:ALL) NOPASSWD:ALL
```

### 2. Group Management:
- Create groups and assign users:
```bash
sudo groupadd groupname
sudo usermod -aG groupname username
```

- Ensure correct permissions for group directories using `chown` and `chmod`.

## Security Configuration

### 1. UFW (Uncomplicated Firewall):
- Install and configure UFW:
```bash
sudo apt install ufw
sudo ufw allow OpenSSH
sudo ufw enable
```

- Verify firewall status:
```bash
sudo ufw status
```

### 2. SSH Configuration:
- Edit the SSH config file for security (`/etc/ssh/sshd_config`):
  - Disable root login: `PermitRootLogin no`
  - Change the default SSH port (e.g., 2222): `Port 2222`
  - Enable public key authentication for enhanced security.

```bash
sudo systemctl restart sshd
```

### 3. Password Policies:
- Configure password policies to ensure strong password requirements. Modify `/etc/login.defs` and `/etc/security/pwquality.conf` to set parameters such as minimum password length and expiration.

### 4. Sudo Rules:
- Ensure that only specific users can run certain commands with `sudo`. Edit `/etc/sudoers` or create a custom sudoers file for specific users.

## System Monitoring and Logs

### 1. Cron Jobs:
- Set up cron jobs to schedule tasks like updates, backups, or monitoring scripts.
```bash
crontab -e
```

Example cron job to update the system every day at midnight:
```bash
0 0 * * * sudo apt update && sudo apt upgrade -y
```

### 2. Log Management:
- Ensure logs are properly configured in `/var/log`.
- Use `journalctl` to check logs and monitor services.

## Grading Checklist

Here’s a checklist of what should be covered before submitting your project:

- [ ] Virtual Machine is properly configured.
- [ ] Partitioning scheme includes `/`, `swap`, `/home`, `/var`, and `/boot`.
- [ ] LVM is set up for flexible partition management.
- [ ] SSH is configured and working.
- [ ] Firewall (UFW) is set up and rules are defined.
- [ ] Password policies are correctly implemented.
- [ ] User and group management is properly configured.
- [ ] System monitoring with cron jobs and logging is active.
- [ ] The VM is secure against unauthorized access.

## Useful Commands

### System Information:
- `uname -a`: Displays system information.
- `df -h`: Shows disk space usage.
- `free -h`: Displays memory and swap usage.
- `lscpu`: Information about CPU architecture.

### User and Group Commands:
- `useradd`, `usermod`, `groupadd`, `groups`: Manage users and groups.

### File Permissions:
- `chown`, `chmod`: Change file ownership and permissions.

### Monitoring:
- `top`, `htop`: Real-time process monitoring.
- `journalctl`: View system logs.

## Resources

- [Debian Documentation](https://www.debian.org/doc/)
- [CentOS Documentation](https://www.centos.org/docs/)
- [Linux Command Cheat Sheet](https://www.gnu.org/software/coreutils/manual/html_node/index.html)
- [UFW Documentation](https://help.ubuntu.com/community/UFW)
- [Systemd Services](https://www.freedesktop.org/wiki/Software/systemd/)
```