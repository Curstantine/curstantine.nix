{
  pkgs,
  inputs,
  config,
  ...
}:
let
  keys = import ../keys.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../modules/gc.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "menow";
  networking.networkmanager.enable = false;

  # Manually assign IPs to the NIC since DHCP doesn't work correctly.
  networking = {
    useDHCP = false;
    interfaces.ens3 = {
      ipv4.addresses = [
        {
          address = "141.11.100.152";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = "141.11.100.1";
    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  time.timeZone = "Europe/Amsterdam";
  console.keyMap = "dvorak";

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "alice" ];
      keepEnv = true;
      persist = true;
    }
  ];

  users.defaultUserShell = pkgs.fish;
  users.users.alice = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [ keys.curstantine ];
  };

  programs.fish.enable = true;
  programs.git.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h";
    bantime-increment.enable = true;
    banaction = "nftables-multiport";
    banaction-allports = "nftables-allports";
    jails.sshd.settings.enabled = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.alice = ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
  ];

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
    allowedTCPPorts = [ 22 ];

    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ config.services.tailscale.interfaceName ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  system.stateVersion = "26.05";
}
