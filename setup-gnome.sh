#!/bin/bash
set -e

sudo apt update && sudo apt upgrade -y
sudo apt install -y gnome-shell gnome-tweaks gnome-shell-extensions gnome-extensions-app curl wget git build-essential dconf-cli unzip arc-theme papirus-icon-theme yaru-theme-gtk yaru-theme-icon yaru-theme-sound fonts-firacode fonts-ubuntu fonts-dejavu fonts-noto vlc gimp htop neofetch

install_gnome_extension() {
    URL=$1
    TEMP=$(mktemp -d)
    wget -qO- "$URL" > "$TEMP/extension.zip"
    unzip -q "$TEMP/extension.zip" -d "$TEMP/ext"
    UUID=$(grep "uuid" "$TEMP/ext/metadata.json" | cut -d\" -f4)
    mkdir -p ~/.local/share/gnome-shell/extensions/$UUID
    cp -r "$TEMP/ext/"* ~/.local/share/gnome-shell/extensions/$UUID/
    gnome-extensions enable "$UUID"
    rm -rf "$TEMP"
}

install_gnome_extension "https://extensions.gnome.org/extension-data/caffeinejerryb.zip"
install_gnome_extension "https://extensions.gnome.org/extension-data/dash-to-dockgnome-shell-extensions.zip"
install_gnome_extension "https://extensions.gnome.org/extension-data/blur-my-shellaunetx.zip"
install_gnome_extension "https://extensions.gnome.org/extension-data/material-shellgcampbell.zip"
install_gnome_extension "https://extensions.gnome.org/extension-data/topiconsplusphw.zip"
install_gnome_extension "https://extensions.gnome.org/extension-data/gsconnectandy.zip"
install_gnome_extension "https://extensions.gnome.org/extension-data/nightthemesgsconnect.zip"

gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'LEFT'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height true
gsettings set org.gnome.shell.extensions.blur-my-shell enable-blur true
gsettings set org.gnome.shell.extensions.blur-my-shell transparency-level 0.5
gsettings set org.gnome.shell.extensions.material-shell workspaces-mode 'dynamic'
gsettings set org.gnome.shell.extensions.top-icons-plus enable true
gsettings set org.gnome.shell.extensions.nightthemesgsconnect auto-night-mode true

echo "Hoàn tất setup. Reload GNOME Shell hoặc logout/login để áp dụng."

