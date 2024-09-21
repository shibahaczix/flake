{ pkgs, config, ... }:

{
  home.shellAliases = {
    vim = "nvim";
    g = "git";
    fs = "fastfetch";
    fl = "sudo nixos-rebuild switch --flake .#nixos";
  };

  programs.bash = { enable = true; };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      format = "[](#A600FF)$os$username[](bg:#871BFF fg:#A600FF)$directory[](fg:#871BFF bg:#6836FF)$git_branch$git_status[](fg:#6836FF bg:#4852FF)$c$elixir$elm$golang$gradle$haskell$java$julia$nodejs$nim$rust$scala[](fg:#4852FF bg:#296DFF)$docker_context[](fg:#296DFF bg:#0A88FF)$time[ ](fg:#0A88FF)";
      username = {
        show_always = true;
        style_user = "bg:#A600FF";
        style_root = "bg:#A600FF";
        format = "[$user ]($style)";
        disabled = false;
      };

      os = {
        style = "bg:#871BFF";
        disabled = true;
      };

      directory = {
        style = "bg:#871BFF";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
      };

      c = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bg:#296DFF";
        format = "[ $symbol $context ]($style)";
      };

      elixir = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      elm = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:#6836FF";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#6836FF";
        format = "[$all_status$ahead_behind ]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      gradle = {
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      haskell = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      julia = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      nim = {
        symbol = "󰆥 ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      scala = {
        symbol = " ";
        style = "bg:#4852FF";
        format = "[ $symbol ($version) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#0A88FF";
        format = "[ $time ]($style)";
      };
    };
  };
}
