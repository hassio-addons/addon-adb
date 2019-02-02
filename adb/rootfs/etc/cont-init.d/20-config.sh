#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# Handles configuration paths for ADB
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare path

# Default storage keys path storage location
path="/data"

# If the user specified a custom keys path, use that.
if hass.config.has_value 'keys_path'; then
    path="$(hass.config.get 'keys_path')"
fi

ln -sf "${path}" /root/.android
