#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Android Debug Bridge
# Generates an RSA private/public keypair in case is does not exists yet
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if ! hass.config.has_value 'private_key' \
    && ! hass.file_exists "/data/adbkey";
then
    ssh-keygen -t rsa -b 2048 -f /data/adbkey -N '' \
        || hass.die "Failed genering a private/public keypair"
fi
