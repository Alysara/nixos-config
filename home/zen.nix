{ inputs, config ... }:

{
  home.packages = [
    inputs.zen-browser.packages."${system}".default.override {
      policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  ];

  # programs.zen-browser.policies = let
  #   mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
  #     install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
  #     installation_mode = "force_installed";
  #   });
  # in {
  #   ExtensionSettings = mkExtensionSettings {
  #     "wappalyzer@crunchlabz.com" = "wappalyzer";
  #     "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
  #   };
  # };


}