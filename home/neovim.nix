{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = true;
          trouble.enable = true;
          #lspSignature.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };
        languages = {
          nix.enable = true;
          enableFormat = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
        };
        lazy.enable = true;
        visuals.indent-blankline.enable = true;

        luaConfigRC.colorscheme =
          /*
          lua
          */
          ''
            vim.g.terminal_emulator='kitty'
          '';
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };
        treesitter.enable = true;
        utility = {
          yanky-nvim.enable = false;
        };
        notes = {
          todo-comments.enable = true;
        };
        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "120";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };
        telescope.enable = true;
        statusline.lualine.enable = true;
        autocomplete = {
          #nvim-cmp.enable = true;
          blink-cmp.enable = true;
        };
        presence = {
          neocord.enable = true;
        };
        #lazy.plugins = {
        #};
      };
    };
  };
}
