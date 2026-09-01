{ pkgs, ... }:
{
  home.packages = with pkgs; [ fooyin ];

  xdg.configFile."fooyin/layouts/Vertical.fyl".source = ./layouts/Vertical.fyl;
  xdg.configFile."fooyin/layouts/Zen.fyl".source = ./layouts/Zen.fyl;
  xdg.configFile."fooyin/layouts/Horizontal.fyl".source = ./layouts/Horizontal.fyl;
}
