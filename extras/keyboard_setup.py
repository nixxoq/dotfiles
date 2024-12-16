import os
import subprocess
import shutil
from rich.console import Console
from rich.panel import Panel

AVAILABLE_TOGGLE_OPTIONS = [
    "grp:alt_shift_toggle",
    "grp:ctrl_shift_toggle",
    "grp:win_space_toggle",
    "grp:shift_caps_toggle",
    "grp:alt_caps_toggle",
]


def get_available_layouts():
    try:
        result = subprocess.run(
            "localectl list-x11-keymap-layouts",
            capture_output=True,
            text=True,
            shell=True,
        )
        if result.returncode != 0:
            print("\033[91mError executing localectl: \033[0m" + result.stderr)
            return []

        layouts = result.stdout.splitlines()
        layouts.sort(key=lambda x: (x.lower(), x))

        column_width, _ = get_terminal_size()
        lines = [
            ", ".join(layouts[i : i + column_width])
            for i in range(0, len(layouts), column_width)
        ]
        panel = Panel("\n".join(lines), title="Available Keyboard Layouts")
        Console().print(panel)

        return layouts

    except Exception as e:
        print("\033[91mError retrieving layouts: \033[0m" + str(e))
        return []


def get_terminal_size():
    size = shutil.get_terminal_size(fallback=(80, 20))
    return size.columns, size.lines


def select_layouts(layouts):
    selected = input("\nEnter the layouts you want, separated by commas: ")
    selected_layouts = [layout.lower().strip() for layout in selected.split(",")]

    for layout in selected_layouts:
        if layout not in layouts:
            print(f"Invalid layout '{layout}'. Please try again.")
            return select_layouts(layouts)

    return selected_layouts


def select_toggle_option(options):
    print("\nAvailable toggle options:")
    for i, option in enumerate(options):
        print(f"{i + 1}. {option}")

    selected = input("Enter the number of the toggle option you want: ")

    try:
        selected_option = options[int(selected) - 1]
        return selected_option
    except (IndexError, ValueError):
        print("Invalid selection. Please try again.")
        return select_toggle_option(options)


def append_to_file(layouts, toggle_option, filepath):
    parent_dir = os.path.dirname(filepath)
    if not os.path.exists(parent_dir):
        os.makedirs(parent_dir)

    if not os.path.exists(filepath):
        # create the file if it doesn't exist
        with open(filepath, "w") as file:
            pass

    with open(filepath, "a") as file:
        file.write(f"\ninput {{\n")
        file.write(f"    kb_layout = {','.join(layouts)}\n")
        file.write(f"    kb_options = {toggle_option}\n")
        file.write("}\n")
    print(f"\nLayouts and toggle option appended to {filepath}")


if __name__ == "__main__":
    available_layouts = get_available_layouts()
    if available_layouts:
        selected_layouts = select_layouts(available_layouts)

        selected_toggle_option = select_toggle_option(AVAILABLE_TOGGLE_OPTIONS)

        config_path = os.path.expanduser("~/.config/hypr/config/input.conf")
        append_to_file(selected_layouts, selected_toggle_option, config_path)
    else:
        print("No layouts found or an error occurred.")
