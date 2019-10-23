# Adobe Installer

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a9aa65d594984faa8aaab18c93ba71e9)](https://www.codacy.com/app/marshki/adobe_installer?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/adobe_installer&amp;utm_campaign=Badge_Grade)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/) 

Bash script to retrieve, unzip, install, and cleanup a subset of [Adobe's Creative Cloud](https://www.adobe.com/creativecloud.html?promoid=NGWGRLB2&mv=other) software.

Open to members of New York University's: [Center for Brain Imaging](http://cbi.nyu.edu), [Center for Neural Science](http://www.cns.nyu.edu), 
and [Department of Psychology](http://www.psych.nyu.edu/psychology.html) on the Meyer network. 

Written and tested to run on currently-supported versions of Mac OS X. 

**__On 11.30.2019, NYU will pull Adobe serializers, thereby rendering this script invalid.__**

## E-Z Install
**OS X:** 
`curl --remote-name https://raw.githubusercontent.com/marshki/adobe_installer/master/src/adobe_installer.sh && caffeinate sudo bash adobe_installer.sh` 

## Getting Started 

**For sysadmins who want to replicate this process**, we assume that you: 

- [ ] are affiliated with an institution that has a valid license agreement with Adobe; 

- [ ] can access a networked file server; and 

- [ ] have an Adboe installer for `Mac OS X' clients.

On your local client, zip up the Adobe installer with, e.g.: 

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
v.0.4 2019.06.08

## License 
[License](https://github.com/marshki/adobe_installer/blob/master/LICENSE)
