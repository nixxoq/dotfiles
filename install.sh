#!/bin/bash

# PROGRAM OPTIONS
DEBUG_MODE=0
SKIP_UPDATE=0
curr_date=$(date +%Y%m%d-%H%M%S)
current_dir=$(pwd)
KEYMAP_SETUP=0
ALL_ARGS="$@"
FORCE_REDOWNLOAD=0
AGS=0

# functions

is_root() {
    if [[ $EUID -eq 0 ]]; then
        return 0
    else
        return 1
    fi
}

is_arch_based() {
    local distro_name=$(cat /etc/os-release | grep ^ID= | cut -d= -f2)
    if [[ $distro_name == "arch" || $distro_name == "cachyos" || $distro_name == "endeavouros" || $distro_name == "artix" ]]; then
        return 0
    else
        return 1
    fi
}

is_package_installed() {
    local package_name="$1"
    if pacman -Q "$package_name" >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

confirm() {
    gum confirm "$1"
}

log_message() {
    local type="$1"
    local message="$2"
    case "$type" in
    OK)
        gum style --foreground 2 "[OK] $message"
        ;;
    INFO)
        gum style --foreground 4 "[INFO] $message"
        ;;
    ERROR)
        gum style --foreground 1 --bold "[ERROR] $message"
        ;;
    WARN)
        gum style --foreground 3 "[WARN] $message"
        ;;
    DEBUG)
        if [ "$DEBUG_MODE" -eq 1 ]; then
            gum style --foreground 3 "[DEBUG] $message"
        fi
        ;;
    *)
        echo "$message"
        ;;
    esac
}

get_command_args() {
    for arg in $ALL_ARGS; do
        case $arg in
        --debug)
            DEBUG_MODE=1
            log_message DEBUG "Enabling debug mode..."
            ;;
        --skip-update)
            log_message INFO "Skipping system update..."
            SKIP_UPDATE=1
            ;;
        --configure-keymap)
            log_message INFO "Configuring keymap..."
            KEYMAP_SETUP=1
            ;;
        --force-redownload)
            log_message INFO "Forcing re-download of dotfiles if folder exists..."
            FORCE_REDOWNLOAD=1
            ;;
        --help)
            printf "%sUsage: $0 [--debug] [--skip-update]\n"
            printf "%s\t--debug: Enable debug mode.\n"
            printf "%s\t--skip-update: Skip system update.\n"
            printf "%s\t--configure-keymap: Configure keymap.\n"
            printf "%s\t--force-redownload: Re-download dotfiles if folder exists.\n"
            printf "%s\t--help: Show this help message.\n"
            exit 0
            ;;
        *)
            log_message WARN "Unknown argument: $arg. Skipping..."
            ;;
        esac
    done
}

install_package() {
    for package in "$@"; do
        if ! is_package_installed "$package"; then
            sudo pacman --noconfirm -S "$package"
        else
            log_message INFO "$package is already installed."
        fi
    done
}

install_package_aur() {
    for package in "$@"; do
        if ! is_package_installed "$package"; then
            paru --noconfirm -S "$package"
        else
            log_message INFO "$package is already installed."
        fi
    done
}

remove_package() {
    for package in "$@"; do
        if is_package_installed "$package"; then
            sudo pacman --noconfirm -R "$package"
        else
            log_message INFO "$package is not installed."
        fi
    done
}

backup_config() {
    local config_name="$1"
    if [ "$config_name" == "qt_theme" ]; then
        backup_config "qt5ct"
        backup_config "qt6ct"
        return
    fi
    local config_path="$HOME/.config/$config_name"
    local backup_path="$HOME/backups/${config_name}_$curr_date"

    echo "Backing up $config_name..."
    if [ ! -d "$config_path" ]; then
        echo "$config_name config was not found. Skipping"
        return
    fi
    mkdir -p "$backup_path"
    cp -r "$config_path" "$backup_path"
}

select_to_backup() {
    options=("kitty" "HyprPanel" "zsh" "Kvantum" "neovim" "paru" "qt_theme" "ranger" "rofi" "pywal" "waybar" "waypaper" "hyprland")

    echo "Select configs which you want to backup (use arrow keys to navigate, space to select, enter to confirm):"

    selected=$(printf "%s\n" "${options[@]}" | gum choose --no-limit)

    clear
    for opt in $selected; do
        backup_config "$opt"
    done
}

if is_root; then
    echo "Please run as a non-root user."
    exit 1
fi

if ! is_arch_based; then
    echo "This script is only for Arch-based systems."
    exit 1
fi

install_package "gum" "git" "base-devel"

get_command_args

# update system
if [ "$SKIP_UPDATE" -eq 0 ]; then
    log_message INFO "Updating system..."
    sudo pacman --noconfirm -Syu
fi

if [ "$KEYMAP_SETUP" -eq 1 ]; then
    log_message INFO "Setting up keymap configuration..."
    if ! command -v python &>/dev/null; then
        log_message ERROR "Python is not installed. Installing..."
        install_package "python"
    fi

    log_message INFO "Downloading keyboard setup script..."
    temp_file=$(mktemp)
    if curl -sL "https://raw.githubusercontent.com/nixxoq/dotfiles/v2/extras/keyboard_setup.py" -o "$temp_file"; then
        python "$temp_file"
        rm "$temp_file"
        log_message OK "Keymap configuration completed."
        exit 0
    else
        log_message ERROR "Failed to download keyboard setup script."
        rm "$temp_file"
        exit 1
    fi
fi

select_to_backup

confirm "Now, we will install the dotfiles. Continue?" || exit 0

# install paru (aur helper) if not installed
if ! is_package_installed "paru"; then
    log_message INFO "Installing paru (AUR helper), please wait..."
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin
    makepkg --noconfirm --install --syncdeps
    cd ..
    rm -rf paru
fi

# install pre-requisites for dotfiles
install_package_aur "ttf-jetbrains-mono" "ttf-jetbrains-mono-nerd" "htop" "bat" "dolphin" "clipse-bin" "egl-wayland" "eza" "hyprland" "hyprlang" "hyprlock" "hypridle" "hyprcursor" "hyprswitch" "jq" "kitty" "kitty-shell-integration" "kitty-terminfo" "lib32-wayland" "noto-fonts" "otf-material-design-icons" "pacman-contrib" "pamixer" "pavucontrol" "pipewire" "pipewire-pulse" "pipwire-jack" "pipewire-audio" "polkit-gnome" "pywal-git" "rofi-lbonn-wayland-git" "wmctrl" "ranger" "sddm" "swww" "waybar" "wl-clipboard" "wlogout" "xdg-desktop-portal" "xdg-desktop-portal-wlr" "xdg-user-dirs" "zsh" "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting" "noto-color-emoji-fontconfig" "ttf-liberation" "zip" "unzip" "qt6ct" "qt5ct" "kvantum" "kvantum-qt5" "arc-kde" "arc-gtk-theme" "dconf" "dconf-editor" "firefox" "geany" "gtk3" "gtk4" "gtk4-layer-shell" "hicolor-icon-theme" "htop" "hypo-candy" "waypaper" "papirus-icon-theme"

# install dotfiles
log_message INFO "Cloning dotfiles..."
if [ "$FORCE_REDOWNLOAD" -eq 1 ]; then
    rm -rf "$HOME/dotfiles"
fi
git clone https://github.com/nixxoq/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"

log_message INFO "Copying configuration files..."
cp -r config/cava "$HOME/.config/"
cp -r config/hypr "$HOME/.config/"
cp -r config/hyprdots "$HOME/.config/"
cp -r config/HyprPanel "$HOME/.config/"
cp -r config/kitty "$HOME/.config/"
cp -r config/Kvantum "$HOME/.config/"
cp -r config/menus "$HOME/.config/"
cp -r config/neofetch "$HOME/.config/"
cp -r config/nvim "$HOME/.config/"
cp -r config/paru "$HOME/.config/"
cp -r config/qt5ct "$HOME/.config/"
cp -r config/qt6ct "$HOME/.config/"
cp -r config/ranger "$HOME/.config/"
cp -r config/rofi "$HOME/.config/"
cp -r config/wal "$HOME/.config/"
cp -r config/waybar "$HOME/.config/"
cp -r config/waypaper "$HOME/.config/"
cp -r config/code-flags.conf "$HOME/.config/"
cp -r config/electron-flags.conf "$HOME/.config/"
cp -r config/settings.dconf "$HOME/.config/"

log_message INFO "Copying required home files..."
cp -r home/.zshrc "$HOME/.zshrc"
cp -r home/cache "$HOME/.cache"

log_message INFO "Copying cursor..."
mkdir -p "$HOME/.local/share/icons"
cp -r cursor/* "$HOME/.local/share/icons"

confirm "Do you want prefer using ags instead of waybar?" && AGS=1

if [ "$AGS" -eq 1 ]; then
    log_message INFO "Installing AGS..."
    curl -fsSL https://bun.sh/install | bash && sudo ln -s $HOME/.bun/bin/bun /usr/local/bin/bun
    install_package_aur "libgtop" "bluez" "bluez-utils" "btop" "htop" "networkmanager" "dart-sass" "brightnessctl" "swww" "python" "gnome-bluetooth-3.0" "power-profiles-daemon" "grimblast-git" "gpu-screen-recorder" "hyprpicker" "matugen-bin" "python-gpustat" "aylurs-gtk-shell-git"

    cp -r $HOME/dotfiles/Hyprpanel $HOME/.config/
    ln -s $HOME/.config/Hyprpanel $HOME/.config/ags
    bash "$HOME/.config/ags/install_fonts.sh"
    bash "$HOME/.config/ags/make_agsv1.sh"

    echo "exec-once = ags" >>$HOME/.config/hypr/config/launch.conf
    log_message INFO "AGS && Hyprpanel installed successfully."
else
    log_message INFO "Applying waybar configuration..."
    echo "exec-once = waybar" >>$HOME/.config/hypr/config/launch.conf
    log_message INFO "Waybar installed successfully."
fi

log_message INFO "Finalizing steps..."

cd $HOME
rm -rf $HOME/dotfiles

log_message OK "Dotfiles installed successfully."
log_message INFO "Do not forget to run these commands after logging in hyprland:"
log_message INFO "hyprpm -v update"
log_message INFO "hyprpm add https://github.com/KZDKM/Hyprspace"
log_message INFO "hyprpm enable Hyprspace"

remove_package "gum"
