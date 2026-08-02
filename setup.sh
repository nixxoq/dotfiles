#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "\n\033[1;33m[1/5] Setting up GURU repository and gpo...\033[0m"

echo "Installing app-portage/eselect-repository, dev-vcs/git, and app-portage/gpo..."
sudo emerge --noreplace app-portage/eselect-repository dev-vcs/git app-portage/gpo

if ! eselect repository list -i | grep -q "guru"; then
    echo "Enabling GURU overlay..."
    sudo eselect repository enable guru
    echo "Syncing GURU overlay..."
    sudo emaint sync -r guru
else
    echo "GURU overlay is already enabled."
fi

echo -e "\n\033[1;33m[2/5] Checking dependencies...\033[0m"
DEPS=(
    "x11-base/xorg-server"
    "x11-libs/libX11"
    "x11-libs/libXinerama"
    "x11-libs/libXft"
    "media-libs/fontconfig"
    "x11-misc/xdotool"
    "app-misc/brightnessctl"
    "app-misc/ddcutil"
    "x11-misc/xwallpaper"
    "gnome-extra/polkit-gnome"
    "x11-misc/dunst"
    "media-gfx/flameshot"
    "x11-misc/clipmenu"
    "x11-misc/copyq"
    "net-misc/curl"
    "media-video/pipewire"
)

echo "The following packages are required for your setup:"
for dep in "${DEPS[@]}"; do
    echo "  - $dep"
done

read -p "Do you want to run 'emerge' to install them now? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo emerge --ask --noreplace "${DEPS[@]}"
else
    echo "Skipping dependency installation. (Make sure you have them installed!)"
fi

echo -e "\n\033[1;33m[3/5] Compiling dwm and dwmblocks...\033[0m"

if [ -d "$REPO_DIR/dwm" ]; then
    echo "Building dwm..."
    cd "$REPO_DIR/dwm"
    make clean
    sudo make install
else
    echo "Warning: dwm directory not found in $REPO_DIR"
fi

if [ -d "$REPO_DIR/dwmblocks" ]; then
    echo "Building dwmblocks..."
    cd "$REPO_DIR/dwmblocks"
    make clean
    sudo make install
else
    echo "Warning: dwmblocks directory not found in $REPO_DIR"
fi

echo -e "\n\033[1;33m[4/5] Creating symlinks for scripts...\033[0m"
if [ -d "$REPO_DIR/usr/local/bin" ]; then
    for script in "$REPO_DIR/usr/local/bin/"*; do
        if [ -f "$script" ]; then
            script_name=$(basename "$script")
            chmod +x "$script"
            echo "Symlinking $script_name => /usr/local/bin/$script_name"
            sudo ln -sf "$script" "/usr/local/bin/$script_name"
        fi
    done
else
    echo "Warning: usr/local/bin directory not found in $REPO_DIR"
fi

echo -e "\n\033[1;35m[5/5] Setting up DWM desktop entry...\033[0m"
sudo mkdir -p /usr/share/xsessions
if [ -f "$REPO_DIR/utils/dwm.desktop" ]; then
    echo "Symlinking dwm.desktop => /usr/share/xsessions/dwm.desktop"
    sudo ln -sf "$REPO_DIR/utils/dwm.desktop" "/usr/share/xsessions/dwm.desktop"
else
    echo "Warning: utils/dwm.desktop not found in $REPO_DIR"
fi

WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$WALLPAPER_DIR"

if [ -f "$REPO_DIR/wp.png" ]; then
    echo "Symlinking wp.png => $WALLPAPER_DIR/1.png"
    ln -sf "$REPO_DIR/wp.png" "$WALLPAPER_DIR/1.png"
else
    echo "Warning: wp.png not found in $REPO_DIR"
fi

echo -e "Setup complete!"