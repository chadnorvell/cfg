{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/bcb30822-b01a-4079-9ac1-c84b031007fc";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B079-89A1";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/68ba455f-dcb9-4801-9452-c9485e5c4e35"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "suspend-then-hibernate";
        HandleLidSwitchDocked = "ignore";
        HandlePowerKey = "suspend-then-hibernate";
      };
    };
  };

  systemd.sleep = {
    extraConfig = ''
      HibernateOnACPower=no
      HibernateDelaySec=240min
    '';
  };

#  services.evremap = {
#    enable = true;
#     settings = {
#       device_name = "AT Translated Set 2 keyboard";
#       dual_role = [
#         {
#           input = "KEY_TAB";
#           tap = [ "KEY_TAB" ];
#           hold = [
#             "KEY_LEFTCTRL"
#             "KEY_LEFTALT"
#             "KEY_LEFTSHIFT"
#           ];
#         }
#       ];
#       remap = [
#         {
#           input = [ "KEY_LEFTCTRL" ];
#           output = [
#             "KEY_LEFTCTRL"
#             "KEY_LEFTSHIFT"
#           ];
#         }
#         {
#           input = [ "KEY_CAPSLOCK" ];
#           output = [ "KEY_LEFTCTRL" ];
#         }
#       ];
#     };
#   };
}
