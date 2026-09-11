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
    agent_servers.antigravity-acp = {
      type = "registry";
      default_config_options = {
        mode = "yolo";
        model = "gemini-3.8-flash-high";
      };
    };

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
      terminal_init_command = "";
      default_profile = "write";

      sandbox_permissions.allow_unsandboxed = true;

      tool_permissions.tools = {
        edit_file = {
          always_allow = [ { pattern = "./"; } ];
          always_deny = [ { pattern = "./**/(target|dist|node_modules)/**/*"; } ];
        };
        create_directory = {
          always_allow = [ { pattern = "./"; } ];
          always_deny = [ { pattern = "./**/(target|dist|node_modules)/**/*"; } ];
        };
        skill.default = "allow";
        search_web.default = "allow";
        fetch.default = "allow";
        write_file = {
          always_allow = [ { pattern = "./"; } ];
          always_deny = [ { pattern = "./**/(target|dist|node_modules)/**/*"; } ];
        };
        terminal.always_allow = [
          { pattern = "^pnpm\\s(run\\s)?(build|dev|test|lint|fmt)"; }
          { pattern = "^cargo\\s(build|test|check|clippy)"; }
          { pattern = "^grep\\b"; }
          { pattern = "^sed\\b"; }
          { pattern = "git.?(--no-pager)?\\sdiff"; }
          { pattern = "^ls node_modules/"; }
          { pattern = "^head\\b"; }
          { pattern = "^echo\\s+===(\\s|$)"; }
          { pattern = "^find\\s+node_modules/@tresjs/cientos(\\s|$)"; }
          { pattern = "^xargs\\s+grep(\\s|$)"; }
          { pattern = "^echo\\b"; }
          { pattern = "^find\\s+node_modules/@tresjs/cientos/dist(\\s|$)"; }
        ];
      };

      inline_assistant_model = {
        provider = "deepseek";
        model = "deepseek-v4-flash";
        effort = "high";
      };

      commit_message_model = {
        provider = "ollama";
        model = "lfm2.5-thinking";
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

    file_types.XML = [ "*.svg" ];

    lsp = {
      dart.settings.enableSdkFormatter = false;
      biome.settings.require_config_file = true;
      vtsls.settings.typescript.preferences.importModuleSpecifier = "non-relative";
    };
  };
}
