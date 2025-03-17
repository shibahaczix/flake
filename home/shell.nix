{ ... }:

{
  # Shell related
  home.shellAliases = {
    g = "git";
    fs = "fastfetch";
    ssh = "env TERM=xterm-256color ssh";
  };

  # Makes starship work in nix-shell and nix develop
  programs.bash.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.starship = {
    enable = true;
    settings = let # Segments
      seg1 = "#A600FF";
      seg2 = "#871BFF";
      seg3 = "#6836FF";
      seg4 = "#4852FF";
      seg5 = "#296DFF";
      seg6 = "#0A88FF";
    in {
      format =
        "[](${seg1})$os$username[](bg:${seg2} fg:${seg1})$directory[](fg:${seg2} bg:${seg3})$git_branch$git_status[](fg:${seg3} bg:${seg4})$c$elixir$elm$golang$gradle$haskell$java$julia$nodejs$nim$rust$scala[](fg:${seg4} bg:${seg5})$docker_context[](fg:${seg5} bg:${seg6})$time[ ](fg:${seg6})";
      username = {
        show_always = true;
        style_user = "bg:${seg1}";
        style_root = "bg:${seg1}";
        format = "[$user ]($style)";
        disabled = false;
      };

      os = {
        style = "bg:${seg2}";
        disabled = true;
      };

      directory = {
        style = "bg:${seg2}";
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
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      docker_context = {
        symbol = " ";
        style = "bg:${seg5}";
        format = "[ $symbol $context ]($style)";
      };

      elixir = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      elm = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      git_branch = {
        symbol = "";
        style = "bg:${seg3}";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:${seg3}";
        format = "[$all_status$ahead_behind ]($style)";
      };

      golang = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      gradle = {
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      haskell = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      julia = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      nim = {
        symbol = "󰆥 ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      scala = {
        symbol = " ";
        style = "bg:${seg4}";
        format = "[ $symbol ($version) ]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:${seg6}";
        format = "[ $time ]($style)";
      };
    };
  };
}
