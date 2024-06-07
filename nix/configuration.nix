{ inputs, pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };

      efi.canTouchEfiVariables = true;
    };

    # plymouth.enable = true;
  };

  networking = {
    hostName = "timbuktu";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  services.xserver = {
    enable = true;

    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.keyd = {
    enable = true;

    keyboards.builtin = {
      ids = [ "0001:0001" ];

      extraConfig = ''
        [main]

        leftshift = `
        leftalt = overloadt(num, esc, 200)

        capslock = overloadt(desktop, backspace, 200)

        a = overloadt(meta, a, 200)
        s = overloadt(control, s, 200)
        d = overloadt(alt, d, 200)
        f = overloadt(shift, f, 200)
        g = overloadt(sym, g, 200)

        h = overloadt(sym, h, 200)
        j = overloadt(shift, j, 200)
        k = overloadt(alt, k, 200)
        l = overloadt(control, l, 200)
        ; = overloadt(meta, ;, 200)
        ' = overloadt(desktop, ', 200)

        space = overloadt(nav, space, 200)

        rightalt = enter

        [nav]

        h = left
        j = down
        k = up
        l = right

        [num]

        q = 1
        w = 2
        e = 3
        r = 4
        t = 5
        y = 6
        u = 7
        i = 8
        o = 9
        p = 0
        ; = 0
        j = 4
        k = 5
        l = 6
        m = 1
        , = 2
        . = 3

        [sym]

        q = !
        w = @
        e = #
        r = $
        t = %
        y = ^
        f = -
        g = _
        u = &
        i = *
        o = (
        p = )
        h = _
        j = -
        k = =
        l = [
        ; = ]
        , = +
        . = {
        / = }

        [desktop:C-A-S]
      '';
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    enableAllFirmware = true;

    keyboard.zsa.enable = true;

    pulseaudio.enable = false;

    tuxedo-keyboard.enable = true;
  };

  security = {
    loginDefs.settings.UMASK = "077";
    rtkit.enable = true;
    polkit.enable = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  sound.enable = true;

  users = {
    groups.plugdev.name = "plugdev";

    users.david = {
      isNormalUser = true;
      description = "David Leal";
      extraGroups = [ "networkmanager" "plugdev" "wheel" ];
    };
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1d";
    };  

    optimise.automatic = true;

    package = pkgs.nixFlakes;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "david" ];
    };
  };

  environment = {
    gnome.excludePackages = (with pkgs; [
      gedit
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese
      epiphany
      gnome-contacts
      gnome-initial-setup
      gnome-music
      yelp
    ]);

    localBinInPath = true;

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = [ ];
  };

  programs.bash.blesh.enable = true;

  programs.dconf.enable = true;

  services.fwupd.enable = true;

  services.gnome.games.enable = false;

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "david";

    defaultSession = "gnome";
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = with pkgs; [
      (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
    ];
  };

  services.restic.backups = {
    timbuktu = {
      rcloneConfigFile = "/etc/nixos/secrets/rclone.conf";
      repositoryFile = "/etc/nixos/secrets/restic-repo";
      passwordFile = "/etc/nixos/secrets/restic-passwd";
      paths = [
        "/home"
	"/etc/nixos"
      ];
      timerConfig = {
        OnCalendar = "23:05";
	RandomizedDelaySec = "5h";
      };
    };
  };

  services.upower.enable = true;

  system.stateVersion = "23.11";
}
