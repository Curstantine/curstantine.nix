{ config, pkgs, ... }:
{
  home.username = "curstantine";
  home.homeDirectory = "/home/curstantine";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    vesktop
    chromium
    grc
    vial
    qbittorrent
    bottles
    gimp
    picard
  ];

  programs.git = {
    enable = true;
    settings.user.name = "Curstantine";
    settings.user.email = "Curstantine@proton.me";
    signing.key = "1AE8C302FD63ED84";
    signing.signByDefault = true;
  };

  # Only enable chromium profiles
  programs.chromium.enable = true;
  programs.firefox.enable = true;

  programs.obs-studio.enable = true;

  programs.zed-editor.enable = true;
  programs.vscode.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  imports = [
    ../modules/fonts.nix
    ../modules/fish.nix
    ../modules/gpg.nix
    ../modules/helix.nix
    ../modules/jetbrains.nix
    ../modules/android.nix
    #    ../modules/fooyin/fooyin.nix
  ];
}
