{ pkgs, ... }:
{
  home.packages = with pkgs; [
    osu-lazer-bin
    faugus-launcher
  ];

  programs.mangohud = {
    enable = true;
    settingsPerApplication = {
      "wine-ACU" = {
        position = "bottom-left";
        table_columns = 4;

        font_size = 13;
        no_small_font = true;
        background_alpha = 0.4;
        round_corners = 0;

        cpu_stats = true;
        cpu_temp = true;
        cpu_power = true;
        ram = true;

        gpu_stats = true;
        gpu_temp = true;
        gpu_power = true;
        vram = true;
        pci_dev = "0000:01:00.0";

        frame_timing = false;

        fps_sampling_period = 500;
      };
    };
  };
}
