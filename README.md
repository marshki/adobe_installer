# Adobe Installer

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a9aa65d594984faa8aaab18c93ba71e9)](https://www.codacy.com/app/marshki/adobe_installer?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/adobe_installer&amp;utm_campaign=Badge_Grade)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)](https://bitbucket.org/lbesson/ansi-colors)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/) 

**This repository is for archival purposes only.**

**NOTE:** NYU transitioned from serialized licensing to a subscription-based licensing model on 2019-11-30. 
Shared-device licesning (SDL) requires a valid NYU Net ID for authentication.

Bash script to retrieve, unzip, install, and cleanup a subset of [Adobe's Creative Cloud](https://www.adobe.com/creativecloud.html?promoid=NGWGRLB2&mv=other) software. There's also a serializer script which activates an installation.

Open to members of New York University's: [Center for Brain Imaging](http://cbi.nyu.edu), [Center for Neural Science](http://www.cns.nyu.edu), 
and [Department of Psychology](http://www.psych.nyu.edu/psychology.html) on the Meyer network.

Written and tested to run on currently-supported versions of macOS.

## E-Z Install

**masOS:**
`curl --remote-name https://raw.githubusercontent.com/marshki/adobe_installer/master/src/adobe_installer.sh && caffeinate sudo bash adobe_installer.sh`

## Getting Started

**For sysadmins who want to replicate this process**, we assume that you:

- [ ] are affiliated with an institution that has a valid license agreement with Adobe;

- [ ] can access a networked file server; and

- [ ] have an Adboe installer for `macOS' clients.

On your local client, compress the Adobe installer with, e.g.:

`zip -r mac-acrobatdc-spr18.zip acrobat`

and place the file on your web server for distribution.

**For sysadmin** AND **end users**:

__Pre-flight checklist__ (the script will check for the following conditions):

  * root privileges

  * adequate free disk space (10 GBs)

  * [curl](https://curl.haxx.se/docs/manpage.html)

  * access to the Meyer network.

__Liftoff:__

Grab the script from `/src` in this repository, then call the script (*[caffeinate](https://ss64.com/osx/caffeinate.html) will keep the computer awake during the installation*):

`caffeinate sudo bash adobe_installer.sh`. From there, follow the on-screen prompt:

![ALT text](https://github.com/marshki/adobe_installer/blob/master/docs/adobe_install_menu.png "menu").

## History

v.0.5 2019-12-10

## License 
[License](https://github.com/marshki/adobe_installer/blob/master/LICENSE)
