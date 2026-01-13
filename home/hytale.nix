{ pkgs, ... }:
let
  runtimeDeps = with pkgs; [
    glib
    gtk3
    webkitgtk_4_1
    gdk-pixbuf
    libsoup_3
    cairo
    pango
    harfbuzz
    atk
    openssl
    zlib
  ];

  hytale-launcher-fhs = pkgs.buildFHSEnv {
    name = "hytale-launcher";
    
    targetPkgs = pkgs: runtimeDeps ++ (with pkgs; [
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
      xorg.libxcb
      libxkbcommon
      vulkan-loader
      alsa-lib
      pulseaudio
      dbus
      gsettings-desktop-schemas
      glib
      hicolor-icon-theme
      adwaita-icon-theme
      curl
      unzip
      patchelf
      icu
      # Add these directly to targetPkgs
      mesa
      libGL
      libGLU
    ]);

    # Also add to multiPkgs for good measure
    multiPkgs = pkgs: with pkgs; [
      mesa
      libGL
      libGLU
    ];

    profile = ''
      export GDK_BACKEND=x11
      export WEBKIT_DISABLE_COMPOSITING_MODE=1
      export XDG_DATA_DIRS="${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS"
      export LD_LIBRARY_PATH="/usr/lib:/usr/lib64:${pkgs.icu}/lib:$LD_LIBRARY_PATH"
    '';

    runScript = pkgs.writeShellScript "hytale-launcher-wrapper" ''
      set -e

      LAUNCHER_DIR="$HOME/.local/share/hytale-launcher"
      LAUNCHER_BIN="$LAUNCHER_DIR/hytale-launcher"
      DOWNLOAD_URL="https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.zip"

      mkdir -p "$LAUNCHER_DIR"

      if [ ! -f "$LAUNCHER_BIN" ]; then
        echo "Downloading Hytale Launcher..."
        TEMP_DIR=$(mktemp -d)
        trap "rm -rf $TEMP_DIR" EXIT

        curl -L -o "$TEMP_DIR/launcher.zip" "$DOWNLOAD_URL"
        unzip -o "$TEMP_DIR/launcher.zip" -d "$TEMP_DIR"
        mv "$TEMP_DIR/hytale-launcher" "$LAUNCHER_BIN"
        chmod +x "$LAUNCHER_BIN"

        echo "Hytale Launcher installed successfully!"
      fi

      cd "$LAUNCHER_DIR"
      exec "$LAUNCHER_BIN" "$@"
    '';

    meta = with pkgs.lib; {
      description = "Hytale Game Launcher";
      homepage = "https://hytale.com";
      license = licenses.unfree;
      platforms = [ "x86_64-linux" ];
      mainProgram = "hytale-launcher";
    };
  };

  desktopItem = pkgs.makeDesktopItem {
    name = "hytale-launcher";
    desktopName = "Hytale Launcher";
    comment = "Official Hytale Game Launcher";
    exec = "hytale-launcher";
    icon = "hytale-launcher";
    terminal = false;
    type = "Application";
    categories = [ "Game" ];
    keywords = [ "hytale" "game" "launcher" ];
  };

  hytaleIcon = pkgs.fetchurl {
    url = "https://hytale.com/favicon.ico";
    hash = "sha256-eniMb/wct+vjtzXF2z8Z1XPBmwabjV8RCDyd8J1QLT0=";
  };

  hytaleIconPng = pkgs.runCommand "hytale-launcher-icon" {
    nativeBuildInputs = [ pkgs.imagemagick ];
  } ''
    mkdir -p $out
    convert ${hytaleIcon} -thumbnail 256x256 -alpha on -background none -flatten $out/hytale-launcher.png
  '';

in pkgs.symlinkJoin {
  name = "hytale-launcher";
  paths = [ hytale-launcher-fhs desktopItem ];
  postBuild = ''
    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp ${hytaleIconPng}/hytale-launcher.png $out/share/icons/hicolor/256x256/apps/hytale-launcher.png
    
    mkdir -p $out/share/pixmaps
    cp ${hytaleIconPng}/hytale-launcher.png $out/share/pixmaps/hytale-launcher.png
  '';
}