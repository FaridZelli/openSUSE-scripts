#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli
# Last updated 2024-3-12 10:50 PM

# Check the current user
USER=$(whoami)
if [ "$USER" == "root" ]; then
  # Welcome text
  echo -e "
--------------------------------------------------
\033[32mYou are logged in as root.\033[0m
--------------------------------------------------"
else
  # Non-root user detected
  echo -e "
--------------------------------------------------
\033[33mWARNING: You do not seem to be logged in as root!\033[0m
--------------------------------------------------"
fi

# Ask whether to proceed
echo -e "
This script will reconfigure your \033[32mopenSUSE\033[0m \033[36mGNOME\033[0m environment.
I am not responsible for any damage or data loss that may occur.

\033[33mDo you wish to continue? (Y/N)\033[0m
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  [Yy]* ) 
    # Proceed with the rest of the script
    ;;
  * )
    # Stop the script for any other input
    echo "Stopping the script..."
    exit 1
    ;;
esac

# Ask whether to remove web browsers
echo -e "
\033[33mWould you like to remove all web browsers? (Recommended for Flatpak users)\033[0m

1) Yes, remove and lock all browsers
2) No, skip this step
0) Exit
"
# User input
read -p "Your choice:" ANSWER
# Read input
case $ANSWER in
  1 ) 
    # Removing web_browser providers (zypper se --provides web_browser)
    zypper rm -n -u chromium elinks falkon links lynx MozillaFirefox seamonkey ungoogled-chromium w3m
    zypper al chromium elinks falkon links lynx MozillaFirefox seamonkey ungoogled-chromium w3m
    ;;
  2 ) 
    # Proceed with the rest of the script
    echo "Skipping..."
    ;;
  0 ) 
    # Exit the script
    echo "Stopping the script..."
    exit 1
    ;;
  * )
    # Stop the script for any other input
    echo "Invalid input, stopping the script..."
    exit 1
    ;;
esac

# Removing patterns
zypper rm -u -t pattern gnome_games gnome_imaging gnome_office imaging office yast2_desktop yast2_server sw_management sw_management_gnome

# Removing unnecessary packages
zypper rm -u gnome-software gnome-packagekit gnome-terminal nautilus-extension-terminal gnome-music cheese evolution polari transmission-gtk vinagre tigervnc xterm xtermset libreoffice* icewm*

# Locking everything
zypper al -t pattern gnome_games gnome_imaging gnome_office imaging office yast2_desktop yast2_server sw_management sw_management_gnome
zypper al gnome-software gnome-packagekit gnome-terminal nautilus-extension-terminal gnome-music cheese evolution polari transmission-gtk vinagre tigervnc xterm xtermset

# Installing new packages
zypper in alsa flatpak gnome-console gnome-calendar gnome-sound-recorder loupe decibels

# Adding Flatpak remotes
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --if-not-exists flathub-beta https://dl.flathub.org/beta-repo/flathub-beta.flatpakrepo

# Adding zypper-unjammed to home directory
# https://github.com/makesourcenotcode/zypper-unjammed
curl -o /root/.zypper-unjammed https://raw.githubusercontent.com/makesourcenotcode/zypper-unjammed/main/zypper-unjammed
chmod +x /root/.zypper-unjammed
grep -qF 'alias zypper-unjammed="/root/.zypper-unjammed"' /root/.bashrc || echo 'alias zypper-unjammed="/root/.zypper-unjammed"' >> /root/.bashrc
grep -qF 'alias zypper-autoremove="/root/.zypper-unjammed autoremove"' /root/.bashrc || echo 'alias zypper-autoremove="/root/.zypper-unjammed autoremove"' >> /root/.bashrc

# End of script
echo -e "
--------------------------------------------------
\033[32mIt's time to reboot!\033[0m
--------------------------------------------------"
