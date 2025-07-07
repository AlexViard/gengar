{ config, pkgs, ... }:

let
  updateScript = pkgs.writeShellScriptBin "update" ''
    #!/bin/sh
    set -e
    if [ -f "/etc/NIXOS" ]; then
      flake_path="$HOME/gengar/nixos"
      echo "Mise à jour de NixOS..."
      sudo nixos-rebuild switch --flake $flake_path#gengar
    fi
    echo "Mise à jour de Home Manager..."
    home-manager switch
  '';
in
{
  home.packages = [ updateScript ];
}
