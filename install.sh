#!/usr/bin/env bash
set -Eeuo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(id -u)" -eq 0 ]]; then
    printf 'error: do not run install.sh as root. Run as a regular user.\n' >&2
    exit 1
fi

printf '==> Building and installing dotfiles package with makepkg...\n'
(
    cd "$script_dir"
    makepkg -si "$@"
)

printf '\n==> Launching dotfiles configuration wizard...\n'
if command -v dotfiles-install >/dev/null 2>&1; then
    exec dotfiles-install
elif [[ -x /usr/share/dotfiles/install ]]; then
    exec /usr/share/dotfiles/install
else
    exec "$script_dir/scripts/install"
fi
