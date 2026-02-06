{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpaper
    mako
    rofi
    cliphist
    wl-clipboard-rs
  ];

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.systemd.enable = false;
  home.sessionVariables.NIXOS_OZONE_WL = "1"; # Making chromium/electron apps use wayland

  programs.ashell.enable = true;
  programs.hyprshot.enable = true;

  services.hyprpaper.enable = true;
  services.hypridle.enable = true;
  services.hyprpolkitagent.enable = true;

  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "ghostty";
    "$fileManager" = "dolphin";
    "$menu" = "vicinae toggle";

    monitorv2 = [
      {
        output = "DP-5";
        mode = "1920x1080@100";
        transform = 1;
      }
      {
        output = "DP-4";
        mode = "2560x1440@60";
        position = "1080x200";
        transform = 0;
      }
    ];

    # Autostart
    exec-once = [
      "uwsm app -- hyprpaper"
      "uwsm app -- mako"
      "uwsm app -- ashell"
      "uwsm app -- wl-paste --type text --watch cliphist store" # Stores only text data
      "uwsm app -- wl-paste --type image --watch cliphist store" # Stores only image data
    ];

    general = {
      gaps_in = 2;
      gaps_out = 4;
      border_size = 1;

      resize_on_border = false;
      allow_tearing = false;
      layout = "dwindle";
      snap.enabled = true;
    };

    decoration = {
      rounding = 0;
      shadow.enabled = true;
    };

    dwindle = {
      smart_resizing = true;
    };

    misc = {
      force_default_wallpaper = 1;
      disable_hyprland_logo = true;
      focus_on_activate = true;
    };

    input = {
      kb_layout = "us";
      kb_variant = "dvorak";

      follow_mouse = 1;
      accel_profile = "flat";
      sensitivity = 0;
    };

    layerrule = {
      name = "vicinae-blur";
      blur = "on";
      ignore_alpha = 0;
      match.namespace = "vicinae";
    };

    bind = [
      "$mainMod, Return, exec, uwsm app -- $terminal"
      "$mainMod, C, killactive"
      "$mainMod, E, exec, uwsm app -- $fileManager"
      "$mainMod, V, togglefloating"
      "$mainMod, R, exec, uwsm app -- $menu"

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Dwindle layout bindings
      "$mainMod, j, layoutmsg, togglesplit"

      # Special workspace
      "$mainMod, S, togglespecialworkspace, magic"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"

      # Scroll through existing workspaces with mainMod + scroll
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      # Move window with arrow keys
      "$mainMod SHIFT, left, movewindow, l"
      "$mainMod SHIFT, right, movewindow, r"

      # Switch to resize submap
      "ALT, R, submap, resize"

      # Vicinae clipboard history
      "$mainMod SHIFT, V, exec, vicinae vicinae://extensions/vicinae/clipboard/history"
    ]
    ++ (
      # workspaces
      # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mainMod, code:1${toString i}, workspace, ${toString ws}"
            "$mainMod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      )
    );

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };

  wayland.windowManager.hyprland.submaps.resize.settings = {
    binde = [
      ", right, resizeactive, 10 0"
      ", left, resizeactive, -10 0"
      ", up, resizeactive, 0 -10"
      ", down, resizeactive, 0 10"
    ];
    bind = [ ", escape, submap, reset" ];
  };
}
