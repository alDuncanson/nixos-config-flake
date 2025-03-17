{ pkgs, ... }:
{
  home = {
    username = "al";
    homeDirectory = "/home/al";
    stateVersion = "24.05";

    packages = with pkgs; [
      htop
      eza
      fd
      git
      wget
      hyperfine
      lua
      go
      fh
      slides
      gotop
      fastfetch
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    file = {
      ".config/ghostty/config".source = ./configs/ghostty/config;
    };

    shell = {
      enableZshIntegration = true;
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin Macchiato";
      };
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      config = {
        global.hide_env_diff = true;
      };
    };
    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
      shellAliases = {
        find = "fd";
        cat = "bat";
        ls = "eza --icons=always";
        lsl = "ls -l";
        lsls = "lsl --total-size";
        bench = "hyperfine";
      };
      prezto = {
        enable = true;
        prompt.theme = "agnoster";
      };
    };
    git = {
      enable = true;
      userName = "alDuncanson";
      userEmail = "alDuncanson@proton.me";
    };
    zellij = {
      enable = true;
      settings = {
        theme = "catppuccin-macchiato";
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
        default_shell = "zsh";
      };
    };
  };
}
