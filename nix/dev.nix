{ ... }: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.git = {
    enable = true;

    delta = {
      enable = true;

      options = {
        hyperlinks = true;
        line-numbers = true;
        navigate = true;
        side-by-side = true;
        true-color = "always";
      };
    };

    extraConfig = {
      diff = {
        colorMoved = true;
      };

      init = {
        defaultBranch = "trunk";
      };

      merge = {
        conflictstyle = "diff3";
      };
    };
  };

  programs.lazygit = {
    enable = true;

    settings = {
      git.paging = {
        colorArg = "always";
        pager = "delta --dark --paging=never";
      };

      gui.sidePanelWidth = 0.20;
    };
  };
}
