#!/bin/bash

# ============================================================================
# SVG Color Converter - Uninstaller
#
# Autor:        Ney Designer (com assistência de IA)
# Versão:       1.0
# Descrição:    Remove de forma segura o Menu de Serviço e o script associado.
# ============================================================================

echo "Iniciando a desinstalação do Menu de Serviço 'Converter Cores SVG'..."
echo "------------------------------------------------------------------"

# Define os caminhos dos arquivos que serão removidos
SCRIPT_FILE="$HOME/.local/bin/SVGcoloring.sh"
SERVICE_MENU_FILE="$HOME/.local/share/kio/servicemenus/SVGcoloring.desktop"

# Passo 1: Solicitar confirmação do usuário (medida de segurança)
echo "Este script removerá os seguintes arquivos:"
echo "  - Script: $SCRIPT_FILE"
echo "  - Menu de Serviço: $SERVICE_MENU_FILE"
echo ""
read -p "Você tem certeza que deseja continuar? (s/N) " confirmacao
echo ""

# Verifica a resposta. Se não for 's' ou 'S', o script é interrompido.
if [[ ! "$confirmacao" =~ ^[sS]$ ]]; then
    echo "Desinstalação cancelada pelo usuário."
    exit 1
fi

# Passo 2: Remover o arquivo de script
if [ -f "$SCRIPT_FILE" ]; then
    rm "$SCRIPT_FILE"
    echo "✓ Arquivo de script removido com sucesso."
else
    echo "i Arquivo de script não encontrado, pulando."
fi

# Passo 3: Remover o arquivo do Menu de Serviço
if [ -f "$SERVICE_MENU_FILE" ]; then
    rm "$SERVICE_MENU_FILE"
    echo "✓ Arquivo do Menu de Serviço removido com sucesso."
else
    echo "i Arquivo do Menu de Serviço não encontrado, pulando."
fi

# Nota: Os diretórios não são removidos, pois são locais padrão do sistema
# e podem conter outros arquivos instalados pelo usuário.

echo "------------------------------------------------------------------"
echo "🎉 Desinstalação concluída!"
echo "Para que as alterações tenham efeito, reinicie o Dolphin."
echo "Comando: dolphin -q && dolphin &"

exit 0
