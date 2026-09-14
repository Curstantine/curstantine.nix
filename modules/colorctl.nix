{ inputs, ... }:
{
  imports = [ inputs.colorctl.nixosModules.default ];

  nixpkgs.overlays = [
    inputs.colorctl.overlays.default
  ];

  services.colorctl = {
    enable = true;

    fan = {
      enable = true;
      header = "all";
      profile = "quiet";
    };

    rgb = {
      enable = true;
      channel = "all";
      color = "#edc2d3";
      brightness = 5;
    };
  };
}
