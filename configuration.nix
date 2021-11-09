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

  # networking.wireless.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    inputMethod.enabled = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc anthy ];
    defaultLocale = "en_US.UTF-8";
  };
  
  console.keyMap= "us";
  console.font = "Lat2-Terminus16";

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  nixpkgs.overlays = [
    (self: super:
    {
   zoomUsFixed = pkgs.zoom-us.overrideAttrs (old: {
      postFixup = old.postFixup + ''
        wrapProgram $out/bin/zoom-us --unset XDG_SESSION_TYPE
      '';});
   zoom = pkgs.zoom-us.overrideAttrs (old: {
      postFixup = old.postFixup + ''
        wrapProgram $out/bin/zoom --unset XDG_SESSION_TYPE
      '';});
      }
      )
  ];


  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    gnome3.gnome-terminal
    gnome3.nautilus
    gnome3.gedit
    gnome3.gnome-screenshot
    gnome3.gnome-shell-extensions
    vscode wireshark
    docker-compose
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    arc-theme
    gnumake automake cmake
    gcc gdb nodejs
    tilix
    gnome3.gnome-tweaks
    google-chrome
    zoom slack
  ];

  environment.gnome.excludePackages = [ 
    # pkgs.gnome.cheese
    # pkgs.gnome-photos
    # pkgs.gnome.gnome-music 
    pkgs.gnome.gnome-terminal
    # pkgs.gnome.gedit 
    pkgs.epiphany
    pkgs.evince
    pkgs.gnome.gnome-characters
    pkgs.gnome.totem
    pkgs.gnome.tali
    pkgs.gnome.iagno
    pkgs.gnome.hitori
    pkgs.gnome.atomix 
    pkgs.gnome-tour
  ];
  

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Enable touchpad support.
    libinput.enable = true;
    
    videoDrivers = [ "amdgpu" ];
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
    fonts = with pkgs; [ 
      ipafont
      powerline-fonts
      font-awesome-ttf
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

  system.stateVersion = "21.05";
}
