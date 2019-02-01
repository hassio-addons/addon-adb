#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# Sets up the configuration folder
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

mkdir -p /root/.android \
    || hass.die "Failed creating ADB configuration folder"

if hass.config.has_value 'private_key'; then
    cp "$(hass.config.get 'private_key')" /root/.android/adbkey \
      || hass.die "Failed adding ADB private key file to config folder"
    cp "$(hass.config.get 'public_key')" /root/.android/adbkey.pub \
      || hass.die "Failed adding ADB public key file to config folder"
else
    ln -s /data/adbkey /root/.android/adbkey \
      || hass.die "Failed adding ADB private key file to config folder"
    ln -s /data/adbkey.pub /root/.android/adbkey.pub \
      || hass.die "Failed adding ADB public key file to config folder"
fi
