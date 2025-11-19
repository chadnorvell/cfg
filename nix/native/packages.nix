{
  pkgs,
  ...
}:

let
  stable = with pkgs; [
    android-tools
    blueman
    bluez
    brightnessctl
    # calibre # Install hangs.
    chromium
    cifs-utils
    darktable
    discord
    feh
    firefox
    inkscape
    gimp
    (google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      ];
    })
    grim
    kitty
    libqalculate
    mako
    mpv
    networkmanagerapplet
    obsidian
    playerctl
    proton-pass
    pwvucontrol
    qmk
    shikane
    signal-desktop
    slurp
    usbutils
    viu
    waybar
    wdisplays
    wl-clipboard
    vlc
    wofi
  ];

  kde =
    with pkgs;
    with kdePackages;
    [
      digikam
      falkon
      kbackup
      kcharselect
      kcolorchooser
      kcron
      kget
      kjournald
      kompare
      ksystemlog
      partitionmanager
      plasma-vault
      sddm-kcm
      skanpage
    ];
in
stable ++ kde
