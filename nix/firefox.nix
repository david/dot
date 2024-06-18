{ ... }: {
  programs.firefox = let
    True = { Value = true; Status = "locked"; };
    False = { Value = false; Status = "locked"; };
  in {
    enable = true;

    policies = {
      DisablePocket = true;

      Preferences = {
        "browser.aboutConfig.showWarning" = False;
        "browser.sessionstore.resume_from_crash" = False;
        "browser.translations.automaticallyPopup" = False;
        "browser.toolbars.bookmarks.visibility" = False;
        "devtools.toolbox.host" = { Value = "window"; };
        "toolkit.legacyUserProfileCustomizations.stylesheets" = True;
      };
    };

    profiles.default = {
      id = 0;

      isDefault = true;

      userChrome = ''
        #TabsToolbar {
          display: none;
        }
      '';
    };
  };
}
