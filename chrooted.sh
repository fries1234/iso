#!/usr/bin/env bash
echo "Chrooted in the new system, running as $(whoami)"

# User setup
useradd -mG wheel crystal
usermod -p $(echo "crystal" | openssl passwd -6 -stdin) crystal
usermod -p $(echo "crystal" | openssl passwd -6 -stdin) root
chsh -s /usr/bin/zsh crystal

# Desktop icon for Jade's GUI
mkdir -p /home/crystal/Desktop
cp /usr/share/applications/Jade.desktop /home/crystal/Desktop/Install.desktop
chown -R crystal:crystal /home/crystal/

# Services
systemctl enable NetworkManager
systemctl enable reflector
systemctl enable gdm
systemctl enable jade-gui

# Hostname and Locale
echo "crystal-live" > /etc/hostname
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "Configured the system. Exiting chroot."
