
<div align="center">
<h1>My dotfiles config (v3)</h1>
</div>

<pre align="center">
<a href="#setup">SETUP</a> • <a href="#keybinds">KEYBINDS</a></a>
</pre>


```
- OS: Arch Linux (currently moving to Prism Linux)
- WM: Niri
- Terminal: alacrity
- Bar: Noctalia-Shell
- Screenshot tool: grim (bundled in Niri)
- mouse icon: Bibata-Modern-Ice (size 24)
```

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/96fd1d38-bd72-4ed5-ba71-2eec89a3c54d" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/29b8fbf0-1038-4b6e-9c2e-94878e1994c5" />


## Setup

> [!WARNING]
> Before using this config, make sure you have:
> - Arch Linux based distribution
> - Internet connection

Since i've moved to chezmoi as a replacement for shell scripts, you need to install `chezmoi` and `git` first:
```bash
sudo pacman -S chezmoi git
```

After that, run the following command to apply the dotfiles:
```bash
chezmoi init --apply https://github.com/nixxoq/dotfiles.git
```
Answer the prompts and wait for the process to finish!

## keybinds
### Layout & Window Management
- **Windows + Shift + R**: Switch between preset window heights
- **Windows + Ctrl + R**: Reset window height
- **Windows + Ctrl + C**: Center all visible columns
- **Windows + W**: Toggle tabbed display (column)
- **Windows + F**: Maximize column
- **Windows + Shift + F**: Fullscreen window

### Navigation
- **Windows + Arrows**: Move focus (Left/Right for columns, Up/Down for windows)
- **Windows + Home / End**: Focus first or last column
- **Windows + U / I** (or **PageUp/Down**): Switch workspace Up/Down
- **Windows + [1-9]**: Switch to workspace by index
- **Windows + O**: Toggle Overview (Zoom out)
- **Windows + Shift + Arrows**: Move focus to another monitor

### Windows movement
- **Windows + Ctrl + Arrows**: Move window/column
- **Windows + Ctrl + Home / End**: Move column to first/last position
- **Windows + Ctrl + U / I**: Move column to workspace Up/Down
- **Windows + Ctrl + [1-9]**: Move column to workspace by index
- **Windows + Shift + U / I**: Move entire workspace Up/Down
- **Windows + [ / ]**: Consume or expel window (Horizontal)
- **Windows + , / .**: Consume or expel window (Vertical/Stack)

### Resizing
- **Windows + Minus / Equal**: Adjust column width (-/+ 10%)
- **Windows + Shift + Minus / Equal**: Adjust window height (-/+ 10%)

### Media & Screenshots
- **Print** (or **Windows + Shift + S**): Take interactive screenshot
- **Ctrl + Print**: Screenshot entire screen
- **Alt + Print**: Screenshot active window

**F1-F12 Keys (Special):**
- **Audio Raise/Lower/Mute**: Volume control
- **Mic Mute**: Toggle microphone
- **Media Play/Stop/Next/Prev**: Player control
- **Brightness Up/Down**: Screen brightness

### Mouse & Touchpad
- **Windows + Wheel Up/Down**: Scroll through workspaces
- **Windows + Wheel Left/Right**: Scroll through columns