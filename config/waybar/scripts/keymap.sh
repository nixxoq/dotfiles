#!/usr/bin/env bash

# Получение текущей активной раскладки клавиатуры
keymap=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap')

# Вывод результата для Waybar
echo "$keymap"
