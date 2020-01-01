ARG BUILD_FROM=hassioaddons/ubuntu-base:4.0.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base
# hadolint ignore=DL3003
RUN \
    apt-get update \
    \
    && apt-get install -y --no-install-recommends \
        adb=1:7.0.0+r33-2 \
        android-libadb=1:7.0.0+r33-2 \
        android-libbase=1:7.0.0+r33-2 \
        android-libcutils=1:7.0.0+r33-2 \
        android-liblog=1:7.0.0+r33-2 \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Android Debug Bridge" \
    io.hass.description="The Android Debug Bridge server program" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="The Android Debug Bridge server program" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Android Debug Bridge" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-adb-android-debug-bridge/96375?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-adb/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-adb" \
    org.label-schema.vendor="Community Hass.io Add-ons"
