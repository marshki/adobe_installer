#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

#########################################
#### Adobe installer v.0.2 for OS X. ####
#########################################

ADOBE_ACROBAT=(
ACROBAT
"http://localweb.cns.nyu.edu/cc-2018-mac/mac-acrobatdc-spr18.zip"
acrobat.zip
mac-acrobatdc-spr18
mac-acrobatdc-spr18_Install.pkg 
)

#################
#### INSTALL ####
#################

# Download .zip to /Applications.

get_installer() {
  printf "%s\n" "RETRIEVING $0 INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 $1 --output /Applications/$3"
}

# Unzip .zip to /Applications.

unzip_installer() {
  printf "%s\n" "UNZIPING $0 TO /Applications..."

  unzip /Applications/$2 -d /Applications
}

# Run installer.

install_installer() {
  printf "%s\n" "INSTALLING $0..."

  installer -pkg /Applications/$3/Build/$4 -target /
}

# Remove .zip file and installer.

remove_installer() {
  printf "%s\n" "REMOVING $2 AND $3..."

  rm -rv /Applications/{$2,$3}
}

run_installation() {
  get_installer "$@"
  unzip_installer "$@"
  install_installer "$@"
  remove_installer "$@"
  #pause
}

run_installation "${ADOBE_ACROBAT[@]}"
