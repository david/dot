{ pkgs, ... }: {
  imports = [
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    fd
    grc
    ripgrep
    wl-clipboard
  ];

  programs.bash.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      fish_vi_key_bindings
    '';

    plugins = with pkgs.fishPlugins; [
      { name = "done" ; src = done.src; }
      { name = "fzf-fish" ; src = fzf-fish.src; }
      { name = "grc" ; src = grc.src; }
    ];
  };

  programs.fzf = {
    enable = true;
  };

  programs.jq.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;

    settings = {
      icons.separator = "  ";
    };
  };

  programs.starship = {
    enable = true;
    enableTransience = true;

    settings = {
      fill = {
        symbol = "─";
      };

      format = "$fill $directory $fill\n$character";
    };
  };
}
