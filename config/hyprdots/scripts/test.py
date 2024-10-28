import subprocess

# Пример словаря с ключами и описаниями
keybindings = {
    "Super + Q": "Kill active window",
    "Super + E": "Open file manager",
    "Super + T": "Open terminal"
}

# Форматирование строки для rofi
formatted_bindings = [f"{keybinding} - {description}" for keybinding, description in keybindings.items()]

# Запуск rofi с отформатированными строками
rofi_process = subprocess.Popen(['rofi', '-dmenu', '-p', 'Select Keybinding'], 
                                 stdin=subprocess.PIPE, 
                                 stdout=subprocess.PIPE, 
                                 stderr=subprocess.PIPE)

# Отправка отформатированных строк в rofi
rofi_input = "\n".join(formatted_bindings).encode('utf-8')
output, error = rofi_process.communicate(input=rofi_input)

# Проверка на ошибки
if error:
    print(f"Error: {error.decode('utf-8')}")
else:
    print(f"Selected: {output.decode('utf-8').strip()}")
