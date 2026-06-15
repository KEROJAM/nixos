{ config, lib, pkgs, modulesPath, ... }:
{
boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
boot.kernelModules = [ "kvm-intel" ];
boot.initrd.kernelModules = [ "i915" ];
boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_18;
boot.loader.grub.enable = true;
boot.loader.grub.efiSupport = true;
boot.loader.grub.devices = ["nodev"];
boot.loader.efi.canTouchEfiVariables = true;
networking.hostName = "Cuckoo";
networking.networkmanager.enable = true;
time.timeZone = "America/Monterrey";
i18n.defaultLocale = "en_US.UTF-8";


services.logind.settings.Login.HandleLidSwitch = "ignore";
powerManagement.enable = false;
hardware.graphics= {
 enable = true;
 extraPackages = with pkgs; [
 intel-media-driver
 intel-vaapi-driver
 ];
};
hardware.enableAllFirmware = true;
fileSystems."/" = {
 device = "/dev/disk/by-uuid/b10aa19d-a90f-462c-b3f9-b84e61798113";
 fsType = "ext4";
};
fileSystems."/boot" = {
 device = "/dev/disk/by-uuid/3BD6-3EDA";
 fsType = "vfat";
 options = [ "fmask=0077" "dmask=0077" ];
};

swapDevices = [
];
nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
