{ pkgs, config, lib, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    extraPlugins = [ pkgs.vimPlugins.fleet-theme-nvim ];
    colorscheme = "fleet";
    extraConfigVim = ''

      " Reselect selected space when pressing > <
      vnoremap < <gv
      vnoremap > >gv
      xnoremap < <gv
      xnoremap > >gv

      " Make Ctrl+Backspace delete a whole word
      nnoremap <C-BS> db
      inoremap <C-BS> <C-w>

      " Make Ctrl+Delete delete the word after the cursor
      nnoremap <C-Del> dw
      inoremap <C-Del> <C-o>dw

      " Make Ctrl+Left Arrow move cursor one word left
      nnoremap <C-Left> b
      inoremap <C-Left> <C-o>b

      " Make Ctrl+Right Arrow move cursor one word right
      nnoremap <C-Right> w
      inoremap <C-Right> <C-o>w

      set undofile                    " Enable persistent undo across sessions
      set undodir=~/.config/nvim/undo  " Directory to store undo history
      set undolevels=1000              " Number of undo levels to store
      set undoreload=10000             " Maximum number of lines to save for undo

    '';
    opts = {
      #number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
    };
    clipboard = {
      register = "unnamedplus";
      providers = {
        wl-copy = {
          enable = true;
          package = pkgs.wl-clipboard;
        };
      };
    };
    plugins = {
      #bufferline = {
      #  enable = true;
      #};

      nvim-colorizer = {
        enable = true;
      };

      lazygit = {
        enable = true;
      };

      lualine = {
        enable = true;
      };

      treesitter = {
        enable = true;
      };

      auto-save.enable = true;

      telescope.enable = true;

      oil = {
        enable = true;
      };

      toggleterm = {
        enable = true;
        settings = {
          hide_numbers = false;
          autochdir = true;
          close_on_exit = true;
          direction = "float";
          border = "curved";
        };
      };

      #lightline.enable = true;

      cmp-emoji = {
        enable = true;
      };

      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          experimental = { ghost_text = true; };
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };
          snippet = { expand = "luasnip"; };
          formatting = { fields = [ "kind" "abbr" "menu" ]; };
          sources = [
            { name = "nvim_lsp"; }
            { name = "emoji"; }
            {
              name = "buffer"; # text within current buffer
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            {
              name = "path"; # file system paths
              keywordLength = 3;
            }
            {
              name = "luasnip"; # snippets
              keywordLength = 3;
            }
          ];

          window = {
            completion = { border = "solid"; };
            documentation = { border = "solid"; };
          };

          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          };
        };
      };
      cmp-nvim-lsp = {
        enable = true; # LSP
      };
      cmp-buffer = {
        enable = true;
      };
      cmp-path = {
        enable = true; # file system paths
      };
      cmp_luasnip = {
        enable = true; # snippets
      };
      cmp-cmdline = {
        enable = true; # autocomplete for cmdline
      }; 

      todo-comments = {
        enable = true;
        settings = {
          colors = {
            error = ["DiagnosticError" "ErrorMsg" "#DC2626"];
            warning = ["DiagnosticWarn" "WarningMsg" "#FBBF24"];
            info = ["DiagnosticInfo" "#2563EB"];
            hint = ["DiagnosticHint" "#10B981"];
            default = ["Identifier" "#7C3AED"];
            test = ["Identifier" "#FF00FF"];
          };
        };
      };

      indent-blankline.enable = true;

      undotree.enable = true;

      lspkind = {
        enable = true;
        mode = "symbol_text";
      };

      fidget = {
        enable = true;
         notification = {
          window = {
            winblend = 0;
            relative = "editor";
          };
        };
      };

      lsp = {
        enable = true;

        servers = {
          ltex.settings.completionEnabled = true;
          lua-ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          rust-analyzer = {
            enable = true;
            installRustc = false;
            installCargo = false;
          };
          zls = {
            enable = true;
          };
          clangd = {
            enable = true;
          };
          slint-lsp = {
            enable = true;
            autostart = true;
          };
          tailwindcss = {
            enable = true;
          };
        };
      };
    };

    keymaps = [
      {
        key = "<C-/>";
        action = ":ToggleTerm<CR>";
        mode = ["n" "t"];
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<Esc>";
        action = "<C-\\><C-n>:hide<CR>";
        mode = "t";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        key = "<Space><Space>";
        action = ":Telescope find_files<CR>";
        mode = "n";
        options = {
          silent = true;
          noremap = true;
        };
      }
    ];
  };
}
