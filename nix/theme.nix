{ pkgs, ... }: {
  stylix = {
    image = builtins.head (pkgs.lib.filesystem.listFilesRecursive ../backgrounds);
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    cursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 48;
    };

    targets.gnome.enable = true;
  };
}
