{
  pkgs,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "alice";
  networking.networkmanager.enable = false;

  time.timeZone = "Asia/Colombo";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
    # Add your public SSH key before disabling password authentication:
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAA..." ];
  };

  programs.fish.enable = true;
  programs.git.enable = true;

  services.openssh = {
    enable = true;
    settings.PermitRootLogin = "no";
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

  system.stateVersion = "25.05";
}
