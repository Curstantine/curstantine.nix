{ pkgs, ... }:

let
  lucidglyph = pkgs.fetchFromGitHub {
    owner = "maximilionus";
    repo = "lucidglyph";
    rev = "master";
    hash = "sha256-PyiVH0CRYLeiyQ/Ue3RehBmNqOBHrbUa0T7bUfj+nMU=";
  };

  fontconfigDir = "${lucidglyph}/src/modules/fontconfig";
in
{
  fonts.fontconfig.enable = true;

  home.sessionVariables = {
    FREETYPE_PROPERTIES = "autofitter:no-stem-darkening=0 autofitter:darkening-parameters=500,500,1000,500,2500,500,4000,0 cff:no-stem-darkening=0 type1:no-stem-darkening=0 t1cid:no-stem-darkening=0";
    QT_NO_SYNTHESIZED_BOLD = "1";
  };

  xdg.configFile = {
    "fontconfig/conf.d/11-lucidglyph-grayscale.conf".source =
      "${fontconfigDir}/11-lucidglyph-grayscale.conf";

    "fontconfig/conf.d/11-lucidglyph-hinting-slight.conf".source =
      "${fontconfigDir}/11-lucidglyph-hinting-slight.conf";

    "fontconfig/conf.d/20-lucidglyph-embolden.conf".source =
      "${fontconfigDir}/20-lucidglyph-embolden.conf";

    "fontconfig/conf.d/21-lucidglyph-icon-fonts.conf".source =
      "${fontconfigDir}/21-lucidglyph-icon-fonts.conf";

    "fontconfig/conf.d/70-lucidglyph-droid-sans.conf".source =
      "${fontconfigDir}/70-lucidglyph-droid-sans.conf";
  };
}
