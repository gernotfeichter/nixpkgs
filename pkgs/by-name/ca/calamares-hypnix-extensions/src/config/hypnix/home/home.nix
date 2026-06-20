{ hyprland, pkgs, osConfig, ...}: {

  imports = [
    ./programs
    ./scripts
    ./themes
  ];

  home.file.".zshrc".text = "";

  

  home.packages = (with pkgs; [
    
    #User Apps
    celluloid
    librewolf
    cool-retro-term
    bibata-cursors
    lollypop
    lutris
    openrgb

    #utils
    ranger
    wlr-randr
    git
    rustup
    gnumake
    catimg
    curl
    appimage-run
    
    dunst
    pavucontrol
    sqlite
    waypaper

    #misc 
    cava
    nano
    nitch
    wget
    grim
    slurp
    wl-clipboard
    pamixer
    mpc
    tty-clock
    eza
    btop
    tokyonight-gtk-theme
    dconf
    pipewire
    waypaper
    nautilus
    zenity
    gnome-tweaks
    eog
  ]);
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/shell/extensions/user-theme" = {
      name = "Tokyonight-Dark-B-LB";
    };
  };

  programs.home-manager.enable = true;

  home.stateVersion = osConfig.system.stateVersion;

  nixpkgs.config.allowUnfree = true;
}
