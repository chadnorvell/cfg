{
  pkgs,
  pkgs-unstable,
  ...
}:

let
  stable = with pkgs; [
    android-tools
    calibre
    chromium
    cifs-utils
    darktable
    discord
    feh
    firefox
    inkscape
    gimp
    kitty
    mpv
    obsidian
    proton-pass
    qmk
    signal-desktop
    usbutils
    wl-clipboard
    whatsie
  ];

  unstable = with pkgs-unstable; [
  ];

  kde =
    with pkgs;
    with kdePackages;
    [
      falkon
      kbackup
      kcharselect
      kcolorchooser
      kcron
      kjournald
      kompare
      ksystemlog
      partitionmanager
      plasma-vault
      sddm-kcm
      skanpage
    ];
in
stable ++ unstable ++ kde
