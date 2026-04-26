{ pkgs, ... }:
{
  programs.zed-editor.enable = true;
  programs.zed-editor.userSettings = {
    tab_size = 4;
    ui_font_size = 13;
    buffer_font_size = 13;
    buffer_font_family = "JetBrains Mono";
    buffer_line_height = "comfortable";

    agent.play_sound_when_agent_done = "when_hidden";
    edit_predictions = {
      provider = "zed";
      mode = "subtle";
    };

    icon_theme = {
      mode = "dark";
      light = "Symbols Icon Theme";
      dark = "Symbols Icon Theme";
    };
    theme = {
      mode = "dark";
      light = "Xcode Default Light";
      dark = "Xcode Default Darker";
    };

    lsp = {
      biome.settings.require_config_file = true;
      vtsls.settings.typescript.preferences.importModuleSpecifier = "non-relative";
    };
  };
}
