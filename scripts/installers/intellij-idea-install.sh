#!/usr/bin/bash

# ======================================================================================================================
# Install IntelliJ IDEA Community (latest stable) from the official repository
#
# Author: kyrex23
# Date:   01/11/2022
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

PPA_REPOSITORY="mmk2410/intellij-idea"

# ----------------------------------------------------------------------------------------------------------------------

# Add repository if not already added
if ! add-apt-repository --list | grep --quiet "$PPA_REPOSITORY"; then
	sudo add-apt-repository "ppa:$PPA_REPOSITORY" -y
fi

# Update packages and install/update intellij-idea-community stable
sudo apt update && sudo apt install intellij-idea-community -y
