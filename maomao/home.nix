{ pkgs, config, ... }:
{
  home.username = "curstantine";
  home.homeDirectory = "/home/curstantine";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    vial
    qbittorrent
    gimp
    picard
    btop-cuda
    vlc
    # (cutter.withPlugins (
    #   ps: with ps; [
    #     jsdec
    #     rz-ghidra
    #   ]
    # ))
  ];

  programs.git = {
    enable = true;
    settings.user.name = "Curstantine";
    settings.user.email = "Curstantine@proton.me";
    signing.key = "1AE8C302FD63ED84";
    signing.signByDefault = true;
  };

  # programs.chromium.enable = true;
  # programs.chromium.package = pkgs.vivaldi;
  programs.firefox.enable = true;
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox"; # 26.05 migration

  programs.vesktop.enable = true;
  programs.obs-studio.enable = true;

  programs.vscode.enable = true;

  services.kdeconnect.enable = true;

  imports = [
    ../modules/fonts.nix
    ../modules/lucidglyph.nix
    ../modules/fish.nix
    ../modules/ghostty.nix
    ../modules/gpg.nix
    ../modules/helium.nix
    ../modules/helix.nix
    ../modules/zed.nix
    ../modules/jetbrains.nix
    ../modules/android.nix
    ../modules/vicinae.nix
    ../modules/devshell.nix
    ../modules/ollama.nix
    ../modules/fooyin/fooyin.nix
    ../modules/games.nix
    ../modules/blender.nix
  ];
}
