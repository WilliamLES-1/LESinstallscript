#!/bin/bash

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Remove GNOME Bloat
sudo apt purge -y gnome-calendar gnome-camera gnome-characters gnome-clocks gnome-connections gnome-disk-utility gnome-extensions-app gnome-maps gnome-music gnome-software totem
sudo apt autoremove -y

# Installing from apt's repository
sudo apt install -y libreoffice-writer libreoffice-calc libreoffice-draw libreoffice-impress tuxpaint tuxtype tuxmath kanagram gimp flatpak icecat lightdm

# Setting up Flatpak for software unavailable or too old in apt's repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub org.gcompris.GCompris
flatpak install -y flathub org.scratch.Scratch
flatpak install -y flathub org.ungoogled.chromium.Chromium
flatpak install -y flathub com.vscodium.codium

# If the GNOME Display Manager is active (0), stop and disable it to avoid conflicts with lightdm
if systemctl is-active --quiet gdm3; then
    sudo systemctl stop gdm3
    sudo systemctl disable gdm3
fi

# If lightdm isn't active (1), enable it to start at boot
if ! systemctl is-active --quiet lightdm; then
    sudo systemctl enable lightdm
fi

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Update Flatpak packages
flatpak update

# Start lightdm
sudo systemctl start lightdm


