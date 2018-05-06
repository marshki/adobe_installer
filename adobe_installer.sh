#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

#########################################
#### Adobe installer v.0.2 for OS X. ####
#########################################

ADOBE_ACROBAT="http://localweb.cns.nyu.edu/cc-2018-mac/mac-acrobatdc-spr18.zip"

ADOBE_ILLUSTRATOR="http://localweb.cns.nyu.edu/cc-2018-mac/mac-illustrator-spr18.zip"

ADOBE_PHOTOSHOP="http://localweb.cns.nyu.edu/cc-2018-mac/mac-photoshop-spr18.zip"

LOCAL_WEB="128.122.112.23"

########################
#### Sanity checks. ####
########################

# Is current UID 0? If not, exit.

root_check() {
  if [ "$EUID" -ne "0" ] ; then
    printf "%s\n" "Error: root privileges are required to continue. Exiting." >&2
    exit 1
fi
}

# Is there adequate disk space in "/Applications"? If not, exit.

check_disk_space() {
  if [ $(df -Hl /Applications |awk 'FNR == 2 {print $4}' |sed 's/G//') -le 10 ]; then
    printf "%s\n" "Error: Not enough free disk space. Exiting" >&2
    exit 1
fi
}

# Is curl installed? If not, exit. (Curl ships with OS X, but let's check).

curl_check() {
  if ! [ -x "$(command -v curl 2>/dev/null)" ]; then
    printf "%s\n" "Error: curl is not installed. Exiting."  >&2
    exit 1
fi
}

# Is CNS local web available? If not, exit.

ping_local_web() {
  printf "%s\n" "Pinging CNS local web..."

  if ping -c 1 "$LOCAL_WEB" &> /dev/null; then
    printf "%s\n" "CNS local web IS reachable. Continuing..."
  else
    printf "%s\n" "Error: CNS local web IS NOT reachable. Exiting." >&2
    exit 1
 fi
}

sanity_checks() {
  root_check
  check_disk_space
  curl_check
  ping_local_web
}

##############
#### Menu ####
##############

# Display pause prompt
# Suspend processing of script; display message prompting user to press [Enter] key to continue
# $1-> Message (optional)

function pause() {
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue:  "
    read -p "$message" readEnterKey
}

# Display on-screen menu

function show_menu() {
    date
    printf "%s\n" "------------------------------"
    printf "%s\n" "  Adobe Installer             "
    printf "%s\n" "  Main Menu                   "
    printf "%s\n" "------------------------------"
        printf "%s\n" "  1. INSTALL ACROBAT DC"
        printf "%s\n" "  2. INSTALL ILLUSTRATOR"
        printf "%s\n" "  3. INSTALL PHOTOSHOP"
        printf "%s\n" "  4. EXIT PROGRAM"
}

#################
#### Acrobat ####
#################

# Download Acrobat .zip to /Applications.

get_acrobat() {
  printf "%s\n" "Retrieving Acrobat insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ACROBAT" --output /Applications/acrobat.zip
}

# Unzip acrobat.zip to /Applications.

unzip_acrobat() {
  printf "%s\n" "Unzipping Acrobat to /Applications..."

  unzip /Applications/acrobat.zip -d /Applications
}

# Run Acrobat installer.

install_acrobat() {
  printf "%s\n" "Installing Acrobat..."

  installer -pkg /Applications/mac-acrobatdc-spr18/Build/mac-acrobatdc-spr18_Install.pkg -target /
}

# Remove Acrobat .zip file and installer.

remove_acrobat_zip() {
  printf "%s\n" "Removing acrobat.zip and mac-acrobat-spr18..."

  rm -rv /Applications/{acrobat.zip,mac-acrobatdc-spr18}
}

run_acrobat() {
  get_acrobat
  unzip_acrobat
  install_acrobat
  remove_acrobat_zip
}

#####################
#### Illustrator ####
#####################

# Download Illustrator .zip to /Applications

get_illustrator() {
  printf "%s\n" "Retrieving Illustrator insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_ILLUSTRATOR" --output /Applications/illustrator.zip
}

# Unzip Illustrator to /Applications

unzip_illustrator() {
  printf "%s\n" "Unzipping Illustrator to /Applications..."

  unzip /Applications/illustrator.zip -d /Applications
}

# Run Illustrator installer.

install_illustrator() {
  printf "%s\n" "Installing Illustrator..."

  installer -pkg /Applications/mac-illustrator-spr18/Build/mac-illustrator-spr18_Install.pkg -target /
}

# Remove Illustrator .zip file and installer.

remove_illustrator_zip() {
  printf "%s\n" "Removing illustrator.zip and mac-illustrator-spr18."

  rm -rv /Applications/{illustrator.zip,mac-illustrator-spr18}
}

run_illustrator() {
  get_illustrator
  unzip_illustrator
  install_illustrator
  remove_illustrator_zip
}

###################
#### Photoshop ####
###################

# Download Photoshop .zip to /Applications

get_photoshop() {
  printf "%s\n" "Retrieving Photoshop insaller..."

  curl --progress-bar --retry 3 --retry-delay 5 "$ADOBE_PHOTOSHOP" --output /Applications/photoshop.zip
}

# Unzip Photoshop to /Applications

unzip_photoshop() {
  printf "%s\n" "Unzipping Photoshop to /Applications..."

  unzip /Applications/photoshop.zip -d /Applications
}

# Run Photoshop installer.

install_photoshop() {
  printf "%s\n" "Installing Photoshop..."

  installer -pkg /Applications/mac-photoshop-spr18/Build/mac-photoshop-spr18_Install.pkg -target /
}

# Remove Photoshop .zip file and installer.

remove_photoshop_zip() {
  printf "%s\n" "Removing photoshop.zip and mac-photoshop-spr18."

  rm -rv /Applications/{photoshop.zip,mac-photoshop-spr18}
}

run_photoshop() {
  get_photoshop
  unzip_photoshop
  install_photoshop
  remove_photoshop_zip
}

####################
#### User input ####
####################

#### Get input via the keyboard and make a decision using case...esac ####

read_input() {
    local c
    read -p "Enter your choice [ 1-4 ]:  " c
    case $c in
        1) run_acrobat ;;
        2) run_illustrator ;;
        3) run_photoshop ;;
        4) printf "%s\n" "Ciao!"; exit 0 ;;
        *)
           printf "%s\n" "Select an Option (1 to 4):  "

           pause
    esac
}

# Ignore CTRL+C, CTRL+Z and quit signals using the trap ####

trap '' SIGINT SIGQUIT SIGTSTP

##############
#### Main ####
##############

sanity_checks

while true
do
    clear
    show_menu
    read_input
done

#main "$@"
