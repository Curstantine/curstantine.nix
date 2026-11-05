{
  pkgs,
  inputs,
  keys,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../modules/gc.nix
  ];

  # Hyper-V generation 2 uses UEFI. Disable Secure Boot in the VM settings,
  # since systemd-boot is not signed.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 0;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "lakan";
  networking.networkmanager.enable = false;
  networking.useDHCP = true;

  time.timeZone = "Asia/Colombo";
  console.keyMap = "dvorak";

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    {
      users = [ "curstantine" ];
      keepEnv = true;
      persist = true;
    }
  ];

  users.defaultUserShell = pkgs.fish;
  users.users.curstantine = {
    isNormalUser = true;
    linger = true;
    extraGroups = [ "wheel" ];
    useDefaultShell = true;
    openssh.authorizedKeys.keys = [ keys.curstantine ];
  };

  programs.fish.enable = true;
  programs.git.enable = true;

  # Accept connections from the Windows host over the Hyper-V network.
  # Key-only auth, using the key from keys.nix.
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.curstantine = ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
    wget
  ];

  system.stateVersion = "26.05";
}
