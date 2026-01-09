{ config, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "base16_default_dark";
    };
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "tsx";
          auto-format = true;
          formatter = {
            command = "prettier";
          };
          language-servers = [
            "tailwindcss"
            "tailwindcss-ls"
          ];
        }
        {
          name = "css";
          auto-format = true;
          formatter = {
            command = "prettier";
          };
          language-servers = [
            "vscode-css-language-server"
            "tailwindcss-ls"
          ];
        }
      ];
    };
  };
}
