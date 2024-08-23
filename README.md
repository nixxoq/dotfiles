
<div align="justify">

<div align="center">
<h1>My dotfiles config</h1>
</div>


<pre align="center">
<a href="#setup">SETUP (Soon)</a> • <a href="#keybinds">KEYBINDS</a> • <a href="#screenshots">Additional Screenshots</a></a>
</pre>


```
- OS: Arch Linux
- WM: BSPWM
- Terminal alacrity
- Screenshot tool: maim (or flameshot for alternative)
```
![Desktop-Preview](https://github.com/user-attachments/assets/e5e75767-9628-49df-b895-a57a3180cb61)

## Setup

> [!WARNING]
> Before using this config, make sure you have:
> - Arch Linux based distribution
> - Internet connection
> - Curl preinstalled (if not, install it using `sudo pacman -S curl`)


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
```

## keybinds
![image](https://github.com/user-attachments/assets/23d5a50d-abb5-466b-bb2b-a9cbf2cb534f)


## Screenshots

### Appmenu
![Application Menu](https://github.com/user-attachments/assets/0d59e45c-5ca0-4e3a-887d-ed7247fb661b)


### Desktop
![Desktop-2](https://github.com/user-attachments/assets/3f11a405-2f13-4a52-8d81-a7408f0df5cd)


notes (for me):
```
# TODO: add option to run this script on startup
#       Additionally, add an option to alias neofetch as 'sysfetch'
source: https://github.com/nixxoq/dotfiles/blob/main/home/.zshrc#L154
```