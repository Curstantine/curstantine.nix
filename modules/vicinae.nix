{ ... }:
{
  programs.vicinae.enable = true;
  programs.vicinae.systemd.enable = true;

  programs.vicinae.settings = {
    launcher_window.opacity = 1;
    launcher_window.blur.enabled = false;
  };
}
