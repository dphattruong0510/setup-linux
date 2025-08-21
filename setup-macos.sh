#!/bin/bash
set -e

sudo apt update
sudo apt install -y wget unzip fonts-firacode fonts-noto fonts-dejavu

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# SF Pro
wget -O sf-pro.zip "https://github.com/sahibjotsaggu/San-Francisco-Pro-Fonts/archive/refs/heads/master.zip"
unzip -o sf-pro.zip
mv San-Francisco-Pro-Fonts-master/*.otf ./
rm -rf San-Francisco-Pro-Fonts-master sf-pro.zip

# SF Mono
wget -O sf-mono.zip "https://github.com/ZulwiyozaPutra/SF-Mono-Font/archive/refs/heads/master.zip"
unzip -o sf-mono.zip
mv SF-Mono-Font-master/*.otf ./
rm -rf SF-Mono-Font-master sf-mono.zip

# Inter
wget -O inter.zip "https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip"
unzip -o inter.zip -d inter-fonts
find inter-fonts -type f -name "*.ttf" -exec mv {} . \;
rm -rf inter.zip inter-fonts

# Refresh font cache
fc-cache -fv

# Apply fonts to GNOME
gsettings set org.gnome.desktop.interface font-name "SF Pro Display 11"
gsettings set org.gnome.desktop.interface document-font-name "SF Pro Text 11"
gsettings set org.gnome.desktop.interface monospace-font-name "SF Mono 12"
gsettings set org.gnome.desktop.wm.preferences titlebar-font "SF Pro Display Bold 11"

echo "✅ Fonts giống macOS (SF Pro, SF Mono, Inter) đã được cài đặt và áp dụng!"
