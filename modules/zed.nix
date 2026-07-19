{ ... }:
{
  programs.zed-editor.enable = true;
  programs.zed-editor.extensions = [
    "toml"
    "html"
    "dockerfile"
    "sql"
    "vue"
    "svelte"
    "dart"
    "astro"
    "nix"
    "oxc"
    "symbols"
    "glsl"
    "mcp-server-figma"
    "xcode-themes"
  ];
  programs.zed-editor.userSettings = {
    tab_size = 4;
    ui_font_size = 14;
    buffer_font_size = 14;
    buffer_font_family = "JetBrains Mono";
    buffer_line_height = "comfortable";

    terminal.font_size = 14;
    terminal.font_family = "JetBrains Mono";
    terminal.line_height = "comfortable";

    language_models = {
      ollama.context_window = 128000;
    };

    edit_predictions = {
      provider = "zed";
      mode = "subtle";
    };

    agent = {
      dock = "right";
      sidebar_side = "right";
      play_sound_when_agent_done = "when_hidden";

      inline_assistant_model = {
        provider = "deepseek";
        model = "deepseek-v4-flash";
        effort = "high";
      };

      commit_message_model = {
        provider = "deepseek";
        model = "deepseek-v4-flash";
        effort = "high";
        enable_thinking = false;
      };
      commit_message_instructions = "**Write a concise, descriptive commit message using feat:/chore:/fix:/docs:/style:/refactor:/perf:/test: prefixes. For monorepos, scope the module like feat(web):; if multiple modules are touched, omit the scope. Keep the first line under 75 chars, then a blank line, then a brief body explaining changes and any caveats.**";
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
