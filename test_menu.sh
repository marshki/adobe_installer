#!/bin/bash

# WIP! Doesn't work correctly (yet). 

PS3=("Enter the number of the Adobe software you want to install: ")

ADOBE_INSTALLERS=(
"Acrobat_DC 1"
"Illustrator 2"
"Photoshop 3"
"Quit"
)

select opt in "$ADOBE_INSTALLERS"

do
    case $opt in
        "Acrobat_DC 1")
            printf "%sn" "You selected ACROBAT_DC"
            ;;
        " Illustrator 2")
            printf "%s\n" "You selected Illustrator 2"
            ;;
        "Photoshop 3")
            printf "%s\n" "You selected Photoshop 3"
            ;;
        "Quit")
            break
            ;;
        *) printf "%s\n" "Invalid Option";;
    esac
done













