{ pkgs, ... }: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    cursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 32;
    };

    fonts = {
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "Iosevka Timbuktu";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Condensed";
      };

      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif Condensed";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };

    image = builtins.head (pkgs.lib.filesystem.listFilesRecursive ../backgrounds);

    opacity.terminal = 0.64;

    polarity = "dark";

    targets.gnome.enable = true;
  };
}
