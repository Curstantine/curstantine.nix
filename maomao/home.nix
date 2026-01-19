{ pkgs, ... }:
{
  home.username = "curstantine";
  home.homeDirectory = "/home/curstantine";
  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    vial
    qbittorrent
    gimp
    picard
    btop-rocm
    (bottles.override { removeWarningPopup = true; })
  ];

  programs.git = {
    enable = true;
    settings.user.name = "Curstantine";
    settings.user.email = "Curstantine@proton.me";
    signing.key = "1AE8C302FD63ED84";
    signing.signByDefault = true;
  };

  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "Sonokai";
      font-size = 11;
    };
  };

  # programs.chromium.enable = true;
  # programs.chromium.package = pkgs.vivaldi;
  programs.firefox.enable = true;

  programs.vesktop.enable = true;
  programs.obs-studio.enable = true;

  programs.zed-editor.enable = true;
  programs.vscode.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  imports = [
    ../modules/fonts.nix
    ../modules/fish.nix
    ../modules/gpg.nix
    ../modules/helium.nix
    ../modules/helix.nix
    ../modules/jetbrains.nix
    ../modules/android.nix
    ../modules/vicinae.nix
    ../modules/fooyin/fooyin.nix
  ];
}
