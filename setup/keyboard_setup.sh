#!/bin/bash

JSON_FILE="layouts.json"
AVAILABLE_LAYOUTS_FILE="available_layouts.txt"

# Check if the JSON file exists
if [ ! -f "$JSON_FILE" ]; then
    echo '{"layouts": []}' > "$JSON_FILE"
elif [ ! -s "$JSON_FILE" ]; then
    echo '{"layouts": []}' > "$JSON_FILE"
fi

show_available_layouts() {
    clear
    echo
    echo "Fetching available layouts..."
    echo


    # printf blue text
    printf "\e[34m"
    localectl list-x11-keymap-layouts | fmt -w 40
    printf "\e[0m"
    echo
    echo

    read -n 1 -s -r -p "Press any key to continue..."
    printf "\r"
}

while true; do
    echo "In this stage you will be able to add new layouts to the JSON file."
    echo "Enter layout codes separated by commas (e.g. ru,ua,us):"
    echo "Tip: to watch available layouts type 'list'"

    read -r -p "Input: " input

    if [ "$input" == "list" ]; then
        show_available_layouts
        continue
    fi

    IFS=',' read -r -a new_layouts <<< "$input"

    tmp_file=$(mktemp)

    for layout in "${new_layouts[@]}"; do
        # check if layout in the list of keymap layouts
        if ! localectl list-x11-keymap-layouts | grep -q "$layout"; then
            echo "Invalid layout code: $layout. Skipping..."
            continue
        fi
        
        layout=$(echo "$layout" | xargs)

        if ! jq -e --arg code "$layout" '.layouts[] | select(.code == $code)' "$JSON_FILE" > /dev/null; then
            jq --arg code "$layout" '.layouts += [{"code": $code}]' "$JSON_FILE" > "$tmp_file" && mv "$tmp_file" "$JSON_FILE"
        fi
    done

    rm -f "$tmp_file"

    echo "Updated $JSON_FILE:"
    cat "$JSON_FILE"

    while true; do
        echo "Do you want to add more layouts or view available layouts? (yes/no)"
        read -r answer

        case "$answer" in
            [Yy][Ee][Ss])
                break
                ;;
            [Nn][Oo])
                exit 0
                ;;
            *)
                echo "Invalid input. Please enter 'yes' or 'no'."
                ;;
        esac
    done
done
