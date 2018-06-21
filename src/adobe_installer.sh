#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25
# v.0.3

#############################################################
#### Adobe installer on OS X.       			 ####
#### Requires: Root privileges; access to Meyer network; #### 
#### and adequate free disk space.                       ####  
#############################################################

LOCAL_WEB="128.122.112.23"

CEREAL="http://localweb.cns.nyu.edu/unixadmin/cc-mac/mac-licfile-fall17-new.zip"

# Arrays follow this structure: 
# ARRAY_NAME=(NAME "URL" name.zip mac-name-spr18 mac-name-spr18_Install.pkg)

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
  if [ $(df -lk /Applications |awk 'FNR == 2 {print $4}') -le 10485760]; then
    printf "%s\n" "ERROR: NOT ENOUGH FREE DISK SPACE. EXITING." >&2
    exit 1
fi
}

# Is curl installed? If not, exit. (Curl ships with OS X, but let's check).

curl_check() {
  if ! [ -x "$(command -v curl 2>/dev/null)" ]; then
    printf "%s\n" "ERROR: CURL IS NOT INSTALLED. EXITING."  >&2
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

# Wrapper function 

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
        printf "%s\n" "  4. RUN SERIALIZER"
	printf "%s\n" "  5. EXIT"
}

###################
#### Install-r #### 
###################

# Download .zip to /Applications.

get_installer() {
  printf "%s\n" "RETRIEVING $1 INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 $2 --output /Applications/$3
}

# Unzip .zip to /Applications.

unzip_installer() {
  printf "%s\n" "UNZIPING $1 TO /Applications..."

  unzip /Applications/$3 -d /Applications
}

# Run installer.

install_installer() {
  printf "%s\n" "INSTALLING $1..."

  installer -pkg /Applications/$4/Build/$5 -target /
}

# Remove .zip file and installer.

remove_installer() {
  printf "%s\n" "REMOVING $3 AND $4..."

  rm -rv /Applications/{$3,$4}
}

# Wrapper function

run_installation() {
  get_installer "$@"
  unzip_installer "$@"
  install_installer "$@"
  remove_installer "$@"
  pause
}

####################
#### Serializer ####
####################

# Retrieve .zip and place in /Applications 

retrieve_cereal () {
  printf "%s\n" "Retrieving Adobe cereal..."
  curl --progress-bar --retry 3 --retry-delay 5 "$CEREAL" --output /Applications/cereal.zip
}

# Unzip .zip to /Applications

unzip_cereal () {
	printf "%s\n" "Unzipping cereal to Applications..."
	unzip /Applications/cereal.zip -d /Applications
} 

# Change directory to serializer file 

go_to_cereal () {
	printf "%s\n" "Changing dirs to cereal..."
	cd /Applications/mac-licfile-fall17-new
}

# Run serializer 

serial_cereal () {
	printf "%s\n" "Doing the cereal thing..."
	./AdobeSerialization
}

# Remove .zip and serializer 

remove_cereal () {
	printf "%s\n" "Removing cereal. Nom, nom, nom..." 
	rm -rv /Applications/{cereal.zip,mac-licfile-fall17-new}
	printf "%s\n" "DONE."
 
} 

# Wrapper function 

run_serializer () {
  retrieve_cereal  
  unzip_cereal
  go_to_cereal
  serial_cereal
  remove_cereal
} 

####################
#### User Input ####
####################

#### Get input via the keyboard and make a decision using case...esac ####

read_input() {
    local c
    read -p "ENTER YOUR CHOICE [ 1-4 ]:  " c
    case $c in
        1) run_installation "${ADOBE_ACROBAT[@]}";;
        2) run_installation "${ADOBE_ILLUSTRATOR[@]}" ;;
        3) run_installation "${ADOBE_PHOTOSHOP[@]}" ;;
        4) run_serializer ;;
	5) printf "%s\n" "CIAO!"; exit 0 ;;
        *)
           printf "%s\n" "SELECT AN OPTION (1 to 5):  "

           pause
    esac
}

# Ignore CTRL+C, CTRL+Z and quit signals using the trap

trap '' SIGINT SIGQUIT SIGTSTP

##############
#### Main ####
##############

main () {

sanity_checks

  while true
  do
      clear
      show_menu
      read_input
  done
}
main "$@"
