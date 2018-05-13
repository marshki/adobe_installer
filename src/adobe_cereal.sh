#!/bin/bash
# mjk235 [at] nyu [dot] edu

##########################
#### Adobe Serializer ####
##########################

CEREAL="http://localweb.cns.nyu.edu/unixadmin/cc-mac/mac-licfile-fall17-new.zip"

# Retrieve .zip and place in /Applications 

function retrieve_cereal () {
  printf "%s\n" "Retrieving Adobe cereal..."
  curl --progress-bar --retry 3 --retry-delay 5 "$CEREAL" --output /Applications/cereal.zip
}

# Unzip .zip to /Applications

function unzip_cereal () {
	printf "%s\n" "Unzipping cereal to Applications..."
	unzip /Applications/cereal.zip -d /Applications
} 

# Change directory to serializer file 

function go_to_cereal () {
	printf "%s\n" "Changing dirs to cereal..."
	cd /Applications/mac-licfile-fall17-new
}

# Run serializer 

function serial_cereal {
	printf "%s\n" "Nom, nom, nom..."
	./AdobeSerialization
}

# Main 

main() {
	retrieve_cereal
	unzip_cereal
	go_to_cereal
	serial_cereal
}

main "$@"
