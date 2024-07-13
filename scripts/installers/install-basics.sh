#!/usr/bin/bash

# ==============================================================================
# This script installs some basic utilities
#
# Author: kyrex23
# Date:   24/10/2022
# ==============================================================================

# Uncomment the following line to stop script when a command fails
# This causes partial execution when some command is already installed
#set -euo pipefail

# ------------------------------------------------------------------------------

function install_command() {
	local -r command="${1:-}"

	if [ -z "$command" ]; then
		echo "Missing required argument: $0 <command>"
		return 1
	fi

	if [ -x "$(command -v $command)" ]; then
		echo "Command '$command' was already installed: $(command -v $command)"
		return 2
	fi

	local -r installer="${2:-$command}"
	sudo apt install "$installer"
}

# ------------------------------------------------------------------------------

sudo apt update

# Install privative extras (ex: ttf-mscorefonts, codecs, ...) for Ubuntu
sudo apt install ubuntu-restricted-extras

# Install gnome-sushi (preview files pressing spacebar)
sudo apt install gnome-sushi


# Install flatpak, its plugin and add the flathub repository
flathub_repository='https://flathub.org/repo/flathub.flatpakrepo'
install_command flatpak && \
sudo apt install gnome-software-plugin-flatpak && \
flatpak remote-add --if-not-exists flathub $flathub_repository

# ------------------------------------------------------------------------------

# Install zsh
install_command zsh

# Install gnome-tweaks
install_command gnome-tweaks

# Install neofetch
install_command neofetch

# Install tlp & tlp-rdw (power management tool)
install_command tlp
install_command tlp-rdw
sudo systemctl enable tlp 	# Enable the tlp service

# Install tree
install_command tree

# Install curl
install_command curl

# Install 7z
install_command 7z p7zip-full

# ------------------------------------------------------------------------------

# Install bat (the binary is batcat on Ubuntu due to naming conflicts)
install_command batcat bat

# Create a symlink ~/.local/bin/cat for /usr/bin/batcat
if [ ! -L ~/.local/bin/cat ]; then
	mkdir -p ~/.local/bin
	ln -s $(which batcat) ~/.local/bin/bat
fi

# ------------------------------------------------------------------------------

# Install qBittorrent (latest stable version from its ppa)
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
sudo apt update && sudo apt install qbittorrent -y

# ------------------------------------------------------------------------------

# Cleaning commands at the end
sudo apt autoremove --purge		# Remove unused dependencies
sudo apt autoclean				# Clean partial packages
sudo apt clean					# Clean-up apt-cache
