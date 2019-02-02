# Community Hass.io Add-ons: Android Debug Bridge

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

[![GitLab CI][gitlabci-shield]][gitlabci]
![Project Maintenance][maintenance-shield]
[![GitHub Activity][commits-shield]][commits]

[![Discord][discord-shield]][discord]
[![Community Forum][forum-shield]][forum]

[![Buy me a coffee][buymeacoffee-shield]][buymeacoffee]

[![Support my work on Patreon][patreon-shield]][patreon]

The Android Debug Bridge server program.

## About

The Android Debug Bridge (ADB) is a client-server program used in Android
application development. This add-on provides the server program and can be
used to get full local control over your Android (TV) devices.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Hass.io add-on.

1. [Add our Hass.io add-ons repository][repository] to your Hass.io instance.
1. Install the "ADB - Android Debug Bridge" add-on.
1. Ensure that your Android device has [developer mode and network debugging](#enabling-developer-mode-on-your-device)
   enabled.
1. Add the IP addresses of your device(s) to the add-on configuration.
1. Start the "ADB - Android Debug Bridge" add-on.
1. Check the logs of the add-on to see if everything went well.
1. Ready to go!

**NOTE**: Do not add this repository to Hass.io, please use:
`https://github.com/hassio-addons/repository`.

## Docker status

![Supports armhf Architecture][armhf-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]
![Supports i386 Architecture][i386-shield]

[![Docker Layers][layers-shield]][microbadger]
[![Docker Pulls][pulls-shield]][dockerhub]

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration, with all available options:

```json
{
  "log_level": "info",
  "devices": [
    "192.168.1.123",
    "192.168.1.100"
  ],
  "reconnect_timeout": 90,
  "keys_path": "/config/.androidkeys"
}
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Option: `devices`

Allows you to provide a list of IP addresses (or hostnames) of devices to
which the ADB server program connects.

### Option: `reconnect_timeout`

The add-on will try to (re)connect to the listed devices after this timeout
has passed. In case one of your devices goes offline and comes back online again
the add-on will connect to it within this time setting.

The default is 90 seconds.

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`:  Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.

### Option: `keys_path`

Allows you to provide a custom path to where the private/public key pair is
stored. This option is not listed by default and completely optional.
If you omit this option, the add-on will generate
and store a key pair for you internally.

If the provided directory is empty, the add-on will create
a new (fresh) key pair in the specified location.
You can also provide your own key pair, which **must** be named
 `adbkey` and `adbkey.pub` (and stored in the specified location).

The `keys_path` path must be in either `/ssl`, `/config` or `/share`, subfolders
are allowed (e.g., `/config/adb/mykeys`).

## Enabling developer mode on your device

Your device must be running in developer & debugging mode, to allow this
add-on to connect. To do this, follow these steps on your Android TV device:

1. Press Home and go into Settings.
1. Select and press "About" from the Settings menu.
1. Scroll down to the "Build" information.
1. Select and click on "Build" several times (6-10 times).
1. A dialog appears, saying: "You are now a developer".
1. Press Home and go into Settings again.
1. Select and press "System Preferences" from the Settings menu.
1. Select and press "Developer options".
1. Scroll down to "Debugging".
1. Turn on "Network debugging".
1. Done!

Not all devices have the same procedure, so for your device, it might
differ a bit. A quick search on Google would probably lead you towards
a specific solution for your device.

## Integrating into Home Assistant

This ADB add-on can be used with all Android-based devices, and we expect
multiple integrations for this to appear in Home Assistant itself.

Integration for the Android TV (Sony, NVidia Shield, Xiaomi Mi Box) media
player component, is currently under review by the Home Assistant team
and is expected to be part of the Home Assistant core soon.

Nevertheless, you can already use this component by installing it as a custom
component in your setup. This addon provide you a custom component that
was tested for use with this add-on: [`custom_components/media_player/androidtv.py`](/custom_components/media_player/androidtv.py)

Download that file from this GitHub repository and store the file inside your
Home Assistant configuration folder. In case of Hass.io, store it in:
`/config/custom_components/media_player/androidtv.py`. Restart Home Assistant
so it can pick up this component.

**Note**: This is a development version of the Android TV component, and might
contain issues.

When the custom component is added to your Home Assistant setup, you
can use it like so:

```yaml
# Example configuration.yaml entry
# Based on adding my NVidia Shield, which has IP 192.168.1.34.
media_player:
  - platform: androidtv
    host: 192.168.1.34
    name: "NVidia Shield"
    adb_server_ip: a0d7b954-adb
    adb_server_port: 5037
```

**Note**: Please note, `a0d7b954-adb` is correct and is actually an internal
add-on hostname reference for Hass.io.

## Useful tips and tricks

- There is a Chrome Extention/App called "ADB Chrome", which can connect
  to this add-on and actually sideload apps as well!
- Using the `androidtv` component, you can send intents via a service call:
  - Send `netflix://` as an intent, to start Netflix on your Android TV.
  - Send `twitch://stream/frenck` as an intent,
    to start streaming my stream on Twitch.
  - Send any YouTube URL as an intent, to start streaming a video on YouTube.

## Known issues and limitations

- This add-on does support ARM-based devices, nevertheless, they must
  at least be an ARMv7 device. (Raspberry Pi 1 and Zero is not supported).

## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality. The format of the log is based on
[Keep a Changelog][keepchangelog].

Releases are based on [Semantic Versioning][semver], and use the format
of ``MAJOR.MINOR.PATCH``. In a nutshell, the version will be incremented
based on the following:

- ``MAJOR``: Incompatible or major changes.
- ``MINOR``: Backwards-compatible new features and enhancements.
- ``PATCH``: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- The [Community Hass.io Add-ons Discord chat server][discord] for add-on
  support and feature requests.
- The [Home Assistant Discord chat server][discord-ha] for general Home
  Assistant discussions and questions.
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] GitHub.

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

We have set up a separate document containing our
[contribution guidelines](CONTRIBUTING.md).

Thank you for being involved! :heart_eyes:

## Authors & contributors

The original setup of this repository is by [Franck Nijhof][frenck].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## We have got some Hass.io add-ons for you

Want some more functionality to your Hass.io Home Assistant instance?

We have created multiple add-ons for Hass.io. For a full list, check out
our [GitHub Repository][repository].

## License

MIT License

Copyright (c) 2019 Franck Nijhof

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[buymeacoffee-shield]: https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg
[buymeacoffee]: https://www.buymeacoffee.com/frenck
[commits-shield]: https://img.shields.io/github/commit-activity/y/hassio-addons/addon-adb.svg
[commits]: https://github.com/hassio-addons/addon-adb/commits/master
[contributors]: https://github.com/hassio-addons/addon-adb/graphs/contributors
[discord-ha]: https://discord.gg/c5DvZ4e
[discord-shield]: https://img.shields.io/discord/478094546522079232.svg
[discord]: https://discord.me/hassioaddons
[dockerhub]: https://hub.docker.com/r/hassioaddons/adb
[forum-shield]: https://img.shields.io/badge/community-forum-brightgreen.svg
[forum]: https://community.home-assistant.io/?u=frenck
[frenck]: https://github.com/frenck
[gitlabci-shield]: https://gitlab.com/hassio-addons/addon-adb/badges/master/pipeline.svg
[gitlabci]: https://gitlab.com/hassio-addons/addon-adb/pipelines
[home-assistant]: https://home-assistant.io
[i386-shield]: https://img.shields.io/badge/i386-yes-green.svg
[issue]: https://github.com/hassio-addons/addon-adb/issues
[keepchangelog]: http://keepachangelog.com/en/1.0.0/
[layers-shield]: https://images.microbadger.com/badges/image/hassioaddons/adb.svg
[license-shield]: https://img.shields.io/github/license/hassio-addons/addon-adb.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2019.svg
[microbadger]: https://microbadger.com/images/hassioaddons/adb
[patreon-shield]: https://www.frenck.nl/images/patreon.png
[patreon]: https://www.patreon.com/frenck
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[pulls-shield]: https://img.shields.io/docker/pulls/hassioaddons/adb.svg
[reddit]: https://reddit.com/r/homeassistant
[releases-shield]: https://img.shields.io/github/release/hassio-addons/addon-adb.svg
[releases]: https://github.com/hassio-addons/addon-adb/releases
[repository]: https://github.com/hassio-addons/repository
[semver]: http://semver.org/spec/v2.0.0.htm
