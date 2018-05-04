#!/bin/bash
# Test menu 

#### Display pause prompt ####
# Suspend processing of script; display message prompting user to press [Enter] key to continue
# $1-> Message (optional)

function pause() {
    local message="$@"
    [ -z $message ] && message="Press [Enter] key to continue:  "
    read -p "$message" readEnterKey            
}

#### Display on-screen menu ####

function show_menu() {
    date
    printf "%s\n" "------------------------------"
    printf "%s\n" "  Adobe Installer             " 
    printf "%s\n" "  Main Menu                   "
    printf "%s\n" "------------------------------"
        printf "%s\n" "  1. ACROBAT DC" 
        printf "%s\n" "  2. ILLUSTRATOR"
        printf "%s\n" "  3. PHOTOSHOP"
	printf "%s\n" "  4. EXIT"
}


#### Get input via the keyboard and make a decision using case...esac ####

function read_input() {
    local c
    read -p "Enter your choice [ 1-4 ]:  " c
    case $c in
        1) adobe ;;
        2) illusrator ;;
        3) photoshop ;;
        4) printf "%s\n" "Ciao!"; exit 0 ;;
        *)
           printf "%s\n" "Select an Option (1 to 4):  "

           pause
    esac 
}

gnore CTRL+C, CTRL+Z and quit signals using the trap ####

trap '' SIGINT SIGQUIT SIGTSTP
