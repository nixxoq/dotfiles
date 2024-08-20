#!/bin/bash

#
# PROGRAM OPTIONS
#
CONFIG_FILE=0
SET_KEYMAP=0
GET_KEYMAP=0

get_command_args() {
    for arg in "$@"; do
        case $arg in
        --set-keymap)
            SET_KEYMAP=1
            ;;
        --current-keymap)
            GET_KEYMAP=1
            ;;
        --file=*)
            CONFIG_FILE="${arg#--file=}"
            ;;
        *)
            echo "Unknown argument: $arg. Skipping..."
            ;;
        esac
    done
}

set_keymap() {
    [ -z "$CONFIG_FILE" ] && {
        echo "CONFIG_FILE not set. Aborting..."
        exit 1
    }

    layouts=$(jq -r '.layouts | map(.code) | join(",")' $CONFIG_FILE)

    setxkbmap -layout "$layouts" -option grp:alt_shift_toggle
    # TODO: Add support for toggle options
    # Current options:

    echo "Keyboard layout set to: $layouts"
    notify-send "Keyboard layout changed to: $layouts"
}

get_curr_keymap() {
    layout=$(xkb-switch -p)

    echo "$layout"
}

get_command_args "$@"

[ $SET_KEYMAP -eq 1 ] && set_keymap
[ $GET_KEYMAP -eq 1 ] && get_curr_keymap
