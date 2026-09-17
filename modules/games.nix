{ pkgs, ... }:
{
  home.packages = with pkgs; [
    osu-lazer-bin
    faugus-launcher
  ];

  programs.mangohud = {
    enable = true;
    settings = {
      position = "bottom-left";
      table_columns = 4;

      font_size = 12;
      no_small_font = true;
      background_alpha = 0.4;
      round_corners = 0;

      text_outline = true;
      text_outline_thickness = 1.0;

      cpu_stats = true;
      cpu_temp = true;
      cpu_power = false;
      ram = false;

      gpu_stats = true;
      gpu_temp = true;
      gpu_power = true;
      vram = true;
      pci_dev = "0000:01:00.0";

      fps = true;
      engine_version = false;
      fps_metrics = "0.01";
      frame_timing = false;
      frametime = false;
      fps_sampling_period = 500;

      toggle_hud = "Shift_R";
    };
  };
}
