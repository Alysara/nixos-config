#!/usr/bin/env bash
set -euo pipefail

# usage: ./add-extension.sh <amo-download-url> <nix-file>
# example: ./add-extension.sh "https://addons.mozilla.org/firefox/downloads/file/4253456/wappalyzer-6.10.52.xpi" ./home.nix

if [ $# -ne 2 ]; then
  echo "Usage: $0 <extension-name> <file-path>"
  exit 1
fi

EXT_NAME="$1"
NIX_FILE=$(realpath "$2")

LATEST_URL="https://addons.mozilla.org/firefox/downloads/latest/${EXT_NAME}/latest.xpi"

echo "[*] Latest URL: $LATEST_URL"

# Step 2: Download the XPI
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
wget -q "$LATEST_URL" -O extension.xpi

# Step 3: Extract manifest.json
unzip -q extension.xpi manifest.json

# Step 4: Get extension ID
EXT_ID=$(jq -r '.browser_specific_settings.gecko.id // .applications.gecko.id' manifest.json)

if [ -z "$EXT_ID" ] || [ "$EXT_ID" = "null" ]; then
  echo "[-] Could not find extension ID in manifest.json"
  exit 1
fi

echo "[*] Extension ID: $EXT_ID"

# Step 5: Insert into Nix file after 'ExtensionSettings = mkExtensionSettings {'
EXT_SNIPPET="        \"$EXT_ID\" = \"$EXT_NAME\";"

# Use sed to insert the line only if it’s not already present
if ! grep -q "$EXT_ID" "$NIX_FILE"; then
  sed -i "/ExtensionSettings = mkExtensionSettings {/a\\
$EXT_SNIPPET" "$NIX_FILE"
  echo "[+] Inserted into $NIX_FILE"
else
  echo "[!] $EXT_ID already present in $NIX_FILE"
fi

# Cleanup
cd -
rm -rf "$TMP_DIR"
