{
  bifrost,
  pkgs,
  lib,
  ...
}: let
  monitor = bifrost.monitors.default;
  position = bifrost.monitors.inbuilt.position;
in {
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 3;
      gaps_out = 5;
      gaps_workspaces = 50;
      border_size = 0;
      layout = "dwindle";
      resize_on_border = true;
      # "col.active_border" = lib.mkForce "rgba(4f4256CC)";
      # "col.inactive_border" = lib.mkForce "rgba(4f4256CC)";
    };

    monitor = [
      ",preferred,auto,1"
      "eDP-1, 1920x1080@60.00, ${position.x}x${position.y}, 1"
      "HDMI-A-2, 1920x1080@60.00, 0x0, 1"
    ];

    workspace = [
      "1, monitor:${monitor}"
      "2, monitor:${monitor}"
      "3, monitor:${monitor}"
      "4, monitor:${monitor}"
      "5, monitor:${monitor}"
      "6, monitor:eDP-1"
      "7, monitor:eDP-1"
    ];

    decoration = {
      rounding = 2;

      blur = {
        enabled = false;
        xray = false;
        special = false;
        new_optimizations = true;
        popups = true;
        size = 0;
        passes = 4;
        brightness = 1;
        noise = 1.0e-2;
        contrast = 1;
      };

      # Dim
      dim_inactive = false;
      dim_strength = 0.1;
      dim_special = 0;
    };

    exec-once = [
      # "uwsm app -- ags run &"
      "uwsm app -- swaync &"
      "uwsm app -- waybar &"
      "uwsm app -- nm-applet &"
      "uwsm app -- wl-paste --type text --watch cliphist store &"
      "uwsm app -- wl-paste --type image --watch cliphist store &"
      "uwsm app -- discord &"
      "uwsm app -- swww-daemon --format xrgb"
      "uwsm app -- ${pkgs.powermode-indicator}/bin/powermode-indicator"
      # "hyprctl setcursor Bibata-Modern-Classic 24"
    ];

    env = [
      "DESKTOP_SESSION,hyprland"
      "OZONE_PLATFORM,wayland"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"

      # "QT_QPA_PLATFORM, wayland"
      # "QT_QPA_PLATFORM=xcb genymotion"
      # "QT_QPA_PLATFORMTHEME, fcitx"
      #"QT_STYLE_OVERRIDE,kvantum"
      "WLR_NO_HARDWARE_CURSORS, 1"

      # Mozilla
      "MOZ_DISABLE_RDD_SANDBOX,1"
      "MOZ_ENABLE_WAYLAND,1"

      # MOUSE CURSOR
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,24"
    ];

    animations = {
      enabled = true;
      # bezier = [
      #   "myBezier, 0.05, 0.9, 0.1, 1.05"
      # ];
      # animation = [
      #   "windows, 1, 7, myBezier"
      #   "windowsIn, 1, 7, myBezier, slide"
      #   "windowsOut, 1, 7, default, slide"
      #   "border, 1, 10, default"
      #   "borderangle, 1, 8, default"
      #   "fade, 1, 7, default"
      #   "workspaces, 1, 6, default, slidefade 20%"
      # ];

      bezier = [
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazyshot, 0.1, 1.5, 0.76, 0.92"
        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
        "fluent_decel, 0.1, 1, 0, 1"
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
      ];
      animation = [
        "windows, 1, 3, md3_decel, popin 60%"
        "border, 1, 10, default"
        "fade, 1, 2.5, md3_decel"
        # "workspaces, 1, 3.5, md3_decel, slide"
        "workspaces, 1, 7, fluent_decel, slide"
        # "workspaces, 1, 7, fluent_decel, slidefade 15%"
        # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
        "specialWorkspace, 1, 3, md3_decel, slidevert"
      ];
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_resizing = false;
    };

    input = {
      kb_layout = "us";
      numlock_by_default = true;
      repeat_delay = 250;
      repeat_rate = 35;

      accel_profile = "flat"; # required for hints

      touchpad = {
        natural_scroll = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        scroll_factor = 0.5;
      };

      follow_mouse = 1;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_distance = 700;
      workspace_swipe_fingers = 4;
      workspace_swipe_cancel_ratio = 0.2;
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_direction_lock = true;
      workspace_swipe_direction_lock_threshold = 10;
      workspace_swipe_create_new = true;
    };

    cursor = {
      no_hardware_cursors = true;
    };

    device = {
      name = "ydotoold-virtual-device-1";
      accel_profile = "flat";
    };

    windowrule = [
      "workspace 6, class:^(spotify)$"
      "workspace 7, class:^(discord)$"

      "float, title:^(steam)$"
      "float, title:polkit-gnome-authentication-agent-1"
      "size 300 300, title:polkit-gnome-authentication-agent-1"
      "float, title:Genymotion Player"
      "float, title:Volume Control"
      "float, title:^(Smile)$"
      "float, class:^(blueberry.py)$"
      "pin, title:^(showmethekey-gtk)$"
      "float,title:^(Open File)(.*)$"
      "float,title:^(Select a File)(.*)$"
      "float,title:^(Choose wallpaper)(.*)$"
      "float,title:^(Open Folder)(.*)$"
      "float,title:^(Save As)(.*)$"
      "float,title:^(Library)(.*)$ "
    ];

    windowrulev2 = [
      # "opacity 0.93 0.93, class:^(.*)$"
      "opacity 1.0 1.0, class:^(blender)$"
      "opacity 1.0 1.0, class:^(org.kde.kdenlive)$"
      "opacity 1.0 1.0, class:^(mpv)$"
      "opacity 1.0 1.0, class:^(vlc)$"
      "opacity 1.0 1.0, class:^(eog)$"
      "opacity 1.0 1.0, class:^(org.pwmt.zathura)$"
      "opacity 1.0 1.0, class:^(libreoffice.*)$"
      "opacity 1.0 1.0,class:^(zen-twilight)$,title:.*[Yy]ou[Tt]ube.*"
      "opacity 1.0 1.0,class:^(chrome-youtube\\.com__-Default)$,title:.*[Yy]ou[Tt]ube.*"
      "opacity 1.0 1.0,class:^(chrome-tradingview\\.com__-Default)$,title:.*[Yy]ou[Tt]ube.*"
    ];

    layerrule = [
      "xray 1, .*"
      "blur, swaylock"
      "ignorealpha 1, gtk-layer-shell"
    ];

    debug = {
      disable_logs = false;
      # overlay = true;
      # damage_tracking = 0;
      # damage_blink = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      new_window_takes_over_fullscreen = 2;

      # window swallowing
      enable_swallow = true; # hide windows that spawn other windows
      swallow_regex = "wezterm|foot|cosmic-files|thunar|nemo";

      # dpms
      mouse_move_enables_dpms = true; # enable dpms on mouse/touchpad action
      key_press_enables_dpms = true; # enable dpms on keyboard action
      disable_autoreload = true; # autoreload is unnecessary on nixos, because the config is readonly anyway
    };
  };
}
