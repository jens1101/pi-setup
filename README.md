# Intro

This project serves as setup for my Raspberry Pi network server. This is a
set of scripts that need to be copied to the installation medium of Raspberry
Pi OS which will then do the setup automatically. This means that after the Pi
is reachable via SSH then it's setup and ready to go; no user intervention
required.

This project is based on [pi-boot-script](https://gitlab.com/JimDanner/pi-boot-script/-/tree/master).

The following is automatically been set up:

- Time zone
- Expansion of the file system
- Setting a static IP for the Pi
- Setting up Docker and docker-compose
- Installation and automatic setup of the following via docker-compose:
  - pihole
  - qbittorrent
  - samba

# Setup

1. Copy "sample.env" to "setup-files/.env" and change any of the environment
   variables as needed.
2. Setup a SD card with Rasberry Pi OS Lite via
   [Raspberry Pi Imager](https://www.raspberrypi.org/software/).
3. After the setup is completed mount the SD card again.
4. Open the "boot" partition.
5. Edit "cmdline.txt".
6. Remove the item with `init=` (if it is there) and put the following at the
   end of the line:
   ```
   init=/bin/bash -c "mount -t proc proc /proc; mount -t sysfs sys /sys; mount /boot; source /boot/unattended"
   ```
7. Copy all the files in "setup-files/" to the root of the boot partition.
8. Remove the SD card from your machine.
9. Insert it into the Raspberry Pi and wait.
10. Typically when the green LED stops flashing then the setup is completed.
