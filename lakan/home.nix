{ pkgs, lib, ... }:
{
  home.username = "curstantine";
  home.homeDirectory = "/home/curstantine";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    settings.user.name = "Curstantine";
    settings.user.email = "Curstantine@proton.me";
  };

  # maomao uses pinentry-qt, which needs a display. lakan is headless.
  services.gpg-agent.pinentry.package = lib.mkForce pkgs.pinentry-curses;

  imports = [
    ../modules/fish.nix
    ../modules/helix.nix
    ../modules/devshell.nix
    ../modules/gpg.nix
  ];
}
