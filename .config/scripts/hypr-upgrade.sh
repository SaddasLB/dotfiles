#!/bin/bash

# Directory base per i pacchetti Hyprland
HYPR_DIR="$HOME/hyprpacks"

# Array dei pacchetti da installare nell'ordine corretto
PACKAGES=(
    "hyprlang"
    "hyprcursor"
    "hyprutils"
    "hyprgraphics"
    "aquamarine"
    "hyprpaper"
    "hyprlock"
    "hypridle"
    "hyprland-qtutils"
    "xdg-desktop-portal-hyprland"
)

# URLs dei repository
declare -A REPOS=(
    [hyprlang]="https://github.com/hyprwm/hyprlang.git"
    [hyprcursor]="https://github.com/hyprwm/hyprcursor.git"
    [hyprutils]="https://github.com/hyprwm/hyprutils.git"
    [hyprgraphics]="https://github.com/hyprwm/hyprgraphics.git"
    [aquamarine]="https://github.com/hyprwm/aquamarine.git"
    [hyprpaper]="https://github.com/hyprwm/hyprpaper.git"
    [hyprlock]="https://github.com/hyprwm/hyprlock.git"
    [hypridle]="https://github.com/hyprwm/hypridle.git"
    [hyprland-qtutils]="https://github.com/hyprwm/hyprland-qtutils.git"
    [xdg-desktop-portal-hyprland]="https://github.com/hyprwm/xdg-desktop-portal-hyprland.git"
)

# Funzione per aggiornare/installare un singolo pacchetto
update_package() {
    local package=$1
    local package_dir="$HYPR_DIR/$package"
    
    echo "Processing $package..."
    
    # Controlla se la directory esiste ed è un repository git
    if [ -d "$package_dir/.git" ]; then
        cd "$package_dir"
        # Salva l'hash del commit corrente
        local current_commit=$(git rev-parse HEAD)
        # Aggiorna il repository
        git pull
        # Controlla se ci sono stati cambiamenti
        if [ "$current_commit" = "$(git rev-parse HEAD)" ]; then
            echo "No updates available for $package"
            return 0
        fi
    else
        echo "Directory $package_dir is not a git repository or doesn't exist"
        echo "Please clone the repository first:"
        echo "git clone ${REPOS[$package]} $package_dir"
        return 1
    fi
    
    # Rimuovi la directory build se esiste
    rm -rf build/
    
    # Configurazione speciale per xdg-desktop-portal-hyprland
    if [ "$package" = "xdg-desktop-portal-hyprland" ]; then
        cmake -DCMAKE_INSTALL_LIBEXECDIR=/usr/lib -DCMAKE_INSTALL_PREFIX=/usr -B build
    else
        cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
    fi
    
    # Build del pacchetto
    if [ "$package" = "hyprpaper" ] || [ "$package" = "hyprlock" ] || [ "$package" = "hypridle" ] || [ "$package" = "hyprlang" ]; then
        cmake --build ./build --config Release --target $package -j$(nproc)
    else
        cmake --build ./build --config Release --target all -j$(nproc)
    fi
    
    # Installazione
    sudo cmake --install build
    
    echo "$package updated successfully"
}

# Main script
main() {
    # Verifica che la directory esista
    if [ ! -d "$HYPR_DIR" ]; then
        echo "Error: Directory $HYPR_DIR does not exist"
        exit 1
    fi
    
    # Aggiorna tutti i pacchetti nell'ordine specificato
    for package in "${PACKAGES[@]}"; do
        update_package "$package"
    done
}

# Esegui lo script
main
