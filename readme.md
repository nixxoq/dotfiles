
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
- Bar: Ags (Aylur's Gtk Shell) + Hyprpanel
- Screenshot tool: flameshot (git-version, built with -DUSE_WAYLAND_CLIPBOARD=true -DUSE_WAYLAND_GRIM=ON flags)
```

AGS:
![hyprpanel](https://github.com/user-attachments/assets/0413feb8-8e20-489b-bc6a-6cb97fd54dee)

Waybar:
![waybar-mode](https://github.com/user-attachments/assets/98af27b9-a16e-4954-9e90-dbce169db9f9)

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
> ttf-jetbrains-mono ttf-jetbrains-mono-nerd bat dolphin catnip cbonsai clipse egl-wayland eza hyprland hyprlang hyprlock hyprcursor hyprswitch jq kitty kitty-shell-integration kitty-terminfo lib32-wayland noto-fonts otf-material-design-icons pacman-contrib pamixer pavucontrol pipewire pipewire-pulse pipwire-jack pipewire-audio polkit-gnome pywal-git rofi ranger sddm swww waybar wl-clipboard wlogout xdg-desktop-portal xdg-desktop-portal-wlr xdg-user-dirs zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting noto-color-emoji-fontconfig ttf-liberation zip unzip qt6ct qt5ct kvantum arc-kde arc-gtk-theme dconf dconf-editor firefox geany gtk3 gtk4 gtk4-layer-shell hicolor-icon-theme htop otf-material-design-icons 

> [!NOTE]
> **If you prefer using ags instead of waybar:**
>
> curl -fsSL https://bun.sh/install | bash && sudo ln -s $HOME/.bun/bin/bun /usr/local/bin/bun
> 
> yay/paru -S libgtop bluez bluez-utils btop networkmanager dart-sass brightnessctl swww python gnome-bluetooth-3.0 power-profiles-daemon grimblast-git gpu-screen-recorder hyprpicker matugen-bin python-gpustat aylurs-gtk-shell-git


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

## FAQ

Since I'm too lazy to write a setup script, I have a few answers to specific questions.

### Q: "Open with" -> "Other application" is empty
### A: try this
> mkdir $HOME/.config/menus/
> curl -L https://raw.githubusercontent.com/KDE/plasma-workspace/master/menu/desktop/plasma-applications.menu -o $HOME/.config/menus/applications.menu
> kbuildsycoca6

### Q: Hey, I wanna use waybar instead of ags, what should I do?
### A: 
> open ~/.config/hypr/hyprland.conf file, find and comment "exec-once = ags" line, uncomment "exec-once = waybar"

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

### Old-Desktop preview
<a href="https://github.com/nixxoq/dotfiles/tree/bbe5c306ae12afd4ce38b78fa8c5723ed692b08d">
  <img src="https://github.com/user-attachments/assets/f086a57f-5101-4110-a2ec-753c4f3fb481" alt="Old-Desktop" />
</a>


### Appmenu
![Application Menu](https://github.com/user-attachments/assets/3483f5b4-dd43-4d51-83a8-ce22aff32d9c)
