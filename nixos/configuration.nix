{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./shell.nix
    ];

  environment.pathsToLink = [ "/libexec" ];
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = { 
    enable = true;
    version = 2;
    device = "/dev/sda"; # or "nodev" for efi only
    # efiSupport = true;
    # efiInstallAsRemovable = true;
  };

  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "akakou-pc";
  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


  # Select internationalisation properties.
  i18n = {
    inputMethod.enabled = "ibus";
    inputMethod.ibus.engines = with pkgs.ibus-engines; [ mozc anthy ];
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    gnome3.gnome-terminal
    gnome3.nautilus
    gnome3.gedit
    gnome3.gnome-screenshot
    chromium vscode
    wireshark
    docker-compose
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    gnumake automake
    gcc gdb nodejs
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";

    # Enable the i3 Desktop Environment.
    windowManager = {
      i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
       ];
      };
    };
    desktopManager.xterm.enable = false;

    # Enable touchpad support.
    libinput.enable = true;

    # Enable LightDM
    displayManager.lightdm.enable = true;
  };

  # Enable the zsh Environment
  programs.zsh.enable = true;

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

  system.stateVersion = "19.03";
}
