#!/bin/bash

# Teu utilizador do GitHub
USER_GITHUB="afutuga"
REPO_NAME="dotfiles"

# Pasta temporária para o clone
TEMP_DIR="$HOME/temp_dots"

echo "--- A iniciar o restauro dos dotfiles ---"

# 1. Instalar o Git se não existir (CachyOS/Arch)
if ! command -v git &> /dev/null; then
    echo "Instalando o Git..."
    sudo pacman -S git --noconfirm
fi

# 2. Clonar o repositório
echo "Clonando o repositório do GitHub..."
git clone "https://github.com/$USER_GITHUB/$REPO_NAME.git" "$TEMP_DIR"

# 3. Criar a pasta .config se não existir
mkdir -p "$HOME/.config"

# 4. Mover as pastas para o destino correto
echo "Instalando configurações..."
cp -r "$TEMP_DIR"/* "$HOME/.config/"

# Limpeza
rm -rf "$TEMP_DIR"

echo "--- Restauro concluído! ---"
echo "Dica: Pode ser necessário reiniciar o Hyprland (Super+M ou logout) para ver as mudanças."
