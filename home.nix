{ pkgs, lib, ... }:
let
  lock = "${pkgs.swaylock}/bin/swaylock -f -c 000000";
  status = pkgs.writeShellScript "sway-status" ''
    while true; do
      battery=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1)
      echo "''${battery:+bat $battery% | }$(date +'%a %b %-d %H:%M')"
      sleep 30
    done
  '';
in
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = {
      modifier = "Mod4";
      terminal = "ghostty";
      menu = "wmenu-run";
      defaultWorkspace = "workspace number 1";
      input."type:touchpad".tap = "enabled";
      bars = [
        {
          position = "top";
          statusCommand = "${status}";
        }
      ];
      keybindings = lib.mkOptionDefault {
        "Mod4+Shift+x" = "exec ${lock}";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
        "Print" = "exec grim -g \"$(slurp)\" - | wl-copy";
      };
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg 'output * power off'";
        resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * power on'";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = lock;
      }
    ];
  };

  home = {
    username = "al";
    homeDirectory = "/home/al";
    stateVersion = "24.05";

    file.".config/ghostty/config".source = ./configs/ghostty/config;
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "alDuncanson";
      userEmail = "alDuncanson@proton.me";
    };
  };
}
