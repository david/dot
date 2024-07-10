{ pkgs, ... }: {
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
    firewall = {
      enable = true;

      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };

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
      automatic = false;
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
    localBinInPath = true;

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };

  programs.hyprland.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 3d --keep 3";
    flake = "/home/david/sys";
  };

  services.fwupd.enable = true;

  services.greetd = let
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.hyprland}/bin/Hyprland";
    username = "david";
  in {
    enable = true;

    settings = {
      initial_session = {
        command = "${session}";
        user = "${username}";
      };

      default_session = {
        command = "${tuigreet} --greeting 'Timbuktu'" +
        " --asterisks --remember --remember-user-session --time --cmd ${session}";
        user = "greeter";
      };
    };
  };

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    packages = [
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
