{ config, lib, pkgs, ... }:

{
  home.file.".config/autostart/cosmic-workspace-init.desktop" = {
    text = ''
[Desktop Entry]
Name=Initialisation des workspaces COSMIC
Comment=Initialise automatiquement les workspaces COSMIC au démarrage
Exec=/home/alex/.local/bin/cosmic-workspace-init
Type=Application
Categories=Utility;
X-GNOME-Autostart-enabled=true
    '';
    executable = false;
  };
}
