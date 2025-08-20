{
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
stable ++ unstable ++ kde
