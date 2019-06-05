#!/bin/bash
# mjk235 [at] nyu [dot] edu --2018.04.25

#====================================================
# Adobe install & serialize on OS X.       	         
# Requires: Root privileges; access to Meyer network; 
# and adequate free disk space.                        
#====================================================

LOCAL_WEB="http://localweb.cns.nyu.edu/mac/.local/acrobat.tgz"

CEREAL="http://localweb.cns.nyu.edu/unixadmin/cc-mac/mac-licfile-fall17-new.zip"

# Arrays follow this structure: 
# ARRAY_NAME=(NAME "URL" name.tgz mac-name-spr18 mac-name-spr18_Install.pkg)

ADOBE_ACROBAT=(
ACROBAT
"http://localweb.cns.nyu.edu/mac/.local/acrobat.tgz" 
acrobat.tgz
mac-acrobatdc-spr18
mac-acrobatdc-spr18_Install.pkg
)

ADOBE_ILLUSTRATOR=(
ILLUSTRATOR
"http://localweb.cns.nyu.edu/mac/.local/illustrator.tgz" 
illustrator.tgz
mac-illustrator-spr18
mac-illustrator-spr18_Install.pkg
)

ADOBE_PHOTOSHOP=(
PHOTOSHOP
"http://localweb.cns.nyu.edu/mac/.local/photoshop.tgz"
photoshop.tgz
mac-photoshop-spr18
mac-photoshop-spr18_Install.pkg
)

#==============
# Sanity checks
#==============

# Is current UID 0? If not, exit.

root_check() {
  if [ "$EUID" -ne "0" ] ; then
    printf "%s\\n" "ERROR: ROOT PRIVILEGES ARE REQUIRED TO CONTINUE. EXITING." >&2
    exit 1
fi
}

# Is there adequate disk space in "/Applications"? If not, exit.

check_disk_space() {
  if [ "$(df -lk /Applications |awk 'FNR == 2 {print $4}')" -le 10485760 ]; then
    printf "%s\\n" "ERROR: NOT ENOUGH FREE DISK SPACE. EXITING." >&2
    exit 1
fi
}

# Is curl installed? If not, exit. (Curl ships with OS X, but let's check).

curl_check() {
  if ! [ -x "$(command -v curl 2>/dev/null)" ]; then
    printf "%s\\n" "ERROR: CURL IS NOT INSTALLED. EXITING."  >&2
    exit 1
fi
}

# Is CNS local web available? If not, exit.

local_web_check() { 
  local status_code
  status_code=$(curl --output /dev/null --silent --head --write-out '%{http_code}\n' "$LOCAL_WEB")

  if [ "$status_code" -ne "200" ] ; then 
    printf "%s\\n" "ERROR: CNS LOCAL WEB IS NOT REACHABLE. EXITING." >&2
    exit 1 

  else 
    printf "%s\\n" "CNS LOCAL WEB IS REACHABLE. CONTINUING..."
fi
} 

# Wrapper function 

sanity_checks() {
  root_check
  check_disk_space
  curl_check
  local_web_check
}

#=============
# Display Menu
#=============

# Display pause prompt.
# Suspend processing of script; display message prompting user to press [Enter] key to continue.
# $1-> Message (optional).

pause() {
    local message="$*"
    [ -z "$message" ] && message="KAPOW! PROCESS DONE. PRESS [Enter] KEY TO CONTINUE:  "
    read -rp "$message" 
}

# Display on-screen menu

show_menu() {
    printf "%s\\n" "------------------------------"
    printf "%s\\n" "  ADOBE INSTALLER MAIN MENU   "
    printf "%s\\n" "------------------------------"
        printf "%s\\n" "  1. INSTALL ACROBAT DC"
        printf "%s\\n" "  2. INSTALL ILLUSTRATOR"
        printf "%s\\n" "  3. INSTALL PHOTOSHOP"
        printf "%s\\n" "  4. RUN SERIALIZER"
	printf "%s\\n" "  5. INSTALL ALL"
        printf "%s\\n" "  6. EXIT"
}

#==========
# Install-r 
#==========

# Download .tgz to /Applications.

get_tar() {
  printf "%s\\n" "RETRIEVING $1 INSTALLER..."

  curl --progress-bar --retry 3 --retry-delay 5 --keepalive-time 60 --continue-at - "$2" --output /Applications/"$3"
}

# Unpack tarball to /Applications, which installs Adobe app

untar_tar() {
  printf "%s\\n" "UNTARRING $1 TO /Applications..."

  tar --extract --gzip -v --file=/Applications/"$3" --directory=/Applications
}

# Run installer. 

install_installer() {
  printf "%s\\n" "INSTALLING $1..."

  installer -pkg /Applications/"$4"/Build/"$5" -target /
}

# Remove .tgz file and installer.

remove_installer() {
  printf "%s\\n" "REMOVING $3..."

  rm -rv /Applications/{"$3","$4"}
}

# Wrapper functions

run_installation() {
  get_tar "$@"
  untar_tar "$@"
  install_installer "$@"
  remove_installer "$@"
  pause 
}

run_installation_no_pause() {
  get_tar "$@"
  untar_tar "$@"
  install_installer "$@"
  remove_installer "$@"
}

#===========
# Serializer
#===========

# Retrieve .zip and place in /Applications 

retrieve_cereal () {
  printf "%s\\n" "RETRIEVING ADOBE CEREAL..."
  curl --progress-bar --retry 3 --retry-delay 5 --keepalive-time 60 --continue-at - "$CEREAL" --output /Applications/cereal.zip
}

# Unzip .zip to /Applications

unzip_cereal () {
	printf "%s\\n" "UNZIPPING CEREAL TO /Applications..." 
	unzip /Applications/cereal.zip -d /Applications
} 

# Change directory to serializer file 

go_to_cereal () {
	printf "%s\\n" "CHANGING DIRS TO CEREAL..."
	cd /Applications/mac-licfile-fall17-new || exit
}

# Run serializer 

serial_cereal () {
	printf "%s\\n" "DOING THE CEREAL THING..."
	./AdobeSerialization
}

# Remove .zip and serializer 

remove_cereal () {
	printf "%s\\n" "REMOVING CEREAL. NOM, NOM, NOM..." 
	rm -rv /Applications/{cereal.zip,mac-licfile-fall17-new}
 
} 

# Wrapper function 

run_serializer () {
  retrieve_cereal  
  unzip_cereal
  go_to_cereal
  serial_cereal
  remove_cereal
  pause 
} 

#===========
# User Input
#=========== 

# Get input via the keyboard and make a decision using case...esac 

read_input() {
    local c
    read -rp "ENTER YOUR CHOICE [ 1-6 ]:  " c
    case $c in
        1) run_installation "${ADOBE_ACROBAT[@]}";;
        2) run_installation "${ADOBE_ILLUSTRATOR[@]}" ;;
        3) run_installation "${ADOBE_PHOTOSHOP[@]}" ;;
        4) run_serializer ;;
	5) run_installation_no_pause "${ADOBE_ACROBAT[@]}"; 
           run_installation_no_pause "${ADOBE_ILLUSTRATOR[@]}" ; 
           run_installation_no_pause "${ADOBE_PHOTOSHOP[@]}" ;;
        6) printf "%s\\n" "CIAO!"; exit 0 ;;
        *)
           printf "%s\\n" "SELECT AN OPTION (1 to 5):  "

           pause "$@"
    esac
}

#=====
# Main
#=====

main () {

sanity_checks

  while true
  do
      clear
      show_menu
      read_input "$@"
  done
}

main "$@"
