#1/bin/bash

#
# PROGRAM OPTIONS
#
DEBUG_MODE=0
SKIP_UPDATE=0
MEDIA_DEPENDS=0
DEV_DEPENDS=0
SET_KITTY_AS_DEFAULT=0
curr_date=$(date +%Y%m%d-%H%M%S)
current_dir=$(pwd)

# check if the script is running as root
# if [[ $EUID -eq 0 ]]; then
#     echo "Please run this script without root access."
#     exit 1
# fi

# check if the script is running on Arch
if [[ $(uname -r | grep arch) == "" ]]; then
    echo "This script is only for Arch Linux based distributions."
    exit 1
fi

#############
# FUNCTIONS #
#############

# prompt for confirmation
confirm() {
    while true; do
        read -r -p "$1 [y/N] " response
        case $response in
        [yY][eE][sS] | [yY])
            return 0
            ;;
        [nN][oO] | [nN])
            return 1
            ;;
        *)
            echo "Invalid response. Please enter 'y' or 'n'."
            ;;
        esac
    done
}

# print debug information
debug() {
    if [[ $DEBUG_MODE -eq 1 ]]; then
        echo "[DEBUG] $1"
    fi
}

# check if internet connection is available
check_internet() {
    if [[ $(ping -c 1 -W 1 archlinux.org &>/dev/null) -eq 0 ]]; then
        echo "[INFO] Internet connection is available."
    else
        echo "[INFO] Internet connection is not available. Aborting."
        exit 1
    fi
}

# get all command line arguments
get_command_args() {
    for arg in "$@"; do
        case $arg in
        --debug)
            echo "[DEBUG] Enabling debug mode..."
            DEBUG_MODE=1
            ;;
        --skip-update)
            echo "[INFO] Skipping system update..."
            SKIP_UPDATE=1
            ;;
        --media)
            debug "Adding media dependencies..."
            MEDIA_DEPENDS=1
            ;;
        --dev)
            debug "Adding development dependencies..."
            DEV_DEPENDS=1
            ;;
        --help)
            printf "%sUsage: $0 [--debug] [--skip-update]\n"
            printf "%s\t--debug: Enable debug mode.\n"
            printf "%s\t--skip-update: Skip system update.\n"
            printf "%s\t--media: Install media dependencies.\n"
            printf "%s\t--help: Show this help message.\n"
            exit 0
            ;;
        *)
            debug "Unknown argument: $arg. Skipping..."
            ;;
        esac
    done
}

# check if command line argument is in list
check_arg() {
    local search_arg="$1"
    shift

    for cmd in "$@"; do
        if [[ "$cmd" == "$search_arg" ]]; then
            return 0
        fi
    done

    return 1
}

# update the system
update_system() {
    if [[ $SKIP_UPDATE -ne 1 ]]; then
        echo "Updating system..."
        sudo pacman -Syyu --noconfirm
    fi
}

# check if package is installed
check_package() {
    if pacman -Qq "$1" >/dev/null 2>&1; then
        printf "\e[32m[INFO] $1 is already installed.\e[0m\n"
    else
        printf "\e[34m[INFO] $1 is not installed. Installing...\e[0m"
        sudo pacman -S --noconfirm "$1" >/dev/null 2>&1 &&
            # printf "\r$(tput el)\e[32m[INFO] $1 has been installed.\e[0m\n"
            printf "\n\e[32m[INFO] $1 has been installed.\e[0m\n"
    fi
}

#############
#  BACKUPS  #
#############

backup_alacritty() {
    echo "Backing up alacritty..."
    if [ ! -d $HOME/.config/alacritty ]; then
        echo "alacritty config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/alacritty_$curr_date
    mv $HOME/.config/alacritty $HOME/backups/alacritty_$curr_date
}

backup_kitty() {
    echo "Backing up kitty..."
    if [ ! -d $HOME/.config/kitty ]; then
        echo "kitty config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/kitty_$curr_date
    cp -r $HOME/.config/kitty $HOME/backups/kitty_$curr_date
}

backup_neovim() {
    echo "Backing up neovim..."
    if [ ! -d $HOME/.config/nvim ]; then
        echo "neovim config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/neovim_$curr_date
    mv $HOME/.config/nvim $HOME/backups/neovim_$curr_date
}

backup_bspwm() {
    echo "Backing up bspwm..."
    if [ ! -d $HOME/.config/bspwm ]; then
        echo "bspwm config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/bspwm_$curr_date
    mv $HOME/.config/bspwm $HOME/backups/bspwm_$curr_date
}

backup_picom() {
    echo "Backing up picom..."
    if [ ! -d $HOME/.config/picom ]; then
        echo "picom config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/picom_$curr_date
    mv $HOME/.config/picom $HOME/backups/picom_$curr_date
}

backup_rofi() {
    echo "Backing up rofi..."
    if [ ! -d $HOME/.config/rofi ]; then
        echo "rofi config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/rofi_$curr_date
    mv $HOME/.config/rofi $HOME/backups/rofi_$curr_date
}

backup_eww() {
    echo "Backing up eww..."
    if [ ! -d $HOME/.config/eww ]; then
        echo "eww config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/eww_$curr_date
    mv $HOME/.config/eww $HOME/backups/eww_$curr_date
}

backup_sxhkd() {
    echo "Backing up sxhkd..."
    if [ ! -d $HOME/.config/sxhkd ]; then
        echo "sxhkd config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/sxhkd_$curr_date
    mv $HOME/.config/sxhkd $HOME/backups/sxhkd_$curr_date
}

backup_dunst() {
    echo "Backing up dunst..."
    if [ ! -d $HOME/.config/dunst ]; then
        echo "dunst config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/dunst_$curr_date
    mv $HOME/.config/dunst $HOME/backups/dunst_$curr_date
}

backup_polybar() {
    echo "Backing up polybar..."
    if [ ! -d $HOME/.config/polybar ]; then
        echo "polybar config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/polybar_$curr_date
    mv $HOME/.config/polybar $HOME/backups/polybar_$curr_date
}

backup_ncmpcpp() {
    echo "Backing up ncmpcpp..."
    if [ ! -d $HOME/.config/ncmpcpp ]; then
        echo "ncmpcpp config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/ncmpcpp_$curr_date
    mv $HOME/.config/ncmpcpp $HOME/backups/ncmpcpp_$curr_date
}

backup_ranger() {
    echo "Backing up ranger..."
    if [ ! -d $HOME/.config/ranger ]; then
        echo "ranger config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/ranger_$curr_date
    mv $HOME/.config/ranger $HOME/backups/ranger_$curr_date
}

backup_tmux() {
    echo "Backing up tmux..."
    if [ ! -d $HOME/.config/tmux ]; then
        echo "tmux config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/tmux_$curr_date
    mv $HOME/.config/tmux $HOME/backups/tmux_$curr_date
}

backup_zsh() {
    echo "Backing up zsh..."
    if [ ! -d $HOME/.config/zsh ]; then
        echo "zsh config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/zsh_$curr_date
    mv $HOME/.config/zsh $HOME/backups/zsh_$curr_date
}

backup_mpd() {
    echo "Backing up mpd..."
    if [ ! -d $HOME/.config/mpd ]; then
        echo "mpd config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/mpd_$curr_date
    mv $HOME/.config/mpd $HOME/backups/mpd_$curr_date
}

backup_paru() {
    echo "Backing up paru..."
    if [ ! -d $HOME/.config/paru ]; then
        echo "paru config was not found. Skipping"
        return
    fi
    mkdir -p $HOME/backups/paru_$curr_date
    mv $HOME/.config/paru $HOME/backups/paru_$curr_date
}

display_menu() {
    local i
    tput -T xterm sc
    for i in "${!options[@]}"; do
        local checked="${selected[*]} "
        local symbol=" "
        if [[ $i -eq $cursor ]]; then
            symbol=">"
        fi

        [[ $checked =~ ${options[$i]} ]] && symbol="${symbol} [x]" || symbol="${symbol} [ ]"

        printf "\r${symbol} %s\n" "${options[$i]}"
    done
    tput -T xterm rc
}

multiselect() {
    local input
    local item
    options=("$@")

    while true; do
        display_menu

        IFS= read -rsn1 input

        case "$input" in
        $'\x1b')
            IFS= read -rsn2 input
            case "$input" in
            '[A') # Up arrow
                ((cursor--))
                if [[ $cursor -lt 0 ]]; then cursor=0; fi
                ;;
            '[B') # Down arrow
                ((cursor++))
                if [[ $cursor -ge ${#options[@]} ]]; then cursor=$((${#options[@]} - 1)); fi
                ;;
            esac
            ;;
        ' ') # Space (Select/Deselect)
            item="${options[$cursor]}"
            if [[ " ${selected[@]} " =~ " ${item} " ]]; then
                selected=("${selected[@]/$item/}")
            else
                selected+=("$item")
            fi
            ;;
        '') # Enter
            break
            ;;
        esac
    done
}

# backup configs
select_configs() {
    options=("alacritty" "kitty" "neovim" "bspwm" "polybar" "sxhkd" "dunst" "ncmpcpp" "ranger" "tmux" "zsh" "mpd" "paru" "eww" "rofi")
    selected=()
    index=0

    echo "Select configs which you want to backup (space to select, enter to confirm):"

    multiselect "${options[@]}"

    clear
    echo "Selected options:"
    for opt in "${selected[@]}"; do
        case "$opt" in
        "alacritty")
            backup_alacritty
            ;;
        "kitty")
            backup_kitty
            ;;
        "neovim")
            backup_neovim
            ;;
        "bspwm")
            backup_bspwm
            ;;
        "polybar")
            backup_polybar
            ;;
        "sxhkd")
            backup_sxhkd
            ;;
        "dunst")
            backup_dunst
            ;;
        "ncmpcpp")
            backup_ncmpcpp
            ;;
        "ranger")
            backup_ranger
            ;;
        "tmux")
            backup_tmux
            ;;
        "zsh")
            backup_zsh
            ;;
        "mpd")
            backup_mpd
            ;;
        "paru")
            backup_paru
            ;;
        "eww")
            backup_eww
            ;;
        "rofi")
            backup_rofi
            ;;
        esac
    done
}

# copy configs
copy_configs() {
    [[ ! -d $HOME/.config ]] && mkdir -p $HOME/.config
    [[ ! -d $HOME/.local/bin ]] && mkdir -p $HOME/.local/bin
    [[ ! -d $HOME/.local/share ]] && mkdir -p $HOME/.local/share

    echo "Installing required packages..."
    install_packages "git"

    echo "Cloning dotfiles"

    git clone --depth=1 https://github.com/nixxoq/dotfiles.git $HOME/dotfiles
    sleep 1

    for dir in $HOME/dotfiles/config/*; do
        dirname=$(basename "$dir")

        cp -r "$dir" ~/.config && echo "Copied $dirname" || echo "Failed to copy $dirname"
    done

    for dir in $HOME/dotfiles/home/* $HOME/dotfiles/home/.*; do
        [[ "$dir" == "$HOME/dotfiles/home/." || "$dir" == "$HOME/dotfiles/home/.." ]] && continue

        dirname=$(basename "$dir")

        cp -r "$dir" ~ && echo "Copied $dirname" || echo "Failed to copy $dirname"
    done
}


# install packages
install_packages() {
    # split " " and for-loop each package
    IFS=" " read -ra packages <<<"$1"

    for package in "${packages[@]}"; do
        check_package "$package"
        sleep 0.1
    done
}

# main

check_internet
get_command_args "$@"

update_system

install_packages "xdg-user-dirs"

if [ ! -e $HOME/.config/user-dirs.dirs ]; then
    xdg-user-dirs-update
fi

echo "Installing base packages..."
sleep 0.5

# Base packages

# only base: bspwm, sxhkd, polybar, alacritty, pacman-contrib, papirus-icon-theme
# physlock, polkit-gnome, python-gobject, ranger, redshift, rofi,
# ttf-inconsolata, ttf-jetbrains-mono, ttf-jetbrains-mono-nerd,
# ttf-joypixels, ttf-terminus-nerd ueberzug webp-pixbuf-loader xclip xdg-user-dirs
# xdo xdotool xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot
# xorg-xwininfo

install_packages "\
    bspwm sxhkd polybar alacritty pacman-contrib papirus-icon-theme \
    physlock polkit-gnome python-gobject ranger redshift rofi ttf-inconsolata \
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-joypixels ttf-terminus-nerd \
    ueberzug webp-pixbuf-loader xclip xdg-user-dirs xdo xdotool xorg-xdpyinfo \
    xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot xorg-xwininfo jq
"

confirm "Do you want to install brightness control?" && install_packages "brightnessctl"

if [[ $? -eq 1 ]]; then
    echo "Skipping brightness control installation..."
    sleep 0.5
fi

if [[ $MEDIA_DEPENDS -eq 0 && ! $(check_arg "--media" "$@") ]]; then
    confirm "Do you want to install media packages?" && MEDIA_DEPENDS=1
fi

if [[ $MEDIA_DEPENDS -eq 1 ]]; then
    echo "Installing media packages..."
    sleep 0.5

    install_packages "\
        gvfs-mtp geany imagemagick bat \
        mpc mpd ncmpcpp pamixer
    "
else
    echo "Skipping media packages installation..."
    sleep 0.5
fi

# media: gvfs-mtp (media transfer protocol), geany (text editor),
# imagemagick (free image editor),
# brightnessctl (brightness control),
# mpc (mpd client), mpd (music player daemon), ncmpcpp (yet another mpd client),
# pamixer (pulseaudio command line mixer)

# development: neovim (vim alternative), npm (node package manager),
# rustup (rust compiler, required for paru), go (golang, required for yay), git

if [[ $DEV_DEPENDS -eq 0 && ! $(check_arg "--dev" "$@") ]]; then
    confirm "Do you want to install development packages?" && DEV_DEPENDS=1
fi

if [[ $DEV_DEPENDS -eq 1 ]]; then
    echo "Installing development packages..."
    sleep 0.5

    install_packages "\
        neovim npm rustup go git
    "
else
    echo "Skipping development packages installation..."
    sleep 0.5
fi

confirm "Do you want to install maim? (screenshot tool)" && install_packages "maim"

if [[ $? -eq 1 ]]; then
    echo "Skipping maim installation..."
    sleep 0.5
fi

confirm "Do you want to install tmux? (terminal multiplexer)" && install_packages "tmux"

if [[ $? -eq 1 ]]; then
    echo "Skipping tmux installation..."
    sleep 0.5
fi

confirm "Do you want to use zsh instead of bash?" && install_packages "zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting"

if [[ $? -eq 1 ]]; then
    echo "Skipping zsh installation..."
    sleep 0.5

else
    echo "Changing shell to zsh..."
    chsh -s /usr/bin/zsh
fi

confirm "Do you want to install kitty terminal?" && install_packages "kitty"

if [[ $? -eq 1 ]]; then
    echo "Skipping kitty installation..."
    sleep 0.5
else
    confirm "Do you want set kitty as default terminal?" && SET_KITTY_AS_DEFAULT=1
fi

# Backup configs

confirm "Do you want to backup configs?"

if [[ $? -eq 1 ]]; then
    echo "Skipping config backup..."
    sleep 0.5
else
    clear
    select_configs
fi

# copy configs

printf "\e[34m[INFO] Copying configs...\e[0m\n"
sleep 0.5

copy_configs

confirm "Do you want to setup keyboard layouts? (if you want two or more layouts)" && 

if [[ $? -eq 1 ]]; then
    echo "Skipping keyboard layouts setup..."
    sleep 0.5
else
    # run keyboard_setup from $HOME/dotfiles/setup/keyboard_setup.sh
    bash $HOME/dotfiles/setup/keyboard_setup.sh
    mv $current_dir/layouts.json $HOME/.config/.local/bin/
fi

printf "\e[32m[INFO] Configs have been copied.\e[0m\n"

echo "Installation finished! Enjoy!"
echo "Now, you should reboot your system for changes to take effect."

confirm "Do you want to reboot now?" && sudo reboot

# utils: maim (screenshot tool), tmux (terminal multiplexer),
# other: zsh, zsh-autosuggestions, zsh-history-substring-search, zsh-syntax-highlighting
# kitty (another terminal), bat (cat command alternative),

# install_packages "\
#     alacritty base-devel bat brightnessctl bspwm dunst feh jq jgmenu \
#     libwebp
# "

# install_packages "\
#     alacritty base-devel bat brightnessctl bspwm dunst eza feh gvfs-mtp \
#     firefox geany git kitty imagemagick jq jgmenu libwebp maim mpc mpd \
#     neovim ncmpcpp npm pamixer pacman-contrib papirus-icon-theme physlock \
#     picom playerctl polybar polkit-gnome python-gobject ranger redshift \
#     rofi rustup sxhkd tmux ttf-inconsolata ttf-jetbrains-mono \
#     ttf-jetbrains-mono-nerd ttf-joypixels ttf-terminus-nerd ueberzug \
#     webp-pixbuf-loader xclip xdg-user-dirs xdo xdotool xorg-xdpyinfo \
#     xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot xorg-xwininfo zsh \
#     zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting
# "
