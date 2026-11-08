#!/usr/bin/env python3
import argparse
import glob
import json
import os
import re
import subprocess
import sys
from pathlib import Path


def detect_battery():
    return bool(glob.glob("/sys/class/power_supply/BAT*"))


def detect_main_monitor():
    connected = []

    for status in sorted(glob.glob("/sys/class/drm/card*-*/status")):
        try:
            if Path(status).read_text(encoding="utf-8").strip() == "connected":
                connector = Path(status).parent.name.split("-", 1)[-1]
                if connector not in connected:
                    connected.append(connector)
        except OSError:
            pass

    if not connected:
        return "eDP-1"

    for prefix in ("eDP", "LVDS", "DSI", "DP", "HDMI"):
        for connector in connected:
            if connector.startswith(prefix):
                return connector

    return connected[0]


def detect_keyboards():
    paths = sorted(
        glob.glob("/dev/input/by-id/*event-kbd")
        + glob.glob("/dev/input/by-path/*event-kbd")
    )
    devices = []
    seen = set()

    for path in paths:
        target = os.path.realpath(path)
        if target not in seen:
            seen.add(target)
            devices.append(path)

    return devices


def toml_escape(value):
    return json.dumps(value, ensure_ascii=False)[1:-1]


def git_quote(value):
    if any(ch in value for ch in ("\n", "\r", "\x00")):
        raise ValueError("Git identity values cannot contain line breaks or NUL")

    return json.dumps(value, ensure_ascii=False)


def render_battery_block(text, has_battery):
    result = []
    include = True

    for line in text.splitlines():
        marker = line.strip()
        if marker == "# if {BATTERY}":
            include = has_battery
            continue
        if marker == "# {BATTERY}":
            include = True
            continue
        if include:
            result.append(line)

    return "\n".join(result) + "\n"


def main():
    parser = argparse.ArgumentParser(
        description="Render hardware-specific Niri and Noctalia configs."
    )
    parser.add_argument("--source", required=True)
    parser.add_argument("--output-home", required=True)
    parser.add_argument("--home", required=True)
    parser.add_argument("--wallpaper-dir", required=True)
    parser.add_argument("--keyboard-layout", required=True)
    parser.add_argument("--keyboard-options", required=True)
    parser.add_argument("--git-name", default="")
    parser.add_argument("--git-email", default="")
    parser.add_argument("--git-signing-key", default="")
    args = parser.parse_args()

    if not re.fullmatch(r"[A-Za-z0-9_,.-]+", args.keyboard_layout):
        raise ValueError("Invalid XKB keyboard layout")
    if not re.fullmatch(r"[A-Za-z0-9_,:-]+", args.keyboard_options):
        raise ValueError("Invalid XKB options")

    source = Path(args.source)
    output = Path(args.output_home)
    home = str(Path(args.home).resolve())
    wallpaper = Path(args.wallpaper_dir).expanduser()
    if not wallpaper.is_absolute():
        wallpaper = Path(home) / wallpaper
    wallpaper = str(wallpaper.resolve())

    monitor = detect_main_monitor()
    keyboards = detect_keyboards()
    first_keyboard = keyboards[0] if keyboards else ""
    noctalia = render_battery_block(
        (source / "templates/noctalia-config.toml.in").read_text(encoding="utf-8"),
        detect_battery(),
    )
    replacements = {
        "{MAIN_MONITOR}": monitor,
        "{WALLPAPER_DIR}": toml_escape(wallpaper),
        "{FIRST_KEYBOARD}": toml_escape(first_keyboard),
        "{KEYBOARD_LIST}": json.dumps(keyboards, ensure_ascii=False),
    }
    for marker, value in replacements.items():
        noctalia = noctalia.replace(marker, value)
    if re.search(
        r"\{(?:MAIN_MONITOR|WALLPAPER_DIR|FIRST_KEYBOARD|KEYBOARD_LIST)\}", noctalia
    ):
        raise ValueError("Unrendered Noctalia hardware marker remains")
    noctalia_path = output / ".config/noctalia/config.toml"
    noctalia_path.parent.mkdir(parents=True, exist_ok=True)
    noctalia_path.write_text(noctalia, encoding="utf-8")

    niri = (source / "templates/niri-input.kdl.in").read_text(encoding="utf-8")
    niri = niri.replace("{KEYBOARD_LAYOUT}", args.keyboard_layout)
    niri = niri.replace("{KEYBOARD_OPTIONS}", args.keyboard_options)
    niri_path = output / ".config/niri/cfg/input.kdl"
    niri_path.parent.mkdir(parents=True, exist_ok=True)
    niri_path.write_text(niri, encoding="utf-8")

    git_config = (source / "templates/git-config.in").read_text(encoding="utf-8")
    for marker, value in (
        ("{GIT_NAME}", git_quote(args.git_name)),
        ("{GIT_EMAIL}", git_quote(args.git_email)),
        ("{GIT_SIGNING_KEY}", git_quote(args.git_signing_key)),
    ):
        git_config = git_config.replace(marker, value)
    git_path = output / ".config/git/config"
    git_path.parent.mkdir(parents=True, exist_ok=True)
    git_path.write_text(git_config, encoding="utf-8")

    for name in ("qt5ct", "qt6ct"):
        config_path = output / ".config" / name / f"{name}.conf"
        if config_path.exists():
            config_path.write_text(
                config_path.read_text(encoding="utf-8").replace("@HOME@", home),
                encoding="utf-8",
            )

    print(
        f"Rendered Noctalia config: monitor={monitor}, battery={detect_battery()}, keyboards={len(keyboards)}"
    )


if __name__ == "__main__":
    try:
        main()
    except (OSError, ValueError, subprocess.SubprocessError) as error:
        print(f"render-configs: {error}", file=sys.stderr)
        sys.exit(1)
