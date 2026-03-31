{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "Hybrid";
      font-size = 11;
      font-family = "IBM Plex Mono";
    };
  };
}
