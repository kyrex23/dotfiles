#!/usr/bin/bash

# ======================================================================================================================
# Download a zip file containing a requested NerdFont from Github and install it
# - Fonts installed for the current user will be located into ~/.local/share/fonts
# - Fonts installed for all the users will be located into /usr/local/share/fonts (recommended over /usr/share/fonts)
#
# Author: kyrex23
# Date:   12/05/2023
# ======================================================================================================================

set -eo pipefail # -u option cannot be enabled due to possible undefined variables

shopt -s extglob # required for expanded regex in case statement

# ----------------------------------------------------------------------------------------------------------------------

DEFAULT_VERSION="v3.0.0"

USAGE_MESSAGE="""
Usage: $(basename $0) <command>

  [COMMANDS]

  install <font> [<options>] -- Download the given font and install it

    [Options]

      -v, --version <version>
        Select the version of the font to download (by default: $DEFAULT_VERSION)

      -o, --output  <file>
        Select the destination file for the downloaded font (default: <current_dir>/<font>.zip)

      -g, --global
        Install the font globally (require root permissions)

  list -- List all the available fonts to download

  help -- Display this help message
"""

FONTS=(
	"3270"
	"Agave"
	"AnonymousPro"
	"Arimo"
	"AurulentSansMono"
	"BigBlueTerminal"
	"BitstreamVeraSansMono"
	"CascadiaCode"
	"CodeNewRoman"
	"ComicShannsMono"
	"Cousine"
	"DaddyTimeMono"
	"DejaVuSansMono"
	"DroidSansMono"
	"FantasqueSansMono"
	"FiraCode"
	"FiraMono"
	"FontPatcher"
	"Go-Mono"
	"Gohu"
	"Hack"
	"Hasklig"
	"HeavyData"
	"Hermit"
	"iA-Writer"
	"IBMPlexMono"
	"Inconsolata"
	"InconsolataGo"
	"InconsolataLGC"
	"Iosevka"
	"IosevkaTerm"
	"JetBrainsMono"
	"Lekton"
	"LiberationMono"
	"Lilex"
	"Meslo"
	"Monofur"
	"Monoid"
	"Mononoki"
	"MPlus"
	"NerdFontsSymbolsOnly"
	"Noto"
	"OpenDyslexic"
	"Overpass"
	"ProFont"
	"ProggyClean"
	"RobotoMono"
	"ShareTechMono"
	"SourceCodePro"
	"SpaceMono"
	"Terminus"
	"Tinos"
	"Ubuntu"
	"UbuntuMono"
	"VictorMono"
)

# ----------------------------------------------------------------------------------------------------------------------

if [[ $# -lt 1 ]]; then
	echo "❌ Missing required argument: <command>"
	echo "$USAGE_MESSAGE"
	exit 1
fi

command="$1"; shift

case $command in
	list)
		printf '%s\n' "${FONTS[@]}"
		exit 0
		;;
	help)
		echo "$USAGE_MESSAGE"
		exit 0
		;;
	!(install))
		echo "❌ Invalid command: $command"
		exit 1
		;;
esac

BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download"
GLOBAL_INSTALL_PATH="/usr/local/share/fonts"
LOCAL_INSTALL_PATH="$HOME/.local/share/fonts"

while [[ $# -gt 0 ]]; do
	case $1 in
		-v|--version)
			[[ -z $2 ]] && echo "❌ Missing <version> argument" && exit 1
			version="$2"
			shift; shift
			;;
		-o|--output)
			[[ -z $2 ]] && echo "❌ Missing <dir> argument" && exit 1
			output_file="$2"
			shift; shift
			;;
		-g|--global)
			global_install=1
			shift
			;;
		-*|--*)
			echo "❌ Unknown option: '$1'" && exit 1
			;;
		*)
			[[ ! -z "$font" ]] && echo "❌ Multiple <font> arguments are not available: ('$font' '$1')" && exit 1
			font="$1"
			shift
			;;
	esac
done

[[ -z "$font" ]] && echo "❌ Missing required argument <font>" && exit 1
[[ ! " ${FONTS[@]} " =~ " $font " ]] && echo "❌ Selected font is not available: '$font'" && exit 1

# Download the font
font_zip="$font.zip"
output_file="${output_file:-./$font_zip}"
download_url="$BASE_URL/${version:-$DEFAULT_VERSION}/$font_zip"

echo "Downloading font from '$download_url'..."
wget --quiet --output-document="$output_file" "$download_url"
echo "✅ Font '$font' downloaded to '$output_file': OK"
echo

[[ -n $global_install ]] && install_path="$GLOBAL_INSTALL_PATH" || install_path="$LOCAL_INSTALL_PATH"
# Create the install_path if it does not exist
if [[ ! -d "$install_path" ]]; then
	echo "Creating the path '$install_path'..."
	mkdir -p $install_path
	echo "✅ Path '$install_path' created: OK"
	echo
fi

[[ "$global_install" -eq 1 ]] && SUDO="sudo" || SUDO=""
echo "Installing the font in '$install_path'..."
$SUDO unzip -q ${output_file:-$font_zip} -d $install_path/$font
echo "✅ Font '$font' installed: OK"
echo

echo "Reloading cache..."
fc-cache -f
echo "✅ Cache updated: OK"
echo
