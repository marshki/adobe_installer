#!/bin/bash
# mjk235 [at] nyu [dot] edu

# Retrieve Adobe serializer --> Unzip --> Change dir to location of serializer --> Run
# Need to be on NYU's LAN 

CEREAL="http://localweb.cns.nyu.edu/unixadmin/cc-mac/mac-licfile-fall17-new.zip"

function retrieve_cereal () {
  printf "%s\n" "Retrieving Adobe serializer..."
  curl --progress-bar --retry 3 --retry-delay 5 "$CEREAL" --output cereal.zip
}

function unzip_cereal () {
	printf "%s\n" "Unzipping..."
	unzip cereal.zip
} 

function goto_cereal () {
	printf "%s\n" "Changing dirs to cereal..."
	cd mac-licfile-fall17-new
}

function serial_cereal {
	printf "%s\n" "Nom, nom, nom..."
	./AdobeSerialization
}

main() {
	retrieve_cereal
	unzip_cereal
	goto_cereal
	serial_cereal
}

main "$@"
