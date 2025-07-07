#!/usr/bin/env bash

# Script pour initialiser les workspaces COSMIC via D-Bus (si disponible)
# Créé le $(date +%d/%m/%Y)

# Noms des workspaces à créer
WORKSPACES=("Terminal" "Code" "Web" "Communication" "Media")

echo "Tentative d'initialisation des workspaces COSMIC via D-Bus..."

# Vérifier si cosmic-workspace est disponible via D-Bus
if ! busctl list | grep -q "gg.cosmic.Workspace"; then
    echo "L'API D-Bus de COSMIC Workspace n'est pas détectée."
    echo "Utilisation de la méthode alternative (init-cosmic-workspaces)..."
    
    # Appeler le script basé sur ydotool
    if command -v init-cosmic-workspaces &> /dev/null; then
        init-cosmic-workspaces
        exit $?
    else
        echo "Script init-cosmic-workspaces non trouvé."
        echo "Veuillez exécuter 'home-manager switch' pour l'installer."
        exit 1
    fi
fi

# Si l'API D-Bus est disponible, l'utiliser pour créer les workspaces
for workspace in "${WORKSPACES[@]}"; do
    echo "Création du workspace: $workspace"
    # Cette commande est hypothétique et devra être adaptée à l'API réelle de COSMIC
    busctl call gg.cosmic.Workspace /gg/cosmic/Workspace gg.cosmic.Workspace CreateWorkspace s "$workspace"
    sleep 0.5
done

echo "Initialisation des workspaces terminée !"

# Optionnel : Ouvrir certaines applications dans leurs workspaces respectifs
# Par exemple :
# busctl call gg.cosmic.Workspace /gg/cosmic/Workspace gg.cosmic.Workspace LaunchApp ss "Terminal" "kitty"
