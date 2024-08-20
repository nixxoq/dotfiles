
<div align="justify">

<div align="center">
<h1>My dotfiles config</h1>
</div>


<pre align="center">
<a href="#">SETUP (Soon)</a> • <a href="#keybinds">KEYBINDS</a> • <a href="#screenshots">Additional Screenshots</a></a>
</pre>


```
- OS: Arch Linux
- WM: BSPWM
- Terminal alacrity
- Screenshot tool: flameshot
```
![image](https://github.com/user-attachments/assets/3f11a405-2f13-4a52-8d81-a7408f0df5cd)

## keybinds
<pre>
  _  __  _____  __   __  __  __      _      ____    ____  
 | |/ / | ____| \ \ / / |  \/  |    / \    |  _ \  / ___| 
 | ' /  |  _|    \ V /  | |\/| |   / _ \   | |_) | \___ \ 
 | . \  | |___    | |   | |  | |  / ___ \  |  __/   ___) |
 |_|\_\ |_____|   |_|   |_|  |_| /_/   \_\ |_|     |____/ 

NOTES:
    SUPER - WINDOWS
    RETURN - Enter
    @space - space
    
    Unfortunately, when you use the keyboard shortcut <b>shift + alt</b>, the <b>shift + alt + b and others. are broken</b>. 
    If you want to use keyboard shortcuts for your favorite browser, editor and file manager, use ctrl + shift or other. 

- Super + Return
    Opens terminal (Alacritty by default)

- Ctrl + Alt + T
    Opens floating terminal (Alacritty by default)

- Super + @space
    Shows application menu (<a href="#appmenu">See screenshot</a>)

- Shift + alt
    Switch the keyboard layout
    TODO: add the option to select a button to switch the keyboard layout

- Shift + alt + b
    Opens your default browser (eg. firefox, chromium)

- Shift + alt + g
    Opens your default text editor (eg. geany)

- Shift + alt + n
    Opens your default file manager (eg. thunar)

- Shift + alt + r
    Opens ranger

- Shift + alt + v
    Opens neovim

- Shift + alt + k
    Opens music player (ncmpcpp or mpd, idk)

- Shift + alt + p
    Opens pavucontrol (sound control)

- Alt + @space
    Change theme to another
    TODO: Remove this because i don't want use other themes

- Super + alt + t
    Select what terminal will be used by default

- ~button3 (or right click)
    Shows context menu with applications (similar to the MATE Desktop)

- Super + alt + o
    Scratchpad (but for what? I was thinking about removing it)

- Ctrl + super + alt + ...
    - ...p:
        Power off PC
    - ...r
        Reboot system
    - ...q
        Quit from BSPWM
    - ...l
        Lock screen
    - ...k
        Force terminate program

- Super + alt + h
    Hide polybar
- Super + alt + u
    Show polybar

- Ctrl + alt + ...
    - "+" (plus)
        Add transperency
    - "-" (minus)
        Remove transperency
    - ";"
        Reset transperency by default (0)

- Super + alt + w
    Set wallpaper to use

- Super + alt + a
    Mount Android phones

- Super + alt + n
    Shows Network Manager Applet

- Super + alt + c
    Show Clipboard History

- Shift + super + s
    Take a screenshot (I use flameshot)

- Super + alt + b
    Bluetooth menu

- Super + alt + p
    Power menu

- Super + alt + r
    Reload BSPWM

- Super + Escape (ESC)
    Reload keybindings

### Window Managment
- Super + t
    Set window state to tiled

- Super + shift + t
    Set window state to pseudo_tiled

- Super + s
    Set window state to floating

- Super + f
    Set window state to fullscreen

- ctrl + alt + h
    Hide / Unhide window

- shift + super + ctrl + arrows (left, down, up, right)
    Change focus of the Node or Swap Nodes

- ctrl + alt + arrows (left, down, up, right)
    Expand a window

- ctrl + shift + alt + arrows (left, down, up, right)
    Contract a window

- alt + shift + arrows (left, down, up, right)
    Move a floating window


### Workspace
- Super + arrow left/right
    Switch workspace (next or previous)

- Super + alt + arrow left/right
    Move window to workspace (next or previous)

- Super + comma or Tab
    Focus on the last node or workspace

</pre>


## Screenshots

### Appmenu
![Application Menu](https://github.com/user-attachments/assets/0d59e45c-5ca0-4e3a-887d-ed7247fb661b)

notes:
```
# TODO: add option to run this script on startup
#       Additionally, add an option to alias neofetch as 'sysfetch'
source: https://github.com/nixxoq/dotfiles/blob/main/home/.zshrc#L154
```