{
  hostName,
  user,
}:
{
  lib,
  pkgs,
  ...
}:

let
  systemPkgs = with pkgs; [
    android-tools
    bat
    btop
    # calibre # Install hangs.
    chezmoi
    chromium
    cifs-utils
    clang
    clang-tools
    curl
    darktable
    delta
    discord
    eza
    fastfetch
    fd
    feh
    ffmpeg
    file
    firefox
    fish-lsp
    flac
    fzf
    gcc
    gimp
    git
    git-lfs
    glow
    (google-chrome.override {
      commandLineArgs = [
        "--ozone-platform=wayland"
        "--enable-features=UseOzonePlatform,VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      ];
    })
    groff
    gum
    hexyl
    htop
    imagemagick
    inkscape
    jq
    lua-language-server
    man-pages
    man-pages-posix
    mpv
    neovide
    neovim
    nil
    nixfmt
    obsidian
    openssh
    opusTools
    procps
    proton-pass
    psmisc
    ripgrep
    rsgain
    rsync
    signal-desktop
    silver-searcher
    statix
    stylua
    trash-cli
    usbutils
    vim
    viu
    vlc
    wl-clipboard
    yazi
    yq
  ];

  kdePkgs =
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
      plasma-browser-integration
      plasma-vault
      sddm-kcm
      skanpage
    ];

  fontPkgs = with pkgs; [
    font-awesome
    iosevka
    libertine
    nerd-fonts.iosevka
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    ubuntu-sans
    ubuntu-sans-mono
  ];
in
{
  system.stateVersion = "25.11";

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  };

  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [ "@wheel" ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    documentation = {
      enable = true;
      generateCaches = true;

      dev.enable = true;
      doc.enable = true;
      info.enable = true;
      man.enable = true;
      nixos.enable = true;
    };
  };

  users.users.${user.name} = {
    description = user.description;
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
    useDefaultShell = false;
    shell = pkgs.fish;
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  security.rtkit.enable = true;

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = true;
  };

  hardware.keyboard.qmk.enable = true;

  networking.hostName = hostName;
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.useDHCP = lib.mkDefault true;
  networking.nameservers = [
    "192.168.86.1"
    "8.8.8.8"
    "8.8.4.4"
    "1.1.1.1"
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = systemPkgs ++ kdePkgs;
  fonts.packages = fontPkgs;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ user.name ];
  };

  programs.fish.enable = true;
  programs.ssh.startAgent = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.openssh.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.pulseaudio.enable = false;

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-browsed
      cups-filters
    ];
  };

  services.tailscale.enable = true;

  services.xserver = {
    enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  virtualisation.docker = {
    enable = true;
  };
}
