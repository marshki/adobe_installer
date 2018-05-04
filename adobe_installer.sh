#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

### Adobe installer v.0.1 for OS X. ###

ADOBE_ACROBAT="http://localweb.cns.nyu.edu/cc-2018-mac/mac-acrobatdc-spr18.zip"

ADOBE_ILLUSTRATOR="http://localweb.cns.nyu.edu/cc-2018-mac/mac-illustrator-spr18.zip"

ADOBE_PHOTOSHOP="http://localweb.cns.nyu.edu/cc-2018-mac/mac-photoshop-spr18.zip"

LOCAL_WEB="128.122.112.23"

### Sanity checks. ###

# Is current UID 0? If not, exit.

root_check () {
  if [ "$EUID" -ne "0" ] ; then
    printf "%s\n" "Error: root privileges are required to continue. Exiting." >&2
    exit 1
fi
}

# Is there adequate disk space in "/Applications"? If not, exit.

check_disk_space () {
  if [ $(df -Hl /Applications |awk 'FNR == 2 {print $4}' |sed 's/G//') -le 10 ]; then
    printf "%s\n" "Error: Not enough free disk space. Exiting" >&2
    exit 1
fi
}

# Is curl installed? If not, exit. (Curl ships with OS X, but let's check).

curl_check () {
  if ! [ -x "$(command -v curl 2>/dev/null)" ]; then
    printf "%s\n" "Error: curl is not installed. Exiting."  >&2
    exit 1
fi
}

# Is CNS local web available? If not, exit.

ping_local_web () {
  printf "%s\n" "Pinging CNS local web..."

  if ping -c 1 "$LOCAL_WEB" &> /dev/null; then
    printf "%s\n" "CNS local web IS reachable. Continuing..."
  else
    printf "%s\n" "Error: CNS local web IS NOT reachable. Exiting." >&2
    exit 1
 fi
}

### Acrobat ###

# Download Acrobat .zip to /Applications.

get_acrobat () {
  printf "%s\n" "Retrieving Acrobat insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ACROBAT" --output /Applications/acrobat.zip
}

# Unzip acrobat.zip to /Applications.

unzip_acrobat () {
  printf "%s\n" "Unzipping Acrobat to /Applications..."

  unzip /Applications/acrobat.zip -d /Applications
}

# Run Acrobat installer.

install_acrobat () {
  printf "%s\n" "Installing Acrobat..."

  installer -pkg /Applications/mac-acrobatdc-spr18/Build/mac-acrobatdc-spr18_Install.pkg -target /
}

# Remove Acrobat .zip file and installer.

remove_acrobat_zip () {
  printf "%s\n" "Removing acrobat.zip and mac-acrobat-spr18..."

  rm -rv /Applications/{acrobat.zip,mac-acrobatdc-spr18}
}

### Illustrator ###

# Download Illustrator .zip to /Applications

get_illustrator () {
  printf "%s\n" "Retrieving Illustrator insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ILLUSTRATOR" --output /Applications/illustrator.zip
}

# Unzip Illustrator to /Applications

unzip_illustrator () {
  printf "%s\n" "Unzipping Illustrator to /Applications..."

  unzip /Applications/illustrator.zip -d /Applications
}

# Run Illustrator installer.

install_illustrator () {
  printf "%s\n" "Installing Illustrator..."

  installer -pkg /Applications/mac-illustrator-spr18/Build/mac-illustrator-spr18_Install.pkg -target /
}

# Remove Illustrator .zip file and installer.

remove_illustrator_zip () {
  printf "%s\n" "Removing illustrator.zip and mac-illustrator-spr18."

  rm -rv /Applications/{illustrator.zip,mac-illustrator-spr18}
}

# Download Photoshop .zip to /Applications

get_photoshop () {

  printf "%s\n" "Retrieving Photoshop insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_PHOTOSHOP" --output /Applications/photoshop.zip
}

# Unzip Photoshop to /Applications

unzip_photoshop () {
  printf "%s\n" "Unzipping Photoshop to /Applications..."

  unzip /Applications/photoshop.zip -d /Applications
}

# Run Illustrator installer.

install_photoshop () {
  printf "%s\n" "Installing Photoshop..."

  installer -pkg /Applications/mac-photoshop-spr18/Build/mac-photoshop-spr18_Install.pkg -target /
}

# Remove Photoshop .zip file and installer.

remove_photoshop_zip () {
  printf "%s\n" "Removing photoshop.zip and mac-photoshop-spr18."

  rm -rv /Applications/{photoshop.zip,mac-photoshop-spr18}
}

# Main

sanity_checks () {
  root_check
  check_disk_space
  curl_check
  ping_local_web
}

acrobat () {
  get_acrobat
  unzip_acrobat
  install_acrobat
  remove_acrobat_zip
}

illustrator () {
  get_illustrator
  unzip_illustrator
  install_illustrator
  remove_illustrator_zip
}

photoshop () {
  get_photoshop
  unzip_photoshop
  install_photoshop
  remove_photoshop_zip
}
#main "$@"
