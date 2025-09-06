#!/bin/bash

# --- Script de Instalação Definitivo (v1.6 - Compatibilidade Máxima) ---

echo "Iniciando a instalação do Menu de Serviço 'Converter Cores SVG'..."
echo "------------------------------------------------------------------"

# Variáveis
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
SERVICE_MENU_FILE="SVGcoloring.desktop"
COLOR_SCRIPT_FILE="SVGcoloring.sh"

# Destinos
BIN_DEST_DIR="$HOME/.local/bin"
SERVICE_MENU_DEST_DIR="$HOME/.local/share/kio/servicemenus"

# Caminhos
SOURCE_SERVICE_MENU="$SCRIPT_DIR/$SERVICE_MENU_FILE"
SOURCE_COLOR_SCRIPT="$SCRIPT_DIR/$COLOR_SCRIPT_FILE"
DEST_COLOR_SCRIPT="$BIN_DEST_DIR/$COLOR_SCRIPT_FILE"
DEST_SERVICE_MENU="$SERVICE_MENU_DEST_DIR/$SERVICE_MENU_FILE"

# Verificação e criação de diretórios
if [ ! -f "$SOURCE_SERVICE_MENU" ] || [ ! -f "$SOURCE_COLOR_SCRIPT" ]; then
    echo "ERRO: Arquivos de instalação não encontrados!"
    exit 1
fi
echo "✓ Arquivos de origem encontrados."
mkdir -p "$BIN_DEST_DIR"
mkdir -p "$SERVICE_MENU_DEST_DIR"
echo "✓ Diretórios de destino verificados/criados."

# Atualização do caminho do executável
sed -i "s|Exec=.*|Exec=$DEST_COLOR_SCRIPT %F|" "$SOURCE_SERVICE_MENU"
echo "✓ Arquivo de serviço atualizado."

# Mover os arquivos
mv "$SOURCE_COLOR_SCRIPT" "$BIN_DEST_DIR/"
mv "$SOURCE_SERVICE_MENU" "$SERVICE_MENU_DEST_DIR/"
echo "✓ Arquivos movidos para os diretórios do sistema."

# Conceder permissão de execução a AMBOS os arquivos
chmod +x "$DEST_COLOR_SCRIPT"
chmod +x "$DEST_SERVICE_MENU" # ESSENCIAL para compatibilidade neste ambiente
echo "✓ Permissões de execução concedidas (compatibilidade máxima)."

echo "------------------------------------------------------------------"
echo "🎉 Instalação concluída com sucesso!"
echo "Para aplicar as alterações, reinicie o Dolphin (dolphin -q && dolphin &)"
exit 0
