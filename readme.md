
<div align="center">
<h1>My dotfiles config (v2)</h1>
</div>

<pre align="center">
<a href="#">SETUP (automatic installtion soon)</a> • <a href="#keybinds">KEYBINDS</a> • <a href="#screenshots">Additional Screenshots</a></a>
</pre>


```
- OS: Arch Linux
- WM: Hyprland
- Terminal: kitty
- Screenshot tool: grim
```
![Desktop-Preview](https://github.com/user-attachments/assets/f086a57f-5101-4110-a2ec-753c4f3fb481)

## Setup

Not implemented yet.

> [!WARNING]
> Before using this config, make sure you have:
> - Arch Linux based distribution
> - Internet connection
> - AUR helper (yay or paru) preinstalled

> [!WARNING]
> **Dependency packages:**
>
> ttf-jetbrains-mono ttf-jetbrains-mono-nerd bat dolphin catnip (?) cbonsai (-bin) cliphist checkupdates-with-aur dunst egl-wayland eza hyprland hyprlang hyprlock hyprcursor hyprswitch jq kitty kitty-shell-integration kitty-terminfo lib32-wayland noto-fonts otf-material-design-icons pacman-contrib pamixer pavucontrol pipewire pipewire-pulse pipwire-jack pipewire-audio polkit-gnome pywal-git rofi ranger sddm swww waybar wl-clipboard wlogout xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting noto-color-emoji-fontconfig (fixes font rendering in discord and other apps) ttf-liberation zip unzip qt6ct qt5ct kvantum arc-kde arc-gtk-theme dconf dconf-editor firefox geany gtk3 gtk4 gtk4-layer-shell hicolor-icon-theme htop otf-material-design-icons 

<!-- 
> [!WARNING]
> Before using this config, make sure you have:
> - Arch Linux based distribution
> - Internet connection
> - Curl preinstalled (if not, install it using `sudo pacman -S curl`) -->

<!-- 
Download script:
```
curl -sL https://raw.githubusercontent.com/nixxoq/dotfiles/main/setup/base.sh -o base.sh
chmod +x base.sh
./base.sh
```

Command line arguments:
```
--debug: Enable debug mode.
--skip-update: Skip system update.
--media: Install media dependencies.
--dev: Install development dependencies.
--configure-keymap: Configure keymap.
--force-redownload: Re-download dotfiles if folder exists.
--help: Display help message.
``` -->

## keybinds
```
Windows + Q (or Alt + F4): kill active windows + Del: kill hyprland session
Windows + V: toggle the window on focus to float
Windows + G: toggle the window on focus to group (tab mode)
ALT + Return: fullscreen mode
Windows + L: lock screen
Windows + Shift + F: toggle pin on focused window
Windows + backspace: logout menu
Ctrl + Escape: toggle waybar
Ctrl + Alt + T: open terminal
Windows + E: open Dolphin (file manager)
Windows + F: open firefox
Ctrl + Shift + Escape: open btop/htop

Windows + Space: open desktop applications menu
Windows + Tab: Switch between desktop applications
Windows + R: Browse system files

F10: toggle audio mute
F11: decrease volume
F12: increase volume

Shift + Windows + S: Take a screenshot
Windows + ALT + G: Toggle hyprland animations for gamemode

Windows + Shift + D: toggle wallbash on/off
Windows + C: Clipboard manager

Windows + K: toggle keyboard layout
Alt + Shift: toggle keyboard layout

Windows + arrow left/right/up/down: move focus to windows
Windows + Shift + arrow left/right/up/down: resize window (20px)

Windows + [0-9]: switch to workspace

Windows + Shift + [0-9]: move active window to workspace
Windows + ALT + arrow left/right: move active window to workspace (relative)
Windows + Shift + Ctrl + arrow left/right/up/down: move active window around current workspace
Windows + Scroll: scroll through existing workspaces
Windows + LMB/RMB (or Z/X): move/resize windows
Windows + J: toggle layout mode

Windows + ALT + [0-9]: switch to workspace silently

Alt + Tab: switch between workspaces using hyprswitch (requires hyprswitch)
```


## Screenshots

### Appmenu
![Application Menu](https://github.com/user-attachments/assets/3483f5b4-dd43-4d51-83a8-ce22aff32d9c)
