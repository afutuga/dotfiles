#!/bin/bash

# Pasta onde vais guardar os teus dotfiles
DESTINO="$HOME/dotfiles"

# Criar a pasta se não existir
mkdir -p "$DESTINO"

# Lista das pastas que escolhemos da tua imagem
pastas=("hypr" "waybar" "rofi" "swaync" "kitty" "fish" "btop" "cava" "neofetch" "nwg-look" "spicetify" "wal")

echo "--- A iniciar cópia dos dotfiles ---"

for pasta in "${pastas[@]}"; do
    if [ -d "$HOME/.config/$pasta" ]; then
        cp -r "$HOME/.config/$pasta" "$DESTINO/"
        echo "✅ Copiado: $pasta"
    else
        echo "❌ Pasta não encontrada: $pasta"
    fi
done

# Entrar na pasta e enviar para o GitHub
cd "$DESTINO"
git add .
git commit -m "Update dotfiles: $(date +'%d-%m-%Y %H:%M')"
git push origin main

echo "--- Tudo pronto! Backup enviado para o GitHub ---"
