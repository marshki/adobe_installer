#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

### Adobe installer V.0.1 for OS X. ###

ADOBE_ACROBAT="http://localweb.cns.nyu.edu/cc-2018-mac/mac-acrobatdc-spr18.zip"

ADOBE_ILLUSTRATOR="http://localweb.cns.nyu.edu/cc-2018-mac/mac-illustrator-spr18.zip"

ADOBE_PHOTOSHOP="http://localweb.cns.nyu.edu/cc-2018-mac/mac-photoshop-spr18.zip"

LOCAL_WEB="128.122.112.23"


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

# Download Adobe DC .zip

get_acrobat () {

  printf "%s\n" "Retrieving Adobe Acrobat insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ACROBAT" --output /Applications/acrobat.zip
}

# Unzip acrobat.zip to Applications

unzip_acrobat () {

  printf "%s\n" "Unzipping to /Applications..."

  unzip /Applications/acrobat.zip -d /Applications
}

# Run installer

install_acrobat () {

  printf "%s\n" "Installing Acrobat..."

  installer -pkg /Applications/mac-acrobatdc-spr18/Build/mac-acrobatdc-spr18_Install.pkg -target /
}

# Check if Acrobat is installed

confirm_acrobat () {

  if open -Ra "Atom" &> /dev/null; then
    printf "%s\n" "Atom is installed. Woohoo!"
  else
    printf "%s\n" "Error: Atom is not installed. Zoinks!" >&2
fi
}

# Remove .zip file and installer

remove_zip () {

  printf "%s\n" "Removing Acrobat.zip and mac-acrobat-spr18."

  rm -rf acrobat.zip && rm -rf /Applications/mac-acrobatdc-spr18
}

# Download Adobe Illustrator zip
# get_illustrator () {
#  printf "%s\n" "Retrieving Adobe Acrobat insaller..."
#  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ILLUSTRATOR" --output illustrator.zip
#}

# Download Adobe Photoshop zip
# get_photoshop () {
#  printf "%s\n" "Retrieving Adobe Acrobat insaller..."
#  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_PHOTOSHOP" --output photoshop.zip
#}

# Main 

main () {
  root_check
  check_disk_space
  curl_check
  ping_local_web
  get_acrobat
  unzip_acrobat
  install_acrobat
  #confirm_acrobat
  remove_zip
}

main "$@"
