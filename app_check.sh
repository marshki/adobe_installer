#!/bin/bash 
# Check if Acrobat installed before removing installers? Do we need this? Probably not.

confirm_acrobat () {

  if open -Ra "Adobe Acrobat" &> /dev/null; then
    printf "%s\n" "Adobe Acrobat installed succesffully."
  else
    printf "%s\n" "Error: Adobe Acrobat did not install successfully." >&2
    exit 1
fi
}
