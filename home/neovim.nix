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
        lsp = {enable = true;};
        languages = {
          nix.enable = true;
          enableFormat = true;
        };
        lazy.enable = true;
        visuals.indent-blankline.enable = true;
        lsp.formatOnSave = true;

        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = false;
        };

        telescope.enable = true;
        statusline.lualine.enable = true;
        autocomplete = {
          nvim-cmp.enable = true;
          blink-cmp.enable = true;
        };
        lazy.plugins = {
        };
      };
    };
  };
}
