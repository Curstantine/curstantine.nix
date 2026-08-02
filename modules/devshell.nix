{ pkgs, ... }:
let
  templateDir = toString ../templates/devshell;
in
{
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = [
    (pkgs.writeShellApplication {
      name = "devshell";
      runtimeInputs = with pkgs; [
        coreutils
        findutils
      ];
      text = ''
        TEMPLATE_DIR="${templateDir}"

        usage() {
          echo "Usage: devshell -l <language> <path>"
          echo ""
          echo "Available languages:"
          find "$TEMPLATE_DIR" -maxdepth 1 -name '*.nix' -printf '%f\n' 2>/dev/null | while read -r f; do
            echo "  ''${f%.nix}"
          done
          exit 1
        }

        while getopts "l:" opt; do
          case $opt in
            l) LANG="$OPTARG" ;;
            *) usage ;;
          esac
        done

        shift $((OPTIND - 1))

        if [ -z "''${LANG:-}" ]; then
          usage
        fi

        TARGET="$(realpath -m "''${1:-.}")"
        TEMPLATE="$TEMPLATE_DIR/''${LANG:-}.nix"

        if [ ! -f "$TEMPLATE" ]; then
          echo "Error: template '$LANG' not found at $TEMPLATE"
          echo ""
          echo "Available languages:"
          find "$TEMPLATE_DIR" -maxdepth 1 -name '*.nix' -printf '%f\n' 2>/dev/null | while read -r f; do
            echo "  ''${f%.nix}"
          done
          exit 1
        fi

        mkdir -p "$TARGET"
        cp "$TEMPLATE" "$TARGET/flake.nix" --no-preserve all
        echo "use flake" > "$TARGET/.envrc"

        echo "Created devshell at $TARGET"
        echo "  flake.nix <- $LANG template"
        echo "  .envrc    <- use flake"
      '';
    })
  ];

}
