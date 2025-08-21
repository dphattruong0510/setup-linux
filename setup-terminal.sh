#!/usr/bin/env bash
# Script to set up Nord theme + JetBrains Mono font for GNOME Terminal

set -e

PROFILE_NAME="Nord"
PROFILE_SLUG="nord-theme"
FONT="JetBrains Mono 12"

# Nord color palette
BG_COLOR="#2E3440"
FG_COLOR="#D8DEE9"
PALETTE="#3B4252:#BF616A:#A3BE8C:#EBCB8B:#81A1C1:#B48EAD:#88C0D0:#E5E9F0:#4C566A:#BF616A:#A3BE8C:#EBCB8B:#81A1C1:#B48EAD:#8FBCBB:#ECEFF4"

# Helper for gsettings
dset() {
    gsettings set "$1" "$2" "$3"
}

# Find default profile
DEFAULT_PROFILE=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')

# Create new profile
uuid=$(uuidgen)
gsettings set org.gnome.Terminal.ProfilesList list \
    "$(gsettings get org.gnome.Terminal.ProfilesList list | sed "s/]$/, '$uuid']/")"

# Copy settings from default
dconf dump /org/gnome/terminal/legacy/profiles:/:$DEFAULT_PROFILE/ | \
dconf load /org/gnome/terminal/legacy/profiles:/:$uuid/

# Apply Nord settings
dset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ visible-name "'$PROFILE_NAME'"
dset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ use-theme-colors "false"
dset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ background-color "'$BG_COLOR'"
dset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ foreground-color "'$FG_COLOR'"
dset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ palette "['${PALETTE//:/','}']"
dset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$uuid/ font "'$FONT'"

echo "✅ Nord theme with $FONT installed as new GNOME Terminal profile!"
echo "👉 Open GNOME Terminal → Preferences → select profile '$PROFILE_NAME'"
