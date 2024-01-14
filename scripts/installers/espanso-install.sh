#!/usr/bin/bash

# ======================================================================================================================
# Install `espanso` - A multiplatform text-expander to use system-wide code snippets:
# - https://espanso.org
# - https://github.com/espanso/espanso
#
# Author: kyrex23
# Date:   14/01/2024
# ======================================================================================================================

# To know the session type, run: `echo $XDG_SESSION_TYPE`
SESSION_TYPE="x11"

# The current latest version is: v2.2.1
DEFAULT_VERSION="latest"

GITHUB_BASE_URL="https://github.com/federico-terzi/espanso"
EXECUTABLE_FILENAME="espanso-debian-$SESSION_TYPE-amd64.deb"

DOWNLOAD_URL="$GITHUB_BASE_URL/releases/$DEFAULT_VERSION/download/$EXECUTABLE_FILENAME"

wget --quiet "$DOWNLOAD_URL"
sudo apt install ./$EXECUTABLE_FILENAME

espanso service register
espanso start
