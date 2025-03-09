{ config, lib, pkgs, osConfig, isLiveCD, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  #test later systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    #nvidiaPatches = true;
    extraConfig = ''
    # Docu
    # See https://wiki.hyprland.org/Configuring/ for options used in this file!

    # Monitor
    monitor=,preferred,auto,1
    monitor=DP-5,1920x2160@59,0x0,1
    monitor=DP-4,1920x2160@59,1920x0,1

    # Fix slow startup
    #exec-once ${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    #exec-once dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # Autostart
    exec-once = hyprctl setcursor Bibata-Modern-Classic 24
    exec-once = dunst
    exec-once = nm-app
    exec-once = blueman-applet
    exec-once = hyprpaper
    source = ~/.config/hypr/colors
    exec-once = pkill waybar & sleep 0.5 && waybar
    exec-once = ${pkgs.wlsunset}/bin/wlsunset -l 47.0 -L 15.4
    exec-once = hyprctl plugin load /run/current-system/sw/lib/libhyprgrass.so

    # Input config
    input {
        kb_layout = ${osConfig.services.xserver.xkb.layout}
        # kb_variant = ${osConfig.services.xserver.xkb.variant} # this seems to be broken, at least for my current setup (german variants cannot be found), but for some reason it works currectly without specifying a variant, contrary to the console config
        touchpad {
            natural_scroll = false
        }
    }

    # hyprgrass touchscreen
    plugin {
      gestures {
        workspace_swipe = false
      }
      touch_gestures {
        # swipe 1 finger right from left edge
        hyprgrass-bind = , edge:l:r, killactive

        # swipe 1 finger up from bottom edge
        hyprgrass-bind = , edge:d:u, fullscreenstate, 1

        # swipe 2 fingers left
        hyprgrass-bind = , swipe:2:l, cyclenext

        # swipe 3 fingers right
        hyprgrass-bind = , swipe:2:r, cyclenext, prev
      }
    }

    general {

        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {

        rounding = 0
    }

    animations {
        enabled = yes

        bezier = ease,0.4,0.02,0.21,1

        animation = windows, 1, 3.5, ease, slide
        animation = windowsOut, 1, 3.5, ease, slide
        animation = border, 1, 6, default
        animation = fade, 1, 3, ease
        animation = workspaces, 1, 3.5, ease
    }

    dwindle {
        pseudotile = yes
        preserve_split = yes
    }

    #master {
    #    new_is_master = yes
    #}



    # window rules
    windowrulev2 = opacity 0.9 0.9,class:^(kitty)$
    windowrulev2 = float,class:^(pavucontrol)$
    windowrulev2 = float,class:^(blueman-manager)$
    windowrulev2 = size 934 525,class:^(mpv)$
    windowrulev2 = float,class:^(mpv)$
    windowrulev2 = center,class:^(mpv)$

    # keybindings
    $mainMod = SUPER
    bind = $mainMod, plus, fullscreen, 0
    bind = $mainMod_Alt_L, plus, fullscreenstate, 1
    bind = $mainMod, B, exec, killall -SIGUSR1 -r waybar
    bind = $mainMod, minus, movetoworkspacesilent, 10

    #bind = $mainMod, RETURN, exec, cool-retro-term-zsh
    bind = $mainMod, RETURN, exec, kitty
    bind = , F4, killactive,
    bind = ALT_L, F4, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, F, togglefloating,
    bindr= $mainMod, SUPER_L, exec, rofi -show drun || pkill rofi
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, P, pseudo, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle

    # Switch Keyboard Layouts
    bind = $mainMod, SPACE, exec, hyprctl switchxkblayout teclado-gamer-husky-blizzard next

    bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
    bind = SHIFT, Print, exec, grim -g "$(slurp)"

    # Functional keybinds
    bind =,XF86AudioMicMute,exec,pamixer --default-source -t
    bind =,XF86MonBrightnessDown,exec,light -U 20
    bind =,XF86MonBrightnessUp,exec,light -A 20
    bind =,XF86AudioMute,exec,pamixer -t
    bind =,XF86AudioLowerVolume,exec,pamixer -d 10
    bind =,XF86AudioRaiseVolume,exec,pamixer -i 10
    bind =,XF86AudioPlay,exec,playerctl play-pause
    bind =,XF86AudioPause,exec,playerctl play-pause
    bind =,XF86AudioPause,exec,playerctl play-pause
    bind =,XF86AudioNext,exec,playerctl next
    bind =,XF86AudioPrev,exec,playerctl previous
    bind =,XF86Close,exec,killactive

    # to switch between windows in a floating workspace
    bind = SUPER,Tab,cyclenext,
    bind = SUPER,Tab,bringactivetotop,

    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Move windows with mainMod + Alt_L + arrow keys
    bind = $mainMod_Alt_L, left, movewindow, l
    bind = $mainMod_Alt_L, right, movewindow, r
    bind = $mainMod_Alt_L, up, movewindow, u
    bind = $mainMod_Alt_L, down, movewindow, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move window to other monitor
    bind = $mainMod_SHIFT, left, movewindow, mon:1
    bind = $mainMod_SHIFT, right, movewindow, mon:0

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bindm = ALT, mouse:272, resizewindow

    # Resize windows via keyboard
    bind = $mainMod_CTRL_L, left, resizeActive, -5% 0%
    bind = $mainMod_CTRL_L, right, resizeActive, 5% 0%
    bind = $mainMod_CTRL_L, up, resizeActive, 0% -5%
    bind = $mainMod_CTRL_L, down, resizeActive, 0% 5%
    bind = $mainMod_CTRL_L, plus, togglefloating

    # span window over two "monitors" - virtual desktops missing feature workaround
    bind = $mainMod_CTRL_L, plus, resizeActive, exact 3840 2160
    # if you max here (e.g. press f while a youtube video playing, this spans over both screens now)
    #bind = $mainMod_CTRL_L, plus, fullscreenstate, 1
    bind = $mainMod_CTRL_L, plus, moveactive, exact 0 0
    bind = $mainMod_CTRL_L, plus, exec, killall -SIGUSR1 -r waybar
        '' + (lib.optionalString isLiveCD ''
exec-once = sudo -E calamares
exec-once = hyprland-keyboard-sync
'');
  };

      home.file.".config/hypr/colors".text = ''
$background = rgba(1d192bee)
$foreground = rgba(c3dde7ee)

$color0 = rgba(1d192bee)
$color1 = rgba(465EA7ee)
$color2 = rgba(5A89B6ee)
$color3 = rgba(6296CAee)
$color4 = rgba(73B3D4ee)
$color5 = rgba(7BC7DDee)
$color6 = rgba(9CB4E3ee)
$color7 = rgba(c3dde7ee)
$color8 = rgba(889aa1ee)
$color9 = rgba(465EA7ee)
$color10 = rgba(5A89B6ee)
$color11 = rgba(6296CAee)
$color12 = rgba(73B3D4ee)
$color13 = rgba(7BC7DDee)
$color14 = rgba(9CB4E3ee)
$color15 = rgba(c3dde7ee)
    '';
}

