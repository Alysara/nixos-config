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
        ProviderURL = "https://doh.libredns.gr/noads";
        Fallback = false;
        Locked = true;
      };

      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        FormData = true;
        History = true;
        Sessions = true;
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
        "browser.tabs.unloadOnLowMemory" = true;
        "browser.low_commit_space_threshold_percent" = 100; # Make memory management aggressive; no wasteful memory usage
        "browser.tabs.warnOnClose" = false; # Remove annoying warning
        "browser.ctrlTab.sortByRecentlyUsed" = true; # Better ctrl + tab behavior

        # Anti-fingerprinting stuff
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.randomization.canvas.use_siphash" =	true;	
        "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
        "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "privacy.spoof_english" = 1;

        # Turn off geolocation features
        "geo.enabled" = false;
        "geo.provider.use_geoclue" = false;

        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.topsites.contile.endpoint" = "";
        "browser.topsites.contile.sov.enabled" = false;
        "browser.topsites.useRemoteSetting" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "duckduckgo";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "duckduckgo";
        "browser.partnerlink.campaign.topsites" = "";
        "browser.urlbar.sponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.discovery.sites" = "";
        "browser.newtabpage.activity-stream.discoverystream.spocTopsitesPlacement.enabled" = false;
        "browser.newtabpage.pinned" = ''[{"url":"https://duckduckgo.com","label":"DuckDuckGo"}]'';
        "browser.discovery.enabled" = false;

        # "layers.acceleration.disabled" = false;
        # "layers.acceleration.force-enabled" = true;
        # "gfx.webrender.all" = true;

        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;


        "browser.aboutConfig.showWarning" = false; # Remove annoying warning
        "intl.accept_languages" = "en-US, en";
        "javascript.use_us_english_locale" = true;

        # "browser.newtabpage.pinned" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;
        "network.prefetch-next" = false;
        "network.dns.disablePrefetch" = false;
        "network.dns.disablePrefetchFromHTTPS" = false;
        "network.predictor.enabled" = false;
        "network.predictor.enable-prefetch" = false;

        "network.http.speculative-parallel-limit" = 0;
        "browser.places.speculativeConnect.enabled" = false;

        "security.ssl.require_safe_negotiation" = true;
        "security.tls.enable_0rtt_data" = false;
        "security.OCSP.enabled" = 1;
        "security.OCSP.require" = true;
        "security.cert_pinning.enforcement_level" = 2;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;

        "dom.security.https_only_mode" = true;
        "dom.serviceWorkers.enabled" = false;
        "dom.security.https_only_mode_send_http_background_request" = false;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "browser.sessionstore.privacy_level" = 2;

        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.peerconnection.ice.default_address_only" = true;
        "dom.disable_window_move_resize" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "devtools.debugger.remote-enabled" = false;
        "permissions.manager.defaultsUrl" = "";

        "network.IDN_show_punycode" = true;
        "security.csp.reporting.enabled" = false;
        "browser.download.useDownloadDir" = false;
        "browser.download.manager.addToRecentDocs" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        "extensions.enabledScopes" = 5;
        "browser.link.open_newwindow.restriction" = 0;

        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
      };
    };

    profiles."personal-profile" = {
      settings = {
        "zen.folders.owned-tabs-in-folder" = true; # Ensure child tabs stay in parent folders
        "zen.welcome-screen.seen" = true; # Skip annoying introduction sequence
        "zen.theme.gradient.show-custom-colors" = true; # See exact colors; more granular than zen's color wheel thing
        "zen.urlbar.behavior" = "float";
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