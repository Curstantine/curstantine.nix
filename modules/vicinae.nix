{ ... }:
{
  programs.vicinae.enable = true;
  programs.vicinae.systemd.enable = true;

  programs.vicinae.settings = {
    launcher_window.opacity = 0.9;
    launcher_window.material = "blurred";
  };
}
