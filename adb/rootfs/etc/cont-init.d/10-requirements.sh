#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.has_value 'keys_path' \
        && ! hass.directory_exists "$(hass.config.get 'keys_path')";
then
        hass.die 'The specified keys path could not be found'
fi

if ! hass.config.has_value 'devices'; then
    hass.log.warning "No devices are specified!"
    hass.log.warning "The add-on might not work as expected."
fi
