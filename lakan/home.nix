{ ... }:
{
  home.username = "curstantine";
  home.homeDirectory = "/home/curstantine";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    settings.user = {
      name = "Curstantine";
      email = "Curstantine@proton.me";
    };
  };

  imports = [
    ../modules/fish.nix
    ../modules/helix.nix
    ../modules/devshell.nix
  ];
}
