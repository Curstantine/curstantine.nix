{ inputs, ... }:
{
  imports = [ inputs.colorctl.nixosModules.default ];

  services.colorctl = {
    enable = true;

    fan = {
      headers = "all";
      profile = "quiet";
    };

    rgb = {
      mode = "off";
      channels = "all";
      color = "#edc2d3";
      brightness = 5;
    };
  };
}
