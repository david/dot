{ pkgs, ... }: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    cursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 32;
    };

    image = builtins.head (pkgs.lib.filesystem.listFilesRecursive ../backgrounds);

    opacity.terminal = 0.64;

    polarity = "dark";

    targets.gnome.enable = true;
  };
}
