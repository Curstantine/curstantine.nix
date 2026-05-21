{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains-mono
    ibm-plex
    roboto
    rubik
    noto-fonts-cjk-sans
  ];
}
