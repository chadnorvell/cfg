{
  lib,
  pkgs,
  ...
}:

{
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = (import ./packages.nix { inherit pkgs; });

  fonts.packages = (import ../fonts.nix { inherit pkgs; });

  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      obs-vaapi
    ];
  };

  programs.sway = {
    enable = true;
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
  networking.nameservers = ["192.168.86.1" "8.8.8.8" "8.8.4.4" "1.1.1.1"];

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

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
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  services.tailscale.enable = true;

  security.pam.services.kwallet = {
    name = "kwallet";
    enableKwallet = true;
  };

  security.rtkit.enable = true;

  hardware.keyboard.qmk.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-browsed
      cups-filters
    ];
  };
}
