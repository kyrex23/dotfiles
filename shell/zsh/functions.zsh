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
		cp -r $file ./ && echo "  File [$file] copied: OK"
	done
	echo "Init files copied successfully. Creating repository..."

	git init

	echo "Installing github workflows..."
	mv github .github
	echo "Github workflows installed: OK"

	echo "Installing git hooks..."
	mv git/hooks/* .git/hooks/ && rm -rf git
	echo "Git hooks installed: OK"
}

function bt-connect() {
	local device="$(bluetoothctl devices | fzf --height 30%)"
	local mac_address="$(awk '{print $2}' <<< $device)"

	bluetoothctl connect "$mac_address"
}

function download-repository() {
	if [ "$#" -lt "2" ]; then
		echo "Missing some argument. Usage: <user> <repository> [<branch>]"
		return 1
	fi
	local -r user="$1"
	local -r repository="$2"
	local -r branch="${3:-main}"
	local -r url="https://github.com/$user/$repository/archive/$branch.zip"
	wget "$url"
}
