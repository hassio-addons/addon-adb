#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# Configures ADB
# ==============================================================================
declare path

if bashio::config.has_value 'keys_path' \
        && ! bashio::fs.directory_exists "$(bashio::config 'keys_path')";
then
    bashio::log.fatal
    bashio::log.fatal 'It seems like you have configured the "keys_path"'
    bashio::log.fatal 'option, unfortunately, the path specified could'
    bashio::log.fatal 'not be found.'
    bashio::log.fatal
    bashio::log.fatal 'Please double check the add-on configuration.'
    bashio::log.fatal
    bashio::exit.nok
fi

if ! bashio::config.has_value 'devices'; then
    bashio::log.warning
    bashio::log.warning 'No devices are specified!'
    bashio::log.warning
    bashio::log.warning 'The ADB add-on connects to Android device, but you'
    bashio::log.warning 'have left the "devices" add-on option empty.'
    bashio::log.warning
    bashio::log.warning 'The add-on might not work as expected.'
    bashio::log.warning
fi

# Default storage keys path storage location
path="/data"

# If the user specified a custom keys path, use that.
if bashio::config.has_value 'keys_path'; then
    path="$(bashio::config 'keys_path')"
fi

ln -sf "${path}" /root/.android
