#!/bin/bash
echo "========================================"
echo "       Endpoints Extractor by Russo-sec"
echo "========================================"

show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo "  -u URL    URL unico para escanear"
    echo "  -l FILE   Arquivo com lista de URLs"
    echo "  -s FILE   Salvar output em arquivo"
    echo "  -h        Exibir ajuda"
    exit 0
}

extract_urls() {
    local content="$1"
    # Extrai URLs absolutas E caminhos relativos
    echo "$content" | grep -Eo '(https?://[^"'\''> ]+|/[a-zA-Z0-9/_-]+\.[a-z]{2,4})' | sort -u
}

scan_url() {
    local target="$1"
    echo "[*] Scanning: $target"
    local content
    content=$(curl -sL --max-time 15 "$target" 2>/dev/null) || {
        echo "[!] Erro ao buscar: $target"
        return 1
    }
    extract_urls "$content"
}

url=""
url_list=""
save_file=""
all_results=""

while getopts "u:l:s:h" opt; do
    case $opt in
        u) url="$OPTARG" ;;
        l) url_list="$OPTARG" ;;
        s) save_file="$OPTARG" ;;
        h) show_help ;;
        *) show_help ;;
    esac
done

if [[ -z $url && -z $url_list ]]; then
    echo "Erro: -u ou -l e obrigatorio."
    show_help
fi

# Processa URL unica
if [[ -n $url ]]; then
    result=$(scan_url "$url")
    echo "$result"
    all_results+="$result"$'\n'
fi

# Processa lista — SEM re-executar curl depois
if [[ -n $url_list ]]; then
    [[ ! -f $url_list ]] && { echo "Erro: arquivo $url_list nao encontrado."; exit 1; }
    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        result=$(scan_url "$line")
        echo "$result"
        all_results+="$result"$'\n'
    done < "$url_list"
fi

# Salva uma unica vez com os resultados ja coletados
if [[ -n $save_file ]]; then
    echo "$all_results" | sort -u > "$save_file"
    echo "[+] Resultados salvos em: $save_file"
fi
