{ pkgs, ... }: {
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    cursor = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };

    fonts = {
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      monospace = {
        package = pkgs.cantarell-fonts;
        name = "Iosevka Timbuktu";
      };

      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };

      serif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarell";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };

    image = builtins.head (pkgs.lib.filesystem.listFilesRecursive ../backgrounds);

    opacity = {
      desktop = 0.5;
      terminal = 0.9;
    };

    polarity = "dark";

    targets.gnome.enable = true;
  };
}
