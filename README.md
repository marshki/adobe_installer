Adobe Installer

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/a9aa65d594984faa8aaab18c93ba71e9)](https://www.codacy.com/app/marshki/adobe_installer?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=marshki/adobe_installer&amp;utm_campaign=Badge_Grade)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/hyperium/hyper/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![Open Source Love svg3](https://badges.frapsoft.com/os/v3/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/) 

Bash script to retrieve, unzip, install, and cleanup a subset of [Adobe's Creative Cloud](https://www.adobe.com/creativecloud.html?promoid=NGWGRLB2&mv=other) software.

Open to members of New York University's: [Center for Brain Imaging](http://cbi.nyu.edu), [Center for Neural Science](http://www.cns.nyu.edu), 
and [Department of Psychology](http://www.psych.nyu.edu/psychology.html) on the Meyer network. 

Written and tested to run on currently-supported versions of Mac OS X. 

## Getting Started 

__Pre-flight checklist__ (the script will check for the following conditions): 

  * root privileges  

  * adeqaute free disk space (10 GBs)

  * [curl](https://curl.haxx.se/docs/manpage.html)

  * access to the Meyer network.  

__Liftoff:__

Grab the script from `/src` in this repository, then as root, call the script: 

`bash adobe_installer.sh`. From there, follow the on-screen prompt: 

![ALT text](https://github.com/marshki/adobe_installer/blob/master/docs/adobe_install_menu.png "menu"). 

## TODO 

- [ ] Option to install all packages and run serializer? 
 
- [ ] Code review. Refactor where needed. 

## History 
v.0.3 2018.05.12

## License 
[License](https://github.com/marshki/adobe_installer/blob/master/LICENSE)
