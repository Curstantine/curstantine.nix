{ ... }:
{
  nix.optimise = {
    automatic = true;
    dates = [ "00:00" ];
  };
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 4d";
  };
}
