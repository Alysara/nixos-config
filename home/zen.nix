{ inputs, config, ... }:

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
        History = true;
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
        "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = "chameleon-ext";
        "sponsorBlocker@ajay.app" = "sponsorblock";
        "addon@darkreader.org" = "darkreader";
        "uBlock0@raymondhill.net" = "ublock-origin";
      };

      Preferences = mkLockedAttrs {
        "browser.low_commit_space_threshold_percent" = 100;
        "browser.tabs.warnOnClose" = false;
        "browser.ctrlTab.sortByRecentlyUsed" = true;

        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.randomization.canvas.use_siphash" =	true;	
        "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
        "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;

        "privacy.firstparty.isolate" = true;
        "geo.enabled" = false;
        # "dom.event.clipboardevents.enabled" = false;
      };
    };

    profiles."personal-profile" = {
      settings = {
        "zen.folders.owned-tabs-in-folder" = true;
        "zen.welcome-screen.seen" = true;
        "zen.theme.gradient.show-custom-colors" = true;
      };

      containersForce = true;

      containers = {
        Personal = {
          color = "purple";
          icon = "fingerprint";
          id = 1;
        };
        Music = {
          color = "red";
          icon = "fingerprint";
          id = 2;
        };
        School = {
          color = "yellow";
          icon = "fingerprint";
          id = 3;
        };
      };
      spacesForce = true;
      spaces = let
        containers = config.programs.zen-browser.profiles."personal-profile".containers;
      in {
        "Personal" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          container = containers."Personal".id;
          icon = "";
          # spacesForce = true;
          theme = {
            type = "gradient";
            colors = [
              { red = 116; green = 0; blue = 255; }
              { red = 0; green = 175; blue = 255; }
            ];
          };
        };
        "Music" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          container = containers."Music".id;
          icon = "";
          position = 2000;
          theme = {
            type = "gradient";
            colors = [
              { red = 255; green = 0; blue = 0; }
              { red = 252; green = 113; blue = 100; }
            ];
          };
        };
        "School" = {
          id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
          icon = "󰑴";
          container = containers."School".id;
          position = 3000;
          theme = {
            type = "gradient";
            colors = [
              { red = 73; green = 58; blue = 0; }
              { red = 84; green = 76; blue = 47; }
            ];
          };
        };
      };
    };



  };
}