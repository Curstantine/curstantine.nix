{ inputs, ... }: {
  imports = [ inputs.melody.homeModules.default ];
  programs.melody.enable = true;
}
