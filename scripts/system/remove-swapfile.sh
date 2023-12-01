#!/usr/bin/bash

# ======================================================================================================================
# Disables the swapfile and removes it from /etc/fstab
# A backup of /etc/fstab is created before deleting /swapfile from it
#
# Author: kyrex23
# Date:   23/10/2022 
# ======================================================================================================================

set -euo pipefail

# ----------------------------------------------------------------------------------------------------------------------

SWAPFILE="/swapfile"

FSTAB="/etc/fstab"
FSTAB_BKP="$FSTAB.bkp"

# ----------------------------------------------------------------------------------------------------------------------

# Disable swapfile if it is enabled
echo "Disabling swapfile..."
if swapon --show | grep --quiet ^$SWAPFILE; then
	sudo swapoff $SWAPFILE && echo "✅ Swap area '$SWAPFILE' disabled"
else
	echo "⚠️  $SWAPFILE was already disabled"
fi
echo


# Remove the swapfile if exists
echo "Removing the file: $SWAPFILE..."
if [ -f $SWAPFILE ]; then
	sudo rm -f $SWAPFILE  && echo "✅ File '$SWAPFILE' removed"
else
	echo "⚠️  File '$SWAPFILE' not found"
fi
echo


# Remove lines used to load the swapfile in boot
echo "Unloading $SWAPFILE from $FSTAB..."
if grep --quiet ^$SWAPFILE $FSTAB; then
	sudo cp $FSTAB $FSTAB_BKP && echo "✅ Backup of $FSTAB created in: $FSTAB_BKP"
	
	sudo sed -i "\#$SWAPFILE#d" $FSTAB
else
	echo "⚠️  $SWAPFILE not found in $FSTAB"
fi
echo

echo "✅ Completed successfully"
