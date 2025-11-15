{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains-mono
    ibm-plex
    roboto
  ];
}
