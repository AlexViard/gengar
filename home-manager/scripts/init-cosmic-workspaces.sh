#!/usr/bin/env bash

# Script pour initialiser les workspaces COSMIC
# Créé le $(date +%d/%m/%Y)

# Vérifier si ydotool est disponible (pour automatiser les interactions clavier sous Wayland)
if ! command -v ydotool &> /dev/null; then
    echo "ydotool n'est pas installé. Installation nécessaire pour ce script."
    exit 1
fi

# Définir les workspaces que vous souhaitez créer
WORKSPACES=("Terminal" "Code" "Web" "Communication" "Media")

# Utilisation de l'API D-Bus pour interagir avec COSMIC
# Cette section pourrait nécessiter des ajustements selon l'API exacte de COSMIC

echo "Initialisation des workspaces COSMIC..."

# Fonction pour créer un workspace s'il n'existe pas déjà
create_workspace() {
    local name="$1"
    echo "Création du workspace: $name"
    
    # Raccourci clavier pour ouvrir le gestionnaire de workspaces (à ajuster selon votre configuration)
    # Super+w est souvent utilisé pour cela
    ydotool key 125:1 25:1 25:0 125:0  # Super+w
    sleep 0.5
    
    # Clique sur "Ajouter un workspace"
    # Ces coordonnées sont approximatives et peuvent nécessiter un ajustement
    ydotool mousemove 1500 100
    sleep 0.2
    ydotool click 0x01
    sleep 0.5
    
    # Saisir le nom du workspace
    ydotool type "$name"
    sleep 0.2
    ydotool key 28:1 28:0  # Appuyer sur Entrée
    sleep 0.5
}

# Créer chaque workspace
for workspace in "${WORKSPACES[@]}"; do
    create_workspace "$workspace"
done

# Ouvrir des applications spécifiques dans leurs workspaces respectifs
# Exemple: ouvrir un terminal dans le workspace Terminal
# ydotool key 125:1 36:1 36:0 125:0  # Super+Enter pour ouvrir un terminal
# sleep 1

echo "Initialisation des workspaces terminée !"
