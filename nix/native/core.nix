{
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

let
  stable = with pkgs; [
    android-tools
    brightnessctl
    calibre
    darktable
    discord
    firefox
    inkscape
    gimp
    grim
    kitty
    lazydocker
    lazyjournal
    mako
    mpv
    neovide
    obsidian
    playerctl
    proton-pass
    pwvucontrol
    shikane
    slurp
    todoist-electron
    wl-clipboard
    waybar
    wdisplays
    wofi
  ];

  unstable = with pkgs-unstable; [
    beeper
    wiremix
  ];

  hypr = with pkgs-unstable; [
    hypridle
    hyprland
    hyprpaper
  ];

  kde =
    with pkgs;
    with kdePackages;
    [
      ark
      chromium
      elisa
      gwenview
      kate
      kcharselect
      kcolorchooser
      kcron
      kjournald
      kompare
      ksystemlog
      kwallet
      okular
      partitionmanager
      sddm-kcm
      skanpage
    ];
in
{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = stable ++ unstable ++ hypr ++ kde;

  fonts.packages = (import ../fonts.nix { inherit pkgs; });

  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
    ];
  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  programs.uwsm = {
    enable = true;

    waylandCompositors.sway = {
      prettyName = "Sway";
      binPath = "/run/current-system/sw/bin/sway";
    };
  };

  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.useDHCP = lib.mkDefault true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.blueman.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.openssh.enable = true;
  services.printing.enable = true;
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  security.rtkit.enable = true;
}
