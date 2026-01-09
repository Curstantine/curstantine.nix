{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    fish
    grc
    fzf
  ];
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      sys-update = "nix flake update --flake ~/Code/Personal/curstantine.nix";
      sys-switch = "doas nixos-rebuild switch --flake ~/Code/Personal/curstantine.nix";
    };
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }
    ];

    completions = {
      cdcd = ''
        complete -c cdcd -f
        complete -c cdcd -n "__fish_is_first_token" -a "(ls -1 ~/Code/ 2>/dev/null | grep -E '^[^.]*\$')"
        complete -c cdcd -n "test (count (commandline -opc)) -eq 2" -a "(ls -1 ~/Code/(commandline -opc)[2]/ 2>/dev/null | grep -E '^[^.]*\$')"
      '';
    };

    functions = {
      cdcd = {
        description = "Navigate to code loctations easily";
        argumentNames = "base_directory project_name";
        body = ''
          if test (count $argv) -ne 2
              echo "Usage: set_code_location <base_directory> <project_name>"
              return 1
          end

          set -l rel_path (string join "/" $base_directory $project_name)
          set -l target_path (string join "/" $HOME "Code" $rel_path)

          if test -d $target_path
              cd $target_path
              return 0
          end

          read -P "Directory '$rel_path' not found under '~/Code/'. Do you want to clone it from Git? (Y/No/new): " response

          if string match -qi "no" $response
              echo "Aborted. Directory not cloned from Git."
              return 0
          end

          if string match -qi "new" $response
              set -l base_dir_path (path dirname $target_path)
              if not test -d $base_dir_path
                  mkdir -p $base_dir_path
              end

              mkdir -p $target_path
              echo "New directory '$target_path' created."

              cd $target_path
              return 0
          end

          if not string match -qi "y*" $response
              echo "Invalid response. Operation canceled."
              return 2
          end

          set -l base_dir_path (path dirname $target_path)
          if not test -d $base_dir_path
              mkdir -p $base_dir_path
          end

          cd $base_dir_path

          read -P "Enter the Git URL/SSH: " git_input
          if string match -q "@github:*" $git_input
              set git_input (string replace "@github:" "git@github.com:" $git_input)
          end

          git clone $git_input $project_name
          cd $target_path
        '';
      };

      clear_stale_branches = ''
        git fetch --prune
        for branch in (git branch -vv | grep 'gone]' | awk '{print $1}')
            git branch -D $branch
        end
      '';

      fish_prompt = ''
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
        set -l normal (set_color normal)
        set -q fish_color_status
        or set -g fish_color_status red

        # Color the prompt differently when we're root
        set -l color_cwd $fish_color_cwd
        set -l suffix '>'
        if functions -q fish_is_root_user; and fish_is_root_user
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            end
        set suffix '#'
        end

        # Write pipestatus
        # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
        set -l bold_flag --bold
        set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
        if test $__fish_prompt_status_generation = $status_generation
            set bold_flag
        end

        set __fish_prompt_status_generation $status_generation
        set -l status_color (set_color $fish_color_status)
        set -l statusb_color (set_color $bold_flag $fish_color_status)
        set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

        set -g fish_prompt_pwd_full_dirs 4
        set -g fish_prompt_pwd_dir_length 1

        echo -n -s (prompt_login)' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status $suffix " "
      '';
    };
  };
}
