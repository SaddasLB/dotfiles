#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/wallpapers"
SETTER_SCRIPT="$HOME/.config/scripts/wallpaper-setter.sh"
PREVIEW_WIDTH=40
PREVIEW_HEIGHT=20

# Funzione per verificare se stiamo eseguendo in Kitty
is_kitty() {
    [ "$TERM" = "xterm-kitty" ]
}

# Funzione per ripristinare lo stato del terminale
cleanup_terminal() {
    # Ripristina il cursore
    echo -e "\e[?25h"
    # Ripristina i colori
    echo -e "\e[0m"
    # Pulisci lo schermo
    clear
    # Se siamo in kitty, pulisci le immagini
    if is_kitty; then
        kitty +kitten icat --clear --silent
    fi
    # Ripristina le impostazioni del terminale
    stty sane
}

# Aggiungi trap per gestire interruzioni
trap cleanup_terminal EXIT INT TERM

# Funzione per mostrare un'immagine usando il protocollo kitty
show_image() {
    local image="$1"
    if is_kitty; then
        kitty +kitten icat --clear --silent
        kitty +kitten icat --transfer-mode=file --place="${PREVIEW_WIDTH}x${PREVIEW_HEIGHT}@$(($PREVIEW_WIDTH + 20))x4" "$image"
    fi
}

# Funzione per ottenere il numero di righe del terminale
get_terminal_height() {
    tput lines
}

# Funzione per ottenere il numero di colonne del terminale
get_terminal_width() {
    tput cols
}

# Funzione per pulire una specifica area del terminale
clear_area() {
    local start_line=$1
    local end_line=$2
    for ((i=start_line; i<=end_line; i++)); do
        echo -en "\033[${i};0H\033[K"
    done
}

# Funzione per posizionare il cursore
goto_xy() {
    echo -en "\033[$2;${1}H"
}

show_header() {
    goto_xy 1 1
    echo "======================================="
    echo "         Selettore Wallpaper           "
    echo "======================================="
    echo "Wallpaper disponibili:"
    echo "---------------------------------------"
}

show_footer() {
    local term_height=$(get_terminal_height)
    goto_xy 1 $((term_height - 5))
    echo "======================================="
    echo "Comandi disponibili:"
    echo "↑/k - Sposta selezione in su"
    echo "↓/j - Sposta selezione in giù"
    echo "Enter - Seleziona | q - Esci"
}

list_wallpapers() {
    local start_idx=$1
    local visible_items=$2
    local count=1
    local term_height=$(get_terminal_height)
    local list_start=6  # Riga dove inizia la lista
    local list_end=$((term_height - 7))  # Riga dove finisce la lista

    # Pulisci l'area della lista
    clear_area $list_start $list_end

    # Mostra le voci visibili
    local displayed=0
    for img in "$WALLPAPERS_DIR"/*; do
        if [[ -f "$img" ]] && [[ "$img" =~ \.(jpg|jpeg|png|gif)$ ]]; then
            if [ $count -ge $start_idx ] && [ $displayed -lt $visible_items ]; then
                goto_xy 1 $((list_start + displayed))
                if [ "$count" -eq "$current_selection" ]; then
                    echo -e "\e[1;33m $count) $(basename "$img")\e[0m"
                    show_image "$img"
                else
                    echo "$count) $(basename "$img")"
                fi
                ((displayed++))
            fi
            ((count++))
        fi
    done
}

# Funzione migliorata per leggere input incluse le frecce
read_key() {
    # Salva le impostazioni correnti del terminale
    local old_settings=$(stty -g)
    
    # Imposta il terminale per la lettura carattere per carattere
    stty raw -echo
    
    # Leggi il primo carattere
    local c=$(dd bs=1 count=1 2>/dev/null)
    
    # Se è un escape character (27), potrebbe essere una freccia
    if [[ $(printf "%d" "'$c") -eq 27 ]]; then
        # Leggi i prossimi due caratteri
        local c2=$(dd bs=1 count=1 2>/dev/null)
        local c3=$(dd bs=1 count=1 2>/dev/null)
        
        # Ripristina le impostazioni del terminale
        stty "$old_settings"
        
        # Interpreta la sequenza di escape
        if [[ $c2 == '[' ]]; then
            case $c3 in
                'A') echo "UP"    ;;  # Freccia su
                'B') echo "DOWN"  ;;  # Freccia giù
                *)   echo "OTHER" ;;
            esac
        fi
    else
        # Ripristina le impostazioni del terminale
        stty "$old_settings"
        
        # Gestisci specificamente il carattere return
        if [[ $(printf "%d" "'$c") -eq 13 ]]; then
            echo "ENTER"
        else
            # Restituisci il carattere singolo
            echo "$c"
        fi
    fi
}

main() {
    local wallpapers=()
    local current_selection=1
    local start_idx=1
    local term_height=$(get_terminal_height)
    local visible_items=$((term_height - 13))  # Spazio disponibile per la lista
    local total_items=0
    local key

    # Disabilita il cursore
    echo -e "\e[?25l"
    
    # Conta il numero totale di wallpaper
    for img in "$WALLPAPERS_DIR"/*; do
        if [[ -f "$img" ]] && [[ "$img" =~ \.(jpg|jpeg|png|gif)$ ]]; then
            ((total_items++))
        fi
    done

    # Salva le impostazioni iniziali del terminale
    local original_terminal_settings=$(stty -g)

    while true; do
        show_header
        list_wallpapers $start_idx $visible_items
        show_footer

        key=$(read_key)
        case $key in
            q|Q)
                cleanup_terminal
                exit 0
                ;;
            UP|k) # Su
                if [ "$current_selection" -gt 1 ]; then
                    ((current_selection--))
                    # Aggiusta la finestra di visualizzazione se necessario
                    if [ "$current_selection" -lt "$start_idx" ]; then
                        ((start_idx--))
                    fi
                fi
                ;;
            DOWN|j) # Giù
                if [ "$current_selection" -lt "$total_items" ]; then
                    ((current_selection++))
                    # Aggiusta la finestra di visualizzazione se necessario
                    if [ "$current_selection" -ge $((start_idx + visible_items)) ]; then
                        ((start_idx++))
                    fi
                fi
                ;;
            ENTER) # Gestione del tasto Enter
                # Salva lo stato corrente del terminale
                local temp_settings=$(stty -g)
                
                clear
                if is_kitty; then
                    kitty +kitten icat --clear --silent
                fi
                
                # Trova il wallpaper selezionato
                local selected_number=1
                local selected_wallpaper=""
                
                for img in "$WALLPAPERS_DIR"/*; do
                    if [[ -f "$img" ]] && [[ "$img" =~ \.(jpg|jpeg|png|gif)$ ]]; then
                        if [ "$selected_number" -eq "$current_selection" ]; then
                            selected_wallpaper="$img"
                            break
                        fi
                        ((selected_number++))
                    fi
                done

                if [ -n "$selected_wallpaper" ]; then
                    echo "Impostazione wallpaper: $(basename "$selected_wallpaper")"
                    "$SETTER_SCRIPT" "$selected_wallpaper"
                    
                    # Pulisci lo schermo e ripristina lo stato del menu
                    clear
                    echo -e "\e[?25l"
                    
                    # Esce dallo script dopo l'impostazione del wallpaper
                    cleanup_terminal
                    exit 0
                fi
                ;;
        esac
    done
}

# Verifiche iniziali
if [ ! -d "$WALLPAPERS_DIR" ]; then
    echo "Errore: Directory $WALLPAPERS_DIR non trovata!"
    exit 1
fi

if [ ! -f "$SETTER_SCRIPT" ]; then
    echo "Errore: Script setter $SETTER_SCRIPT non trovato!"
    exit 1
fi

if ! is_kitty; then
    echo "Attenzione: Non stai usando Kitty. Le preview non saranno disponibili."
    sleep 2
fi

# Avvia il programma
main
