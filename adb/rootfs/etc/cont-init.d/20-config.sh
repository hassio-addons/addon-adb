#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# Handles configuration paths for ADB
# ==============================================================================
declare path

# Default storage keys path storage location
path="/data"

# If the user specified a custom keys path, use that.
if bashio::config.has_value 'keys_path'; then
    path="$(bashio::config 'keys_path')"
fi

ln -sf "${path}" /root/.android
