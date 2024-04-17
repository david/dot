{ pkgs, ... }: {
  systemd.user.services.background-switcher = {
    Unit = {
      Description = "Background image switcher service";
    };

    Service = {
      ExecStart = "${pkgs.nushell}/bin/nu ${toString ../scripts/bgctl.nu}";
      Type = "oneshot";
    };
  };

  systemd.user.timers.background-switcher = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };

    Timer = {
      OnCalendar = "*:0/5";
    };

    Unit = {
      Description = "Background switcher timer";
    };
  };
}
