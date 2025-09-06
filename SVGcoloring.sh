#!/bin/bash

# ============================================================================
# SVG Color Converter for Dolphin
#
# Autor:        Ney Designer
# Versão:       1.5 (Consistent Naming Release)
# Licença:      Uso livre
# Descrição:    Script interativo para substituir cores em arquivos SVG.
# ============================================================================

# O caminho do diretório é recebido do Menu de Serviço como o primeiro argumento
DIRETORIO="$1"

# Validação... (o restante do script permanece o mesmo)
if [ ! -d "$DIRETORIO" ]; then
    kdialog --error "Erro: O diretório '$DIRETORIO' não foi encontrado ou não é válido."
    exit 1
fi

COR_ORIGINAL=$(kdialog --inputbox "Digite a cor a ser substituída (ex: #000000):" --title "Cor Original")
if [ $? -ne 0 ]; then
    exit 1
fi

COR_NOVA=$(kdialog --inputbox "Digite a nova cor (ex: #FF0000):" --title "Nova Cor")
if [ $? -ne 0 ]; then
    exit 1
fi

find "$DIRETORIO" -type f -name "*.svg" -print0 | while IFS= read -r -d '' arquivo; do
    sed -i "s/$COR_ORIGINAL/$COR_NOVA/g" "$arquivo"
done

kdialog --msgbox "Concluído! A cor '${COR_ORIGINAL}' foi substituída por '${COR_NOVA}' em todos os arquivos SVG encontrados." --title "Processo Finalizado"

exit 0
