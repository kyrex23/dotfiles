#!/usr/bin/bash

# ======================================================================================================================
# Install JetBrains Toolbox App
#
# The Toolbox App can be manually installed by following this steps:
# 1. Download the archive file from the original website: https://www.jetbrains.com/toolbox-app/
# 2. Extract the archive file which contains:
#    .- jetbrains-toolbox-version/
#       └- jetbrains-toolbox
# 3. Run the `jetbrains-toolbox` binary extracted (Toolbox App icon is automatically added to the main menu)
#
# The Toolbox App can be automatically installed by using this script.
# It allows you to install the application in a local or global (root required) environment
# - Local installation (selected by default)
#   - Installation path  --> $HOME/.local/share/JetBrains/Toolbox/bin
#   - Symbolic link path --> $HOME/.local/bin
# - Global installation (root required)
#   - Installation path  --> /opt/JetBrains/Toolbox/bin
#   - Symbolic link path --> /usr/local/bin
#
# The Toolbox App is configured to autostart after installing it (see: $HOME/.config/autostart/)
#
# Author: kyrex23
# Date:   02/12/2023
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

LOCAL_INSTALL_DIR="$HOME/.local/share/JetBrains/Toolbox/bin"
GLOBAL_INSTALL_DIR="/opt/JetBrains/Toolbox/bin"

LOCAL_SYMLINK_DIR="$HOME/.local/bin"
GLOBAL_SYMLINK_DIR="/usr/local/bin"

DOWNLOADS_DIR="/tmp"

USAGE_MESSAGE="""
Usage: $(basename $0) [OPTIONS]

[OPTIONS]
  -g, --global
    Install the application globally

  -t, --target <dir>
    Select the directory to store the downloaded archive file (default: $DOWNLOADS_DIR)

  -h, --help
    Display this help message
"""

TB_RELEASE_URL='https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release'
ARCHIVE_URL=$(curl --silent $TB_RELEASE_URL | jq --raw-output '.TBA[0].downloads.linux.link')
# Alternative to get the download url without using jq
#ARCHIVE_URL=$(curl -s $TB_RELEASE_URL | grep -Po '"linux":.*?[^\\]",' | cut -d ':' -f3- | sed 's/[",]//g')

ARCHIVE_FILENAME=$(basename $ARCHIVE_URL)
BINARY_FILE="jetbrains-toolbox"

# ----------------------------------------------------------------------------------------------------------------------

global_install=0
output_dir="$DOWNLOADS_DIR"

while [[ $# -gt 0 ]]; do
	case $1 in
		-h| --help)
			echo "$USAGE_MESSAGE"
			exit 0
			;;
		-g| --global)
			global_install=1
			shift
			;;
		-t| --target)
			output_dir=$2
			shift; shift
			;;
		*)
			echo "❌ Unknown option: '$1'"
			echo "$USAGE_MESSAGE"
			exit 1
			;;
	esac
done

echo "Downloading archive file from $ARCHIVE_URL..."
wget --quiet --show-progress --continue --output-document="$output_dir/$ARCHIVE_FILENAME" "$ARCHIVE_URL"
echo "✅ File downloaded --> $output_dir/$ARCHIVE_FILENAME"
echo

# ----- Set variables depending on local/global installation -----
SUDO=""
install_dir="$LOCAL_INSTALL_DIR"
symlink_dir="$LOCAL_SYMLINK_DIR"
if [[ $global_install -eq 1 ]]; then
	SUDO="sudo"
	install_dir="$GLOBAL_INSTALL_DIR"
	symlink_dir="$GLOBAL_SYMLINK_DIR"
fi

echo "Extracting $output_dir/$ARCHIVE_FILENAME..."
$SUDO mkdir -p $install_dir
$SUDO tar -xzf $output_dir/$ARCHIVE_FILENAME -C $install_dir --strip-components=1
$SUDO chmod +x $install_dir/$BINARY_FILE
echo "✅ File extracted -> $install_dir/$BINARY_FILE"
echo

echo "Creating a symlink for $install_dir/$BINARY_FILE..."
$SUDO ln -sf $install_dir/$BINARY_FILE -t $symlink_dir
echo "Symlink created --> $symlink_dir/$BINARY_FILE"
echo

echo "✅ Toolbox App installed!"
echo

if [[ -z "${CI+x}" ]]; then
	echo "Running the application to set-up..."
	( "$install_dir/$BINARY_FILE" & )
	echo "✅ Done! JetBrains Toolbox is running"
else
	echo "✅ Done! Running in a CI, skipped launching the AppImage"
fi
echo
