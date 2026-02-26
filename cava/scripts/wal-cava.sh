#!/bin/bash

# 1. Carrega as cores geradas pelo pywal
source "$HOME/.cache/wal/colors.sh"

# 2. Define o caminho do config do CAVA
CAVA_CONF="$HOME/.config/cava/config"

# 3. Substitui as linhas de cor usando sed (usando as variáveis do pywal)
sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" "$CAVA_CONF"
sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" "$CAVA_CONF"
sed -i "s/^gradient_color_3 = .*/gradient_color_3 = '$color3'/" "$CAVA_CONF"
sed -i "s/^gradient_color_4 = .*/gradient_color_4 = '$color4'/" "$CAVA_CONF"

# 4. Avisa o CAVA para recarregar as configurações (enviando sinal USR1)
# Verifica se o cava está rodando antes de enviar o sinal
if pgrep -x "cava" > /dev/null; then
    pkill -10 cava
fi