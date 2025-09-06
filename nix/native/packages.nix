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
    feh
    firefox
    inkscape
    gimp
    grim
    helvum
    kitty
    mako
    meld
    mpv
    neovide
    obsidian
    playerctl
    proton-pass
    pwvucontrol
    qmk
    shikane
    slurp
    todoist-electron
    usbutils
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
