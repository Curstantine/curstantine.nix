{ pkgs, ... }:
{
  home.packages = with pkgs; [
    osu-lazer-bin
    faugus-launcher
  ];

  programs.mangohud = {
    enable = true;
    settingsPerApplication = {
      "wine-ACU" = {
        full = true;
      };
    };
  };
}
