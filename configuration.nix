{ config, pkgs, ... }:
 

{
  imports =
    [
      ./hardware-configuration.nix
      ./shell.nix
    ];

  environment.pathsToLink = [ "/libexec" ];
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
  };


  # networking.wireless.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    inputMethod.enabled = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc ];
    defaultLocale = "en_US.UTF-8";
  };
  
  console.keyMap= "us";
  console.font = "Lat2-Terminus16";

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    pkgs.nautilus
    pkgs.gedit
    pkgs.gnome-screenshot
    pkgs.gnome-shell-extensions
    vscode wireshark
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    arc-theme
    tilix
    # gnone-tweaks
    brave 
    zoom-us slack discord
  ];

  environment.gnome.excludePackages = with pkgs; [ 
    # pkgs.gnome.cheese
    # pkgs.gnome-photos
    # pkgs.gnome.gnome-music 
    # pkgs.gnome.gedit 
    gnome-terminal
    epiphany
    evince
    gnome-characters
    totem
    tali
    iagno
    hitori
    atomix 
    gnome-tour
  ];
  

  # Enable sound.
  services.logind.extraConfig = ''
   RuntimeDirectorySize=4G
  '';

  # Enable bluetooth.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;

    desktopManager.gnome.enable = true;

    # Enable touchpad support.
    libinput.enable = true;
  };

  # Enable the zsh Environment
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  users.users.akakou = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "wireshark" ];
    uid = 1000;
    shell = pkgs.zsh;
  };

  virtualisation = {
    docker.enable = true;
  };

  fonts = {
    packages = with pkgs; [ 
      ipafont
      powerline-fonts
      font-awesome
    ];

    fontconfig = { 
      defaultFonts = {
        monospace = [ 
          "DejaVu Sans Mono for Powerline"
          "IPAGothic"
          "Baekmuk Dotum"
        ];
        serif = [ 
          "DejaVu Serif"
          "IPAPMincho"
          "Baekmuk Batang"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAPGothic"
          "Baekmuk Dotum"
        ];
      };
    };
  };

  system.stateVersion = "25.05";
}
