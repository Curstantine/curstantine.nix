{ inputs, pkgs, ... }:
{
  imports = [ inputs.helium.homeModules.default ];
  programs.helium = {
    enable = true;
    flags = [
      "--disable-features=WaylandWpColorManagerV1"
    ];
  };
}
