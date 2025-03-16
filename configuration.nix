{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Detroit";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.al = {
    isNormalUser = true;
    description = "Al Duncanson";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    ghostty
  ];

  system.stateVersion = "24.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        filetree.nvimTree = {
          enable = true;
        };
        keymaps = [
          {
            mode = "n";
            key = "<leader>wh";
            action = "<C-w>h";
          }
          {
            mode = "n";
            key = "<leader>wj";
            action = "<C-w>j";
          }
          {
            mode = "n";
            key = "<leader>wk";
            action = "<C-w>k";
          }
          {
            mode = "n";
            key = "<leader>wl";
            action = "<C-w>l";
          }
        ];
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;
          bash = {
            enable = true;
          };
          css = {
            enable = true;
          };
          dart = {
            enable = true;
            flutter-tools.enable = true;
          };
          gleam = {
            enable = true;
          };
          go = {
            enable = true;
          };
          html = {
            enable = true;
          };
          kotlin = {
            enable = true;
          };
          lua = {
            enable = true;
          };
          markdown = {
            enable = true;
          };
          nix = {
            enable = true;
            format = {
              type = "nixfmt";
            };
            lsp = {
              server = "nixd";
            };
          };
          python = {
            enable = true;
          };
          ruby = {
            enable = true;
          };
          rust = {
            enable = true;
          };
          tailwind = {
            enable = true;
          };
          ts = {
            enable = true;
            format.type = "biome";
          };
          yaml = {
            enable = true;
          };
          zig = {
            enable = true;
          };
        };
        lsp = {
          formatOnSave = true;
        };
        options = {
          tabstop = 4;
          shiftwidth = 4;
        };
        theme = {
          enable = true;
          name = "catppuccin";
          style = "macchiato";
          transparent = true;
        };
        ui = {
          breadcrumbs.enable = true;
          noice.enable = true;
        };
        utility = {
          motion.leap.enable = true;
          yanky-nvim.enable = true;
        };
        visuals = {
          cinnamon-nvim = {
            enable = true;
            setupOpts.keymaps = {
              basic = true;
              extra = true;
            };
          };
          fidget-nvim = {
            enable = true;
          };
        };

        useSystemClipboard = true;
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        binds.whichKey = {
          enable = true;
        };
        terminal.toggleterm = {
          enable = true;
          lazygit.enable = true;
        };
      };
    };
  };
}
