#!/bin/bash
# mjk235 [at] nyu [dot] edu

##########################
#### Adobe Serializer ####
##########################

CEREAL="http://localweb.cns.nyu.edu/unixadmin/cc-mac/mac-licfile-fall17-new.zip"

# Retrieve serializer .zip 

function retrieve_cereal () {
  printf "%s\n" "Retrieving Adobe serializer..."
  curl --progress-bar --retry 3 --retry-delay 5 "$CEREAL" --output cereal.zip
}

# Unzip .zip 

function unzip_cereal () {
	printf "%s\n" "Unzipping..."
	unzip cereal.zip
} 

# Change directory to serializer file 

function goto_cereal () {
	printf "%s\n" "Changing dirs to cereal..."
	cd mac-licfile-fall17-new
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
	goto_cereal
	serial_cereal
}

main "$@"
