{ config, pkgs, ... }:

let
  updateScript = pkgs.writeShellScriptBin "openvide" ''
    #!/bin/bash
    code $(cd ~ && find . -maxdepth 3 -type d | dmenu)
  '';
in
{
  home.packages = [ updateScript ];
}
