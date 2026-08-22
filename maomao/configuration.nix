# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../modules/gc.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 3;
  boot.loader.timeout = 0;
  boot.loader.systemd-boot.consoleMode = "2";
  boot.kernelParams = [
    "quiet"
    "boot.shell_on_fail"
    "udev.log_level=3"
    "systemd.show_status=auto"
    "amdgpu.gpu_recovery=1"

    # zswap
    "zswap.enabled=1"
    "zswap.compressor=lz4"
    "zswap.max_pool_percent=25"
    "zswap.shrinker_enabled=1"
  ];

  # Nvidia
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General.Experimental = true;
  };

  # Plymouth
  boot.plymouth.enable = true;

  networking.hostName = "maomao";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Colombo";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "dvorak";
    font = "Lat2-Terminus16";
  };

  # DM Setup (KDE)
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "dvorak";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };

  # Doas
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "curstantine" ];
      keepEnv = true;
      persist = true;
    }
  ];

  # User Management
  users.defaultUserShell = pkgs.fish;
  users.users.curstantine = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "kvm"
      # "libvirtd"
      "podman"
    ];
    useDefaultShell = true;
  };

  # Home Manager setup
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.curstantine = ./home.nix;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # Extra Programs
  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  programs.steam.enable = true;

  # V2Ray
  services.v2raya.enable = true;

  # Podman
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
  };

  # QEMU
  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu.swtpm.enable = true;
  # };
  # virtualisation.spiceUSBRedirection.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    helix

    # KDE
    kdePackages.kcolorchooser
    kdePackages.sddm-kcm
    kdePackages.partitionmanager

    # Nvidia
    lact

    # QEMU
    # gnome-boxes
    # dnsmasq
  ];

  # Exclude extra apps installed by Plasma
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    konsole
    krunner
    kate
  ];

  # List services that you want to enable:
  services.udev = {
    packages = with pkgs; [
      # For vial to work
      qmk-udev-rules
      vial
    ];
  };

  services.lact.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Tailscale
  services.tailscale.enable = true;
  networking.nftables.enable = true;

  # Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];

  # Optimization: Prevent systemd from waiting for network online
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # Open ports in the firewall.
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3000
      4096
    ];

    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];

    # 1714-1764 are used by KDE Connect
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
  networking.wireguard.enable = true;

  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
