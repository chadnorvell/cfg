{ lib, pkgs, ... }:

let
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
  environment.systemPackages =
    with pkgs;
    [
      android-tools
      beeper
      calibre
      darktable
      discord
      firefox
      inkscape
      gimp
      (google-chrome.override {
        commandLineArgs = [
          "--enable-features=AcceleratedVideoEncoder"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      })
      kitty
      mpv
      neovide
      obsidian
      proton-pass
      todoist-electron
      wl-clipboard
    ]
    ++ kde;

  fonts.packages = (import ../fonts.nix { inherit pkgs; });

  programs.hyprland.enable = true;

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
    ];
  };

  networking.networkmanager.enable = true;
  networking.useDHCP = lib.mkDefault true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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
  };

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  security.rtkit.enable = true;
}
