#!/bin/bash

install_stow() {
    echo "┌────────────────────────────────────┐"
    echo "│         [+] Installing stow        │"
    echo "└─────────────────────────────╴ marine"

    sudo apt install -y stow
    clear
}



stowing() {
    STOW_DIR="stow"
    STOWi3_DIR="i3"
    TARGET_DIR="$HOME"

    # APPS=("apps" "atuin" "bash" "bettercap" "betterdiscord" "fonts" "ghostty" "gtkbookmarks" "icons" "neofetch" "ngrok" "nvim" "obs" "powershell" "spotify" "ssh" "starship" "sublime" "themes" "tmux" "vscode" "wallpapers" "warp" "warpthemes" "wezterm" "zed" "zsh")
    APPS=("apps" "atuin" "bash" "bettercap" "fonts" "ghostty" "gtkbookmarks" "icons" "neofetch" "ngrok" "nvim" "obs" "powershell" "spotify" "ssh" "starship" "sublime" "themes" "tmux" "vscode" "wallpapers" "warp" "warpthemes" "wezterm" "zed" "zsh")
    APPSi3=("autostart" "i3" "polybar" "rofi")

    echo "┌────────────────────────────────────────────────┐"
    echo "│     [+] Installing dotfiles using GNU Stow     │"
    echo "└─────────────────────────────────────────╴ marine"
    echo ""
    echo "[*] Target directory: $TARGET_DIR [*]"

    for app in "${APPS[@]}"; do
        echo "→ Stowing $app"
        stow -d "$STOW_DIR" -t "$TARGET_DIR" "$app"
    done
}


# Main Execution
install_stow
stowing
