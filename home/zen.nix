{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.default
  ];

  programs.zen-browser = {
    enable = true;
    policies = let 
      mkExtensionSettings = builtins.mapAttrs (_: pluginId: {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
        installation_mode = "force_installed";
      });

      mkLockedAttrs = builtins.mapAttrs (_: value: {
        Value = value;
        Status = "locked";
      });
    in {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      SkipTermsOfUse = true;
      SearchEngines.Default = "DuckDuckGo";
      HttpsOnlyMode = "force_enabled";

      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://doh.libredns.gr/dns-query";
        Fallback = false;
        Locked = true;
      };

      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        FormData = true;
        History = false;
        Sessions = false;
        SiteSettings = false;
        Locked = true;
      };

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        Category = "strict";
      };

      ExtensionSettings = mkExtensionSettings {
        "addon@darkreader.org" = "darkreader";
        "uBlock0@raymondhill.net" = "ublock-origin";
      };

      Preferences = mkLockedAttrs {
        "browser.low_commit_space_threshold_percent" = 100;
        "browser.tabs.warnOnClose" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
      };
    };
  };
}