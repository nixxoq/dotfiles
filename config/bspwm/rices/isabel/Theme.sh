#!/usr/bin/env bash
#  ██╗███████╗ █████╗ ██████╗ ███████╗██╗         ██████╗ ██╗ ██████╗███████╗
#  ██║██╔════╝██╔══██╗██╔══██╗██╔════╝██║         ██╔══██╗██║██╔════╝██╔════╝
#  ██║███████╗███████║██████╔╝█████╗  ██║         ██████╔╝██║██║     █████╗
#  ██║╚════██║██╔══██║██╔══██╗██╔══╝  ██║         ██╔══██╗██║██║     ██╔══╝
#  ██║███████║██║  ██║██████╔╝███████╗███████╗    ██║  ██║██║╚██████╗███████╗
#  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝    ╚═╝  ╚═╝╚═╝ ╚═════╝╚══════╝
#  Author  :  z0mbi3
#  Url     :  https://github.com/gh0stzk/dotfiles
#  About   :  This file will configure and launch the rice.
#

# Terminate existing processes if necessary.
. "${HOME}"/.config/bspwm/src/Process.bash

# Current Rice
read -r RICE < "$HOME"/.config/bspwm/.rice

# Vars config for Isabel Rice
# Bspwm border		# Fade windows true|false	# Shadows true|false	# Corner radius
BORDER_WIDTH="0"	P_FADE="true"				P_SHADOWS="true"		P_CORNER_R="6"

# (Onedark) colorscheme
bg="#14171c"  fg="#abb2bf"

black="#181b21"   red="#be5046"   green="#81ae5f"   yellow="#d19a66"
blackb="#5c6370"  redb="#e06c75"  greenb="#98c379"  yellowb="#e5c07b"

blue="#4889be"   magenta="#7560d3"   cyan="#49919a"   white="#abb2bf"
blueb="#61afef"  magentab="#8677cf"  cyanb="#56b6c2"  whiteb="#b8bfe5"

# Set bspwm configuration
set_bspwm_config() {
	bspc config border_width ${BORDER_WIDTH}
	bspc config top_padding 2
	bspc config bottom_padding 42
	bspc config left_padding 2
	bspc config right_padding 2
	bspc config normal_border_color "${whiteb}"
	bspc config active_border_color "${whiteb}"
	bspc config focused_border_color "${magenta}"
	bspc config presel_feedback_color "${green}"
}

# Terminal colors
set_term_config() {
	cat >"$HOME"/.config/alacritty/rice-colors.toml <<EOF
# Default colors
[colors.primary]
background = "${bg}"
foreground = "${fg}"

# Cursor colors
[colors.cursor]
cursor = "${magentab}"
text = "${bg}"

# Normal colors
[colors.normal]
black = "${black}"
red = "${red}"
green = "${green}"
yellow = "${yellow}"
blue = "${blue}"
magenta = "${magenta}"
cyan = "${cyan}"
white = "${white}"

# Bright colors
[colors.bright]
black = "${blackb}"
red = "${redb}"
green = "${greenb}"
yellow = "${yellowb}"
blue = "${blueb}"
magenta = "${magentab}"
cyan = "${cyanb}"
white = "${whiteb}"
EOF

  # Set kitty colorscheme
  cat >"$HOME"/.config/kitty/current-theme.conf <<EOF
# The basic colors
foreground              ${fg}
background              ${bg}
selection_foreground    ${bg}
selection_background    ${greenb}

# Cursor colors
cursor                  ${fg}
cursor_text_color       ${bg}

# URL underline color when hovering with mouse
url_color               ${blueb}

# Kitty window border colors
active_border_color     ${magentab}
inactive_border_color   ${blackb}
bell_border_color       ${yellowb}

# Tab bar colors
active_tab_foreground   ${bg}
active_tab_background   ${magentab}
inactive_tab_foreground ${fg}
inactive_tab_background ${black}
tab_bar_background      ${bg}

# The 16 terminal colors

# black
color0 ${black}
color8 ${blackb}

# red
color1 ${red}
color9 ${redb}

# green
color2  ${green}
color10 ${greenb}

# yellow
color3  ${yellow}
color11 ${yellowb}

# blue
color4  ${blue}
color12 ${blueb}

# magenta
color5  ${magenta}
color13 ${magentab}

# cyan
color6  ${cyan}
color14 ${cyanb}

# white
color7  ${white}
color15 ${whiteb}
EOF

pidof -x kitty && killall -USR1 kitty
}

# Set compositor configuration
set_picom_config() {
	sed -i "$HOME"/.config/bspwm/picom.conf \
		-e "s/normal = .*/normal =  { fade = ${P_FADE}; shadow = ${P_SHADOWS}; }/g" \
		-e "s/dock = .*/dock =  { fade = ${P_FADE}; }/g" \
		-e "s/shadow-color = .*/shadow-color = \"${black}\"/g" \
		-e "s/corner-radius = .*/corner-radius = ${P_CORNER_R}/g" \
		-e "s/\".*:class_g = 'Alacritty'\"/\"100:class_g = 'Alacritty'\"/g" \
		-e "s/\".*:class_g = 'kitty'\"/\"100:class_g = 'kitty'\"/g" \
		-e "s/\".*:class_g = 'FloaTerm'\"/\"100:class_g = 'FloaTerm'\"/g"
}

# Set dunst config
set_dunst_config() {
	sed -i "$HOME"/.config/bspwm/dunstrc \
		-e "s/transparency = .*/transparency = 0/g" \
		-e "s/frame_color = .*/frame_color = \"${bg}\"/g" \
		-e "s/separator_color = .*/separator_color = \"${white}\"/g" \
		-e "s/font = .*/font = JetBrainsMono NF Medium 9/g" \
		-e "s/foreground='.*'/foreground='${magenta}'/g"

	sed -i '/urgency_low/Q' "$HOME"/.config/bspwm/dunstrc
	cat >>"$HOME"/.config/bspwm/dunstrc <<-_EOF_
		[urgency_low]
		timeout = 3
		background = "${bg}"
		foreground = "${green}"

		[urgency_normal]
		timeout = 5
		background = "${bg}"
		foreground = "${fg}"

		[urgency_critical]
		timeout = 0
		background = "${bg}"
		foreground = "${red}"
	_EOF_
}

# Set eww colors
set_eww_colors() {
	cat >"$HOME"/.config/bspwm/eww/colors.scss <<EOF
\$bg: ${bg};
\$bg-alt: ${black};
\$fg: ${fg};
\$black: ${blackb};
\$red: ${red};
\$green: ${green};
\$yellow: ${yellow};
\$blue: ${blue};
\$magenta: ${magenta};
\$cyan: ${cyan};
\$archicon: #0f94d2;
EOF
}

set_launchers() {
	# Jgmenu
	sed -i "$HOME"/.config/bspwm/jgmenurc \
		-e "s/color_menu_bg = .*/color_menu_bg = ${bg}/" \
		-e "s/color_norm_fg = .*/color_norm_fg = ${fg}/" \
		-e "s/color_sel_bg = .*/color_sel_bg = ${black}/" \
		-e "s/color_sel_fg = .*/color_sel_fg = ${whiteb}/" \
		-e "s/color_sep_fg = .*/color_sep_fg = ${blackb}/"

	# Rofi launchers
	cat >"$HOME"/.config/bspwm/src/rofi-themes/shared.rasi <<EOF
// Rofi colors for Isabel

* {
    font: "Terminess Nerd Font Mono Bold 10";
    background: ${bg};
    background-alt: ${bg}E0;
    foreground: ${fg};
    selected: ${magentab};
    active: ${green};
    urgent: ${redb};

    img-background: url("~/.config/bspwm/rices/${RICE}/rofi.webp", width);
}
EOF
}

# Launch theme
launch_theme() {

	# Launch polybar
	for mon in $(polybar --list-monitors | cut -d":" -f1); do
		MONITOR=$mon polybar -q isa-bar -c "${HOME}"/.config/bspwm/rices/"${RICE}"/config.ini &
	done

	# Set random wallpaper for actual rice
	feh -z --no-fehbg --bg-fill "${HOME}"/.config/bspwm/rices/"${RICE}"/walls

	# Launch dunst notification daemon
	dunst -config "${HOME}"/.config/bspwm/dunstrc &
}

### Apply Configurations

set_bspwm_config
set_term_config
set_picom_config
set_dunst_config
launch_theme
set_eww_colors
set_launchers
