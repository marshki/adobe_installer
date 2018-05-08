#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

#### Por Examplo ####
# STOOGES=(Larry Moe Curly Shemp Joe)
# printf "%s\n" "$STOOGES[1]" 

#########################################
#### Adobe installer v.0.2 for OS X. ####
#########################################

###ARRAY_NAME=(NAME     "URL"                                                            name.zip    mac-name-spr18      mac-name-spr18_Install.pkg) ###

ADOBE_ACROBAT=(ACROBAT "http://localweb.cns.nyu.edu/cc-2018-mac/mac-acrobatdc-spr18.zip" acrobat.zip mac-acrobatdc-spr18 mac-acrobatdc-spr18_Install.pkg ) 

#################
#### INSTALL ####
#################

# Download .zip to /Applications.

get_installer() {
  printf "%s\n" "RETRIEVING ${ADOBE_ACROBAT[0]} INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 ${ADOBE_ACROBAT[1]} --output /Applications/${ADOBE_ACROBAT[2]}
}

# Unzip .zip to /Applications.

unzip_installer() {
  printf "%s\n" "UNZIPING ${ADOBE_ACROBAT[0]} TO /Applications..."

  unzip /Applications/${ADOBE_ACROBAT[2]} -d /Applications
}

# Run installer.

install_installer() {
  printf "%s\n" "INSTALLING ${ADOBE_ACROBAT[0]}..."

  installer -pkg /Applications/${ADOBE_ACROBAT[3]}/Build/${ADOBE_ACROBAT[4]} -target /
}

# Remove .zip file and installer.

remove_installer() {
  printf "%s\n" "REMOVING ${ADOBE_ACROBAT[2]} AND ${ADOBE_ACROBAT[3]}..."

  rm -rv /Applications/{${ADOBE_ACROBAT[2]},${ADOBE_ACROBAT[3]}}
}

run_installation() {
  get_installer 
  unzip_installer
  install_installer
  remove_installer
  #pause 
}

run_installation	
