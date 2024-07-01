{ pkgs, ... }: {
  home.packages = with pkgs; [
    fd
    grc
    ripgrep
    wl-clipboard
  ];

  programs.bash.enable = true;
  programs.btop.enable = true;

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting

      set --global hydro_multiline true

      fish_vi_key_bindings
    '';

    plugins = with pkgs.fishPlugins; [
      { name = "done" ; src = done.src; }
      { name = "fzf-fish" ; src = fzf-fish.src; }
      { name = "grc" ; src = grc.src; }
      { name = "hydro" ; src = hydro.src; }
    ];
  };

  programs.foot = {
    enable = true;

    settings.main.shell = "${pkgs.fish}/bin/fish";
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
}
