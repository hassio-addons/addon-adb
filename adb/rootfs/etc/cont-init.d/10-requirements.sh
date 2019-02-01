#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.has_value 'private_key' \
        && ! hass.config.has_value 'public_key';
then
    hass.die "Private key was provided, but no public key!"
fi

if hass.config.has_value 'public_key' \
        && ! hass.config.has_value 'private_key';
then
    hass.die "Public key was provided, but no private key!"
fi

if hass.config.has_value 'public_key' \
        && hass.config.has_value 'private_key';
then

    if ! hass.file_exists "/ssl/$(hass.config.get 'private_key')"; then
            hass.die 'The specified private key could not be found'
    fi

    if ! hass.file_exists "/ssl/$(hass.config.get 'public_key')"; then
            hass.die 'The specified private key could not be found'
    fi
fi

if ! hass.config.has_value 'devices'; then
    hass.log.warning "No devices are specified!"
    hass.log.warning "The add-on might not work as expected."
fi
