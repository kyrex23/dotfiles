# Param 1 (optional): name of the generated file (default: $DEFAULT_FILENAME)
function new-script() {
	local -r TEMPLATE_FILE="$HOME/Plantillas/bash-script.tpl" # Template must be located at this path
	local -r DEFAULT_FILENAME="new-script.sh"

	local -r filename="${1:-$DEFAULT_FILENAME}"

	if [ ! -f "$TEMPLATE_FILE" ]; then
		echo "Missing required file: $TEMPLATE_FILE"
		return 1
	fi

	cp "$TEMPLATE_FILE" "$filename" && \
	# Add the current date to the header
	sed -i -E "s#Date:([[:space:]])*#Date:   $(date +%d/%m/%Y)#" "$filename"
}


function ginit() {
	local -r GIT_TEMPLATES="$HOME/Plantillas/git"

	echo "Copying init files to this directory..."
	for file in $GIT_TEMPLATES/{.*,*}; do
		cp $file ./ && echo "  File [$file] copied: OK"
	done
	echo "Init files copied successfully. Creating repository..."

	git init
}

function bt-connect() {
	local device="$(bluetoothctl devices | fzf --height 30%)"
	local mac_address="$(awk '{print $2}' <<< $device)"

	bluetoothctl connect "$mac_address"
}
