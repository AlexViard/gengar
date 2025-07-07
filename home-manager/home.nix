{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
    ./modules/update.nix
    ./modules/cosmic-workspace.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    git
    teams-for-linux
    wl-clipboard 
    kitty
    chromium
    google-chrome
    acpi
    gnumake
    delta
    nerd-fonts.fira-code
    spotify
    ripgrep
    slack
    bat
    btop
    discord
    neofetch
    unzip
    grim
    slurp
    docker
    mkcert
    figma-linux
    vscode
    playerctl
    nodejs_22
    ydotool  # Pour l'automatisation des interactions clavier/souris sous Wayland
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/bat" = { source = ./configs/bat; recursive = true; };
    ".config/btop" = { source = ./configs/btop; recursive = true; };
    ".config/kitty" = { source = ./configs/kitty; recursive = true; };
    ".local/bin/init-cosmic-workspaces" = { 
      source = ./scripts/init-cosmic-workspaces.sh; 
      executable = true; 
    };
    ".local/bin/cosmic-workspace-init" = { 
      source = ./scripts/cosmic-workspace-init.sh; 
      executable = true; 
    };

    ## ".ssh/" = { source = ./configs/ssh; recursive = true; };
    ".gitconfig" = { source = ./configs/git/.gitconfig; };
    ".gitignore" = { source = ./configs/git/.gitignore; };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alex/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XKB_DEFAULT_LAYOUT = "fr";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
