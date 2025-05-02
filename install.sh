#!/bin/bash
# ----------------------------------------------------------------------------
# Copyright (C) 2025  William Aktaa
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
# ----------------------------------------------------------------------------


# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Remove GNOME Bloat
sudo apt purge -y gnome-calendar gnome-camera gnome-characters gnome-clocks gnome-connections gnome-disk-utility gnome-extensions-app gnome-maps gnome-music gnome-software totem
sudo apt autoremove -y

# Installing from apt's repository
sudo apt install -y libreoffice-writer libreoffice-calc libreoffice-draw libreoffice-impress tuxpaint tuxtype tuxmath kanagram gimp flatpak icecat lightdm

# Setting up Flatpak for software unavailable or too old in apt's repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub org.gcompris.GCompris
flatpak install flathub org.scratch.Scratch
flatpak install flathub org.ungoogled.chromium.Chromium
flatpak install flathub com.vscodium.codium

# If the GNOME Display Manager is active (0), stop and disable it to avoid conflicts with lightdm
if systemctl is-active --quiet gdm3; then
    sudo systemctl stop gdm3
    sudo systemctl disable gdm3
fi

# If lightdm isn't active (1), enable it to start at boot
if ! systemctl is-active --quiet lightdm; then
    sudo systemctl enable lightdm
fi

# SSH into local server, fetch credentials, and pass it to lightdm

# Start lightdm
sudo systemctl start lightdm

# Update and upgrade packages
sudo apt update && sudo apt upgrade -y

# Update Flatpak packages
flatpak update
