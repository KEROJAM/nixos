# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
	enable = true;
	devices = [ "nodev" ];
	efiSupport = true;
	useOSProber = true;
      };
     };
    kernelParams = [ "i915.force_probe=7d55" ];
    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "rtsx_pci_sdmmc" "nvme" "vmd" "thunderbolt" "sdhci_pci"];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages =  with config.boot.kernelPackages; [ v4l2loopback ];
    extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
    tmp.cleanOnBoot = true;
  };
  powerManagement.enable = true;
  hardware = {
  graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
	intel-media-driver
	vaapiIntel
	intel-ocl
	libvdpau-va-gl
	];
  };
  intel-gpu-tools.enable = true;
  nvidia = {
    modesetting.enable = true;
    open = false;
    powerManagement.enable = false;
    powerManagement.finegrained = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    prime = {
	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";
	offload = {
	  enable = true;
	  enableOffloadCmd = true;
	};
    };
  };
};
services.xserver.videoDrivers = [ "nvidia" ];

services.tlp = {
  enable = true;
  settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

    START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
    STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
  };
};
# Sound

	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
		wireplumber.enable = true;
		extraConfig.pipewire."92-low-latency" = {
  			context.properties = {
    			default.clock.rate = 48000;
    			default.clock.quantum = 32;
    			default.clock.min-quantum = 32;
    			default.clock.max-quantum = 32;
 		 	};
	    };
  };


  networking.hostName = "lily"; # Define your hostname.
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/118486f6-39d7-426f-97df-e81ded522928";
      fsType = "ext4";
    };
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/71C9-1219";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
#  fileSystems."/mnt/Windows"=
#    { device = "/dev/disk/by-uuid/C64A1CD24A1CC0DB";
#      fsType = "ntfs";
#    };

  swapDevices = [
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
