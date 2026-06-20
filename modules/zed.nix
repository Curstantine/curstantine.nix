{ ... }:
{
  programs.zed-editor.enable = true;
  programs.zed-editor.userSettings = {
    tab_size = 4;
    ui_font_size = 14;
    buffer_font_size = 14;
    buffer_font_family = "JetBrains Mono";
    buffer_line_height = "comfortable";

    terminal.font_size = 14;
    terminal.font_family = "JetBrains Mono";
    terminal.line_height = "comfortable";

    agent = {
      dock = "right";
      sidebar_side = "right";
      play_sound_when_agent_done = "when_hidden";
    };

    edit_predictions = {
      provider = "zed";
      mode = "subtle";
    };

    project_panel.dock = "left";
    outline_panel.dock = "left";
    collaboration_panel.dock = "left";
    git_panel.dock = "left";

    diff_view_style = "split";
    cli_default_open_behavior = "new_window";

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

    languages = {
      Nix.language_servers = [
        "nixd"
        "!nil"
      ];
    };
    lsp = {
      dart.settings.enableSdkFormatter = false;
      biome.settings.require_config_file = true;
      vtsls.settings.typescript.preferences.importModuleSpecifier = "non-relative";
    };
  };
}
