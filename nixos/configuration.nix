{ config, pkgs, inputs, ... }:

{
  i18n.defaultLocale = "fr_FR.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LS_IDENTIFICATION = "fr_FR.UTF-8";
    LS_MEASUREMENT = "fr_FR.UTF-8";
    LS_MONETARY = "fr_FR.UTF-8";
    LS_NAME = "fr_FR.UTF-8";
    LS_NUMERIC = "fr_FR.UTF-8";
    LS_PAPER = "fr_FR.UTF-8";
    LS_TELEPHONE = "fr_FR.UTF-8";
    LS_TIME = "fr_FR.UTF-8";
  };
  
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "25.05";

  # Configurations basiques du système
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gengar";
  #networking.wireless.enable = true;
  networking.networkmanager.enable = true;
  networking.extraHosts =
    ''
    127.0.0.1 api.rg-supervision.local
    127.0.0.1 dashboard.rg-supervision.local
    127.0.0.1 zaza.rg-supervision.local
    127.0.0.1 local.staging.rg.gg
    '';

  console.keyMap = "us";

  hardware.pulseaudio.enable = false;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
  # Enable the COSMIC DE itself
  services.desktopManager.cosmic.enable = true;
  # Enable XWayland support in COSMIC
  services.desktopManager.cosmic.xwayland.enable = true;
  services.displayManager.defaultSession = "cosmic";

  time.timeZone = "Europe/Paris";

  users.users.alex = {
    isNormalUser = true;
    description = "alex";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  virtualisation.docker.enable = true;

  programs.zsh.enable = true;

  services.dbus.enable = true;
  services.udev.packages = [ pkgs.libinput ];  

  services.openvpn.servers = {
    dev = { 
      config = "config /root/openvpn/aviard.ovpn"; 
      updateResolvConf = true;
    };
  };

  boot.kernelModules = [ "kvm-intel" ];  # Pour Intel, remplacez par "kvm-amd" si vous avez un processeur AMD

  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "neovide";
    XKB_DEFAULT_LAYOUT = "us";
  };
}
