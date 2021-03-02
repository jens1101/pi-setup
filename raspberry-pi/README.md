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

# Troubleshooting

## Cannot connect to SAMBA share

This typically happens when the folder SAMBA is trying to share does not exist.
For example if you are sharing an external hard drive and it fails to mount then
the SAMBA share will fail too. To fix this specific scenario do the following:

1. Run `sudo shutdown -h now`
2. Unplug your Raspberry Pi
3. Plug it back in and make sure that the hard drive spins up. You can typically
   hear and feel the vibrations as the disks spin up.
   - If this doesn't work then try another USB port
   - If you are using a hard drive without its own power supply then your Pi's
     power supply might not be powerful enough. It is recommended to use an
     official Raspberry Pi power supply or a hard drive with it's own power
     supply.
4. Once the Pi is booted then SSH to the Pi and make sure that the hard drive
   is mounted.
5. The SAMBA share should now be accessible. If not then continue.
6. `cd docker-setup/`
7. `docker-compose stop`
8. `docker-compose start -d`
9. After a moment the share should now be accessible.
