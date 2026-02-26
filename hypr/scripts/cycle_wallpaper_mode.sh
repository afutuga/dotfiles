#!/bin/bash
MODO_FILE="/tmp/wallpaper_mode"
MODO=$(cat "$MODO_FILE")

case $MODO in
    "fullscreen") echo "game" > "$MODO_FILE" ;;
    "game")       echo "always" > "$MODO_FILE" ;;
    "always")     echo "fullscreen" > "$MODO_FILE" ;;
esac

# Força o script principal a reagir imediatamente (opcional)
pkill -USR1 -f toggle_wallpaper.sh 2>/dev/null