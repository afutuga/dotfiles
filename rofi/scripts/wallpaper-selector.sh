#!/bin/bash

# Configurações
WALLPAPER_DIR="$HOME/Imagens"
ROFI_THEME="$HOME/.config/rofi/launchers/type-1/style-1.rasi"

# 1. Lista apenas imagens e GIFs (MP4 e WEBM ficam de fora para evitar erros)
list_wallpapers() {
    find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) | while read -r img; do
        echo -en "$(basename "$img")\0icon\x1f$img\n"
    done
}

# 2. Executa o Rofi
selected=$(list_wallpapers | rofi -dmenu -i -p "Wallpaper" -theme "$ROFI_THEME" -show-icons)

# Se não selecionou nada, sai
[ -z "$selected" ] && exit 0

FULL_PATH="$WALLPAPER_DIR/$selected"

# 3. Garante que o swww-daemon está a correr
pgrep -x swww-daemon > /dev/null || swww-daemon &
sleep 0.2

# 4. Aplica o Wallpaper (Removi as flags que dão erro na tua versão)
swww img "$FULL_PATH" --transition-type grow --transition-pos 0.5,0.5

# 5. Atualiza o sistema em background
(
    wal -i "$FULL_PATH" -n -q
    [ -f "$HOME/.cache/wal/colors.sh" ] && source "$HOME/.cache/wal/colors.sh"
    killall -SIGUSR2 waybar
) &

notify-send "Wallpaper Alterado" "$selected"