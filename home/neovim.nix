{
  pkgs,
  inputs,
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
