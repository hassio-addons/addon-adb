#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare path

path="/data"

# If the user specified a custom keys path, use that.
if hass.config.has_value 'keys_path'; then
    path="$(hass.config.get 'keys_path')"
fi

ln -sf "${path}" /root/.android
