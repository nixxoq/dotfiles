# #!/bin/bash

# # Функции для выполнения бэкапа
# backup_alacritty() {
#     echo "Backing up alacritty..."
#     # Код для бэкапа alacritty
# }

# backup_kitty() {
#     echo "Backing up kitty..."
#     # Код для бэкапа kitty
# }

# backup_neovim() {
#     echo "Backing up neovim..."
#     # Код для бэкапа neovim
# }

# backup_bspwm() {
#     echo "Backing up bspwm..."
#     # Код для бэкапа bspwm
# }

# # Функция для выбора конфигов
# select_configs() {
#     options=("alacritty" "kitty" "neovim" "bspwm")
#     selected=()
#     index=0

#     while true; do
#         clear
#         echo "Выберите конфиги для бэкапа (используйте пробел для выбора, Enter для подтверждения):"

#         for i in "${!options[@]}"; do
#             if [[ $i -eq $index ]]; then
#                 pointer="> "
#             else
#                 pointer="  "
#             fi

#             if [[ " ${selected[*]} " =~ " ${options[i]} " ]]; then
#                 echo "$pointer[*] ${options[i]}"
#             else
#                 echo "$pointer[ ] ${options[i]}"
#             fi
#         done

#         # Чтение управляющих клавиш
#         IFS= read -rsn1 key
#         if [[ $key == $'\x1b' ]]; then
#             IFS= read -rsn2 key
#             case "$key" in
#                 '[A') # Стрелка вверх
#                     index=$(( (index - 1 + ${#options[@]}) % ${#options[@]} ))
#                     ;;
#                 '[B') # Стрелка вниз
#                     index=$(( (index + 1) % ${#options[@]} ))
#                     ;;
#             esac
#         elif [[ $key == ' ' ]]; then # Пробел для выбора/отмены выбора
#             if [[ " ${selected[*]} " =~ " ${options[index]} " ]]; then
#                 selected=("${selected[@]/${options[index]}}")
#             else
#                 selected+=("${options[index]}")
#             fi
#         elif [[ $key == '' ]]; then # Enter для подтверждения выбора
#             break
#         fi
#     done

#     # Вызов функции backup_<имя_конфига> для каждого выбранного конфига
#     for config in "${selected[@]}"; do
#         backup_func="backup_$config"
#         $backup_func
#     done
# }

# # Вызов функции для выбора конфигов
# select_configs

#!/bin/bash

# # customize with your own.
# options=("Alacritty" "BSPWM" "Kitty" "neovim")

# menu() {
#     clear
#     echo "Avaliable options:"
#     for i in ${!options[@]}; do
#         printf "%3d%s) %s\n" $((i + 1)) "${choices[i]:- }" "${options[i]}"
#     done
#     [[ "$msg" ]] && echo "$msg"
#     :
# }

# prompt="Check an option (again to uncheck, ENTER when done, Q to quit): "
# while menu && read -rp "$prompt" num && [[ "$num" ]]; do
#     case $num in
#     q | Q) exit 0 ;;
#     esac
#     [[ "$num" != *[![:digit:]]* ]] &&
#         ((num > 0 && num <= ${#options[@]})) ||
#         {
#             msg="Invalid option: $num"
#             continue
#         }
#     ((num--))
#     msg="" # msg="${options[num]} was ${choices[num]:+un}checked"
#     [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
# done

# printf "You selected"
# msg=" nothing"
# for i in ${!options[@]}; do
#     [[ "${choices[i]}" ]] && {
#         printf " %s" "${options[i]}"
#         msg=""
#     }
# done
# echo "$msg"

#!/bin/bash

# Список опций
options=("Option 1" "Option 2" "Option 3" "Option 4")
selected=()
cursor=0

# Функция для отображения мультиселекта
display_menu() {
    local i
    tput -T xterm sc
    for i in "${!options[@]}"; do
        local checked="${selected[*]} "
        local symbol=" "
        if [[ $i -eq $cursor ]]; then
            symbol=">"
        fi

        [[ $checked =~ ${options[$i]} ]] && symbol="${symbol} [x]" || symbol="${symbol} [ ]" 

        printf "\r${symbol} %s\n" "${options[$i]}"
    done
    tput -T xterm rc
}

# Отображение меню и обработка ввода
multiselect() {
    local input
    local item

    while true; do
        display_menu

        IFS= read -rsn1 input # Считывание одного символа

        case "$input" in
        $'\x1b')
            IFS= read -rsn2 input
            case "$input" in
            '[A') # Up arrow
                ((cursor--))
                if [[ $cursor -lt 0 ]]; then cursor=0; fi
                ;;
            '[B') # Down arrow
                ((cursor++))
                if [[ $cursor -ge ${#options[@]} ]]; then cursor=$((${#options[@]} - 1)); fi
                ;;
            esac
            ;;
        ' ') # Space (Select/Deselect)
            item="${options[$cursor]}"
            if [[ " ${selected[@]} " =~ " ${item} " ]]; then
                selected=("${selected[@]/$item/}")
            else
                selected+=("$item")
            fi
            ;;
        '') # Enter (Quit)
            break
            ;;
        esac
    done
}

# Отображение выбранных опций
clear
echo "Some text above the menu"
echo "tets2"

echo "Some text above the menu"
echo "tets2"
echo "Some text above the menu"
echo "tets2"
echo "Some text above the menu"
echo "tets2"
echo "Some text above the menu"
echo "tets2"
echo "Some text above the menu"
echo "tets2"
echo "Some text above the menu"
echo "tets2"
# echo
# clear
multiselect
clear
echo "Selected options:"
for opt in "${selected[@]}"; do
    echo "$opt"
done
