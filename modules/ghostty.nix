{ ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "Xcode Dark";
      font-size = 11;
      font-family = "IBM Plex Mono";
      window-padding-y = 0;
      window-theme = "ghostty";
      gtk-wide-tabs = false;
      window-titlebar-background = "#292c30";
    };
  };
}
