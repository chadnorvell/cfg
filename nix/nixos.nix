{
  hostName,
  user,
  extraGroups,
}:
{
  pkgs,
  ...
}:

let
  extraPkgs = with pkgs; [
    android-tools
    cifs-utils
    psmisc
  ];
in
{
  system.stateVersion = "25.05";
  nix.settings.trusted-users = [ "@wheel" ];
  networking.hostName = hostName;
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

  security.sudo = {
    enable = true;
    execWheelOnly = true;
    wheelNeedsPassword = true;
  };

  users.users.${user} = {
    description = "Chad Norvell";
    isNormalUser = true;
    extraGroups = [ "wheel" ] ++ extraGroups;
    useDefaultShell = false;
    shell = pkgs.fish;
    packages = (import ./packages.nix { inherit pkgs; }) ++ extraPkgs;
  };

  programs.fish.enable = true;

  programs.ssh.startAgent = true;
}
