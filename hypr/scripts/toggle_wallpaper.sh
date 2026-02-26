#!/bin/bash

MODO_FILE="/tmp/wallpaper_mode"
[ ! -f "$MODO_FILE" ] && echo "fullscreen" > "$MODO_FILE" # Modo padrão

WAL_FILE="$HOME/.cache/wal/wal"

restore_wall() {
    if ! pgrep -x "swww-daemon" > /dev/null; then
        swww-daemon & sleep 0.5
    fi
    [ -f "$WAL_FILE" ] && swww img $(cat "$WAL_FILE") --transition-type none || swww restore
}

while true; do
    MODO=$(cat "$MODO_FILE")
    IS_FS=$(hyprctl activewindow -j | jq -r '.fullscreen')
    # Verifica se há jogos comuns abertos (podes adicionar mais à lista)
    IS_GAME=$(hyprctl activewindow -j | jq -r '.class' | grep -iE "steam_app|cs2|dota2|league|stardew|minecraft")

    case $MODO in
        "fullscreen")
            if [ "$IS_FS" == "true" ] || [ "$IS_FS" == "1" ]; then
                swww kill
            else
                restore_wall
            fi
            ;;
        "game")
            if [ -n "$IS_GAME" ]; then
                swww kill
            else
                restore_wall
            fi
            ;;
        "always")
            restore_wall
            ;;
    esac
    sleep 1
done