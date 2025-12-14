# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nixos/hardware.nix
      ./nixos/ly.nix
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_17;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;

  # # Enable the KDE Plasma Desktop Environment.
  # # services.displayManager.sddm.enable = true;
  # # services.desktopManager.plasma6.enable = true;

  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alysara = {
    isNormalUser = true;
    description = "Alysara";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # kdePackages.kate
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.nm-applet.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    networkmanagerapplet
    wireguard-tools
    protonvpn-gui
    clamav
    intel-gpu-tools
    htop
  ];

  # services.clamav.daemon.enable = true;
  # services.clamav.updater.enable = true;

  networking.firewall.checkReversePath = false;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
  
  hardware.bluetooth.enable = true;
  
  services.blueman.enable = true;
  
  services.displayManager = {
    sessionPackages = [
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland
    ];
  }; 

  environment.sessionVariables.NIXOS_OZ_ONE_WL = "1";

  hardware.enableRedistributableFirmware = true;

  security.wrappers.btop = {
    owner = "root";
    group = "root";
    source = "${pkgs.btop.override { cudaSupport = true; } }/bin/btop";
    capabilities = "cap_perfmon+ep";
  };
  
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  powerManagement.enable = true;
  # services.thermald.enable = true; # This sucks on a XPS 15 9530, research if your model works with this.
  services.tlp.enable = true;

  boot.loader.systemd-boot.configurationLimit = 5;

  # services.searx = {
  #   enable = true;
  #   redisCreateLocally = true;
  #   user = "searxng";
    
  #   settings = {
  #     server = {
  #       port = 8888;
  #       bind_address = "127.0.0.1";  # localhost only
  #       secret_key = "SHfhe8w9GEWdf[-0zsDH*(GEPWIOkgwe-)]";  # Generate a secure random string
  #     };
      
  #     general = {
  #       instance_name = "My SearXNG Instance";
  #       donation_url = false;
  #       contact_url = false;
  #       privacypolicy_url = false;
  #       enable_metrics = false;
  #     };

  #     ui = {
  #       query_in_title = true;
  #       infinite_scroll = true;
  #       hotkeys = "vim";
  #     };
      
  #     search = {
  #       safe_search = 0;  # 0=None, 1=Moderate, 2=Strict
  #       autocomplete = "duckduckgo";
  #       formats = [ "html" "json" ];
  #     };

  #     outgoing = {
  #       request_timeout = 5.0;
  #       max_request_timeout = 15.0;
  #       pool_connections = 100;
  #       pool_maxsize = 15;
  #       enable_http2 = true;
  #     };

  #     engines = lib.mapAttrsToList (name: value: { inherit name; } // value) {
  #       # General Search - Privacy-focused
  #       "google".disabled = true;
  #       "duckduckgo".disabled = false;
  #       "duckduckgo".weight = 2;
  #       "startpage".disabled = false;
  #       "startpage".weight = 1.5;
  #       "brave".disabled = false;
  #       "brave".weight = 1;
  #       "bing".disabled = true;
  #       "mojeek".disabled = true;
  #       "mwmbl".disabled = true;
  #       "qwant".disabled = true;
  #       "crowdview".disabled = true;
  #       "curlie".disabled = true;
        
  #       # Definitions & Knowledge
  #       "ddg definitions".disabled = false;
  #       "ddg definitions".weight = 2;
  #       "wikibooks".disabled = false;
  #       "wikibooks".weight = 0.8;
  #       "wikidata".disabled = false;
  #       "wikidata".weight = 1;
  #       "wikiquote".disabled = true;
  #       "wikisource".disabled = true;
  #       "wikispecies".disabled = true;
  #       "wikiversity".disabled = true;
  #       "wikivoyage".disabled = true;
        
  #       # Utilities
  #       "currency".disabled = true;
  #       "dictzone".disabled = true;
  #       "lingva".disabled = true;
        
  #       # Images - Privacy-focused
  #       "bing images".disabled = true;
  #       "brave.images".disabled = false;
  #       "brave.images".weight = 1.5;
  #       "duckduckgo images".disabled = false;
  #       "duckduckgo images".weight = 2;
  #       "google images".disabled = true;
  #       "qwant images".disabled = true;
  #       "1x".disabled = true;
  #       "artic".disabled = true;
  #       "deviantart".disabled = true;
  #       "flickr".disabled = true;
  #       "imgur".disabled = true;
  #       "library of congress".disabled = true;
  #       "material icons".disabled = true;
  #       "openverse".disabled = false;
  #       "openverse".weight = 1;
  #       "pinterest".disabled = true;
  #       "svgrepo".disabled = false;
  #       "svgrepo".weight = 0.8;
  #       "unsplash".disabled = true;
  #       "wallhaven".disabled = true;
  #       "wikicommons.images".disabled = false;
  #       "wikicommons.images".weight = 1.2;
  #       "yacy images".disabled = true;
        
  #       # Videos - Privacy-focused
  #       "bing videos".disabled = true;
  #       "brave.videos".disabled = false;
  #       "brave.videos".weight = 1.5;
  #       "duckduckgo videos".disabled = false;
  #       "duckduckgo videos".weight = 1.5;
  #       "google videos".disabled = true;
  #       "qwant videos".disabled = true;
  #       "dailymotion".disabled = true;
  #       "google play movies".disabled = true;
  #       "invidious".disabled = true;
  #       "odysee".disabled = true;
  #       "peertube".disabled = false;
  #       "peertube".weight = 1;
  #       "piped".disabled = true;
  #       "rumble".disabled = true;
  #       "sepiasearch".disabled = true;
  #       "vimeo".disabled = true;
  #       "youtube".disabled = false;
  #       "youtube".weight = 1.5;
        
  #       # News
  #       "brave.news".disabled = false;
  #       "google news".disabled = true;
  #     };

  #     # Enabled plugins
  #     enabled_plugins = [
  #       "Basic Calculator"
  #       "Hash plugin"
  #       "Tor check plugin"
  #       "Open Access DOI rewrite"
  #       "Hostnames plugin"
  #       "Unit converter plugin"
  #       "Tracker URL remover"
  #     ];
  #   };

  #   favicons = {
  #     fetch = true;
  #     cache = {
  #       path = "/var/cache/searxng/favicons";
  #       max_size = 2147483648;   # 2GB
  #       ttl = 5184000;           # 60 days
  #     };
  #   };

    # faviconsSettings = {
    #   favicons = {
    #     cfg_schema = 1;
    #     cache = {
    #       db_url = "/var/cache/searx/faviconcache.db";
    #       HOLD_TIME = 5184000;        # 60 days in seconds
    #       LIMIT_TOTAL_BYTES = 2147483648;  # 2GB cache limit
    #       BLOB_MAX_BYTES = 40960;     # 40KB max per favicon
    #       MAINTENANCE_MODE = "auto";   # Automatic cache maintenance
    #       MAINTENANCE_PERIOD = 600;    # Run maintenance every 10 minutes
    #     };
    #   };
    # };
  # };

}
