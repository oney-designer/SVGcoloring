#!/bin/bash

# ============================================================================
# SVG Color Converter for Dolphin
#
# Autor:        Ney Designer (com assistência de IA)
# Versão:       2.0 (Melhorias: case-insensitive e remoção de '#')
# Licença:      Uso livre
# Descrição:    Script interativo para substituir cores em arquivos SVG.
# ============================================================================

# O caminho do diretório é recebido do Menu de Serviço como o primeiro argumento
DIRETORIO="$1"

# Validação do diretório
if [ ! -d "$DIRETORIO" ]; then
    kdialog --error "Erro: O diretório '$DIRETORIO' não foi encontrado ou não é válido."
    exit 1
fi

# Pede a cor original ao usuário
COR_ORIGINAL_INPUT=$(kdialog --inputbox "Digite a cor a ser substituída (ex: #000000):" --title "Cor Original")
if [ $? -ne 0 ]; then
    exit 1
fi

# Pede a nova cor ao usuário
COR_NOVA_INPUT=$(kdialog --inputbox "Digite a nova cor (ex: #FF0000):" --title "Nova Cor")
if [ $? -ne 0 ]; then
    exit 1
fi

# --- MELHORIA 1: REMOVENDO O '#' ---
# Usa a expansão de parâmetro do Bash para remover um único '#' do início da string, se existir.
COR_ORIGINAL="${COR_ORIGINAL_INPUT#\#}"
COR_NOVA="${COR_NOVA_INPUT#\#}"

# Encontra e modifica os arquivos SVG
find "$DIRETORIO" -type f -name "*.svg" -print0 | while IFS= read -r -d '' arquivo; do
    # --- MELHORIA 2: IGNORANDO MAIÚSCULAS/MINÚSCULAS ('I') ---
    # Adicionada a flag 'I' para a substituição ser case-insensitive.
    sed -i "s/$COR_ORIGINAL/$COR_NOVA/gI" "$arquivo"
done

# Notifica o usuário sobre a conclusão
kdialog --msgbox "Concluído! A cor '${COR_ORIGINAL_INPUT}' foi substituída por '${COR_NOVA_INPUT}' em todos os arquivos SVG encontrados." --title "Processo Finalizado"

exit 0
