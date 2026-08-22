{ pkgs, ... }:
{
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "141.11.100.152" = {
        SetEnv = ''TERM="xterm-256color"'';
        SendEnv = "COLORTERM TERM_PROGRAM TERM_PROGRAM_VERSION";
      };
    };
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableFishIntegration = true;
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    pinentry.package = pkgs.pinentry-qt;
  };
}
