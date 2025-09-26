{
  pkgs,
  pkgs-unstable,
  ...
}:

let
  stable = with pkgs; [
    android-tools
    bluetuith
    brightnessctl
    calibre
    cifs-utils
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
    signal-desktop
    shikane
    slurp
    usbutils
    wl-clipboard
    waybar
    wdisplays
    whatsie
    wofi
  ];

  unstable = with pkgs-unstable; [
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
