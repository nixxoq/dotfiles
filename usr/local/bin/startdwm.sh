#!/bin/sh

export XDG_CURRENT_DESKTOP=dwm
export XDG_SESSION_DESKTOP=dwm

if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP
fi

export GTK_USE_PORTAL=1

# xrandr --setprovideroutputsource 1 0 2>/dev/null
# xrandr --output HDMI-1-0 --right-of eDP-1 --auto

xwallpaper --zoom ~/Pictures/Wallpapers/1.png
setxkbmap us,ua,ru -option 'grp:alt_shift_toggle'  # <<== or caps_lock_toggle, whatever

gentoo-pipewire-launcher &
dwmblocks &
/usr/libexec/polkit-gnome-authentication-agent-1 &
dunst &
flameshot &
clipmenud &
copyq --start-server &

while true; do
	# Log stderror to a file
	dwm 2>~/.dwm.log
	# No error logging
	#dwm >/dev/null 2>&1
done
