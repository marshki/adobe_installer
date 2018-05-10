#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

#########################################
#### Adobe installer v.0.2 for OS X. ####
#########################################

# TODO:  

LOCAL_WEB="128.122.112.23"

ADOBE_ACROBAT=(
ACROBAT
"http://localweb.cns.nyu.edu/cc-2018-mac/mac-acrobatdc-spr18.zip"
acrobat.zip
mac-acrobatdc-spr18
mac-acrobatdc-spr18_Install.pkg 
)

ADOBE_ILLUSTRATOR=(
ILLUSTRATOR
"http://localweb.cns.nyu.edu/cc-2018-mac/mac-illustrator-spr18.zip"
illustrator.zip 
mac-illustrator-spr18
mac-illustrator-spr18_Install.pkg
)

ADOBE_PHOTOSHOP=(
PHOTOSHOP
"http://localweb.cns.nyu.edu/cc-2018-mac/mac-photoshop-spr18.zip"
photoshop.zip
mac-photoshop-spr18
mac-photoshop-spr18_Install.pkg
)

########################
#### Sanity checks  ####
########################

# Is current UID 0? If not, exit.

root_check() {
  if [ "$EUID" -ne "0" ] ; then
    printf "%s\n" "ERROR: ROOT PRIVILEGES ARE REQUIRED TO CONTINUE. EXITING." >&2
    exit 1
fi
}

# Is there adequate disk space in "/Applications"? If not, exit.

check_disk_space() {
  if [ $(df -Hl /Applications |awk 'FNR == 2 {print $4}' |sed 's/G//') -le 10 ]; then
    printf "%s\n" "ERROR: NOT ENOUGH FREE DISK SPACE. EXITING." >&2
    exit 1
fi
}

# Is curl installed? If not, exit. (Curl ships with OS X, but let's check).

curl_check() {
  if ! [ -x "$(command -v curl 2>/dev/null)" ]; then
    printf "%s\n" "ERROR: CURL: IS NOT INSTALLED. EXITING."  >&2
    exit 1
fi
}

# Is CNS local web available? If not, exit.

ping_local_web() {
  printf "%s\n" "PINGING CNS LOCAL WEB..."

  if ping -c 1 "$LOCAL_WEB" &> /dev/null; then
    printf "%s\n" "CNS LOCAL WEB IS REACHABLE. CONTINUING..."
  else
    printf "%s\n" "ERROR: CNS LOCAL WEB IS NOT REACHABLE. EXITING." >&2
    exit 1
 fi
}

sanity_checks() {
  root_check
  check_disk_space
  curl_check
  ping_local_web
}

######################
#### Display Menu ####
######################

# Display pause prompt. 
# Suspend processing of script; display message prompting user to press [Enter] key to continue. 
# $1-> Message (optional). 

function pause() {
    local message="$@"
    [ -z $message ] && message="INSTALL DONE. PRESS [Enter] KEY TO CONTINUE:  "
    read -p "$message" readEnterKey
}

# Display on-screen menu

function show_menu() {
    printf "%s\n" "------------------------------"
    printf "%s\n" "  ADOBE INSTALLER MAIN MENU   "
    printf "%s\n" "------------------------------"
        printf "%s\n" "  1. INSTALL ACROBAT DC"
        printf "%s\n" "  2. INSTALL ILLUSTRATOR"
        printf "%s\n" "  3. INSTALL PHOTOSHOP"
        printf "%s\n" "  4. EXIT"
}

#################
#### Acrobat ####
#################

# Download Acrobat .zip to /Applications.

get_acrobat() {
  printf "%s\n" "RETRIEVING ${ADOBE_ACROBAT[0]} INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 ${ADOBE_ACROBAT[1]}" --output /Applications/${ADOBE_ACROBAT[2]}
}

# Unzip acrobat.zip to /Applications.

unzip_acrobat() {
  printf "%s\n" "UNZIPING ${ADOBE_ACROBAT[0]} TO /Applications..."

  unzip /Applications/${ADOBE_ACROBAT[2]} -d /Applications
}

# Run Acrobat installer.

install_acrobat() {
  printf "%s\n" "INSTALLING ${ADOBE_ACROBAT[0]}..."

  installer -pkg /Applications/${ADOBE_ACROBAT[3]}/Build/${ADOBE_ACROBAT[4]} -target /
}

# Remove Acrobat .zip file and installer.

remove_acrobat_zip() {
  printf "%s\n" "REMOVING ${ADOBE_ACROBAT[2]} AND ${ADOBE_ACROBAT[3}..."

  rm -rv /Applications/{${ADOBE_ACROBAT[2]},${ADOBE_ACROBAT[3]}}
}

run_acrobat() {
  get_acrobat
  unzip_acrobat
  install_acrobat
  remove_acrobat_zip
  pause 
}

#####################
#### Illustrator ####
#####################

# Download Illustrator .zip to /Applications

get_illustrator() {
  printf "%s\n" "RETRIEVING ILLUSTRATOR INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ILLUSTRATOR" --output /Applications/illustrator.zip
}

# Unzip Illustrator to /Applications

unzip_illustrator() {
  printf "%s\n" "UNZIPPING ILLUSTRATOR TO /Applications..."

  unzip /Applications/illustrator.zip -d /Applications
}

# Run Illustrator installer.

install_illustrator() {
  printf "%s\n" "INSTALLING ILLUSTRATOR..."

  installer -pkg /Applications/mac-illustrator-spr18/Build/mac-illustrator-spr18_Install.pkg -target /
}

# Remove Illustrator .zip file and installer.

remove_illustrator_zip() {
  printf "%s\n" "REMOVING illustrator.zip AND mac-illustrator-spr18."

  rm -rv /Applications/{illustrator.zip,mac-illustrator-spr18}
}

run_illustrator() {
  get_illustrator
  unzip_illustrator
  install_illustrator
  remove_illustrator_zip
  pause 
}

###################
#### Photoshop ####
###################

# Download Photoshop .zip to /Applications

get_photoshop() {
  printf "%s\n" "RETRIEVING PHOTOSHOP INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_PHOTOSHOP" --output /Applications/photoshop.zip
}

# Unzip Photoshop to /Applications

unzip_photoshop() {
  printf "%s\n" "UNZIPPING PHOTOSHOP TO /Applications..."

  unzip /Applications/photoshop.zip -d /Applications
}

# Run Photoshop installer.

install_photoshop() {
  printf "%s\n" "INSTALLING PHOTOSHOP..."

  installer -pkg /Applications/mac-photoshop-spr18/Build/mac-photoshop-spr18_Install.pkg -target /
}

# Remove Photoshop .zip file and installer.

remove_photoshop_zip() {
  printf "%s\n" "REMOVING photoshop.zip AND mac-photoshop-spr18."

  rm -rv /Applications/{photoshop.zip,mac-photoshop-spr18}
}

run_photoshop() {
  get_photoshop
  unzip_photoshop
  install_photoshop
  remove_photoshop_zip
  pause 
}

####################
#### User Input ####
####################

#### Get input via the keyboard and make a decision using case...esac ####

read_input() {
    local c
    read -p "ENTER YOUR CHOICE [ 1-4 ]:  " c
    case $c in
        1) run_acrobat ;;
        2) run_illustrator ;;
        3) run_photoshop ;;
        4) printf "%s\n" "CIAO!"; exit 0 ;;
        *)
           printf "%s\n" "SELECT AN OPTION (1 to 4):  "

           pause
    esac
}

# Ignore CTRL+C, CTRL+Z and quit signals using the trap ####

trap '' SIGINT SIGQUIT SIGTSTP

##############
#### Main ####
##############

sanity_checks

main () {

  while true
  do
      clear
      show_menu
      read_input
  done
}
main "$@"
