#!/bin/bash
export XDG_MENU_PREFIX=arch-
update-desktop-database ~/.local/share/applications
sudo update-desktop-database /usr/share/applications
if command -v kbuildsycoca6 &> /dev/null; then
    kbuildsycoca6 --noincremental
fi
