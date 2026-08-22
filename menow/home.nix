{ ... }:
{
  home.username = "alice";
  home.homeDirectory = "/home/alice";
  # home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    settings.user = {
      name = "Curstantine";
      email = "Curstantine@proton.me";
    };
  };
}
