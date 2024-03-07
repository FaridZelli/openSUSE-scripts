#! /bin/bash

# Check the current user
USER=$(whoami)
if [ "$USER" == "root" ]; then
  # Welcome text
  echo -e "\033[32mYou are logged in as root.\033[0m"
else
  # Non-root user detected
  echo -e "\033[31mATTENTION:\033[0m \033[33mYou do not seem to be logged in as root!\033[0m"
fi
# Ask to procede with the rest of the script
read -p "This script will reconfigure your openSUSE GNOME environment.
I am not liable for any damage or data loss that may occur.
Do you want to continue? (Y/N) " ANSWER
case $ANSWER in
  [Yy]* ) 
    # Procede with the rest of the script
    echo "Starting..."
    ;;
  * )
    # Stop the script for any other input
    echo "Stopping..."
    exit 1
    ;;
esac

# Removing web_browser providers (zypper se --provides web_browser)
zypper rm -u chromium elinks falkon links lynx MozillaFirefox seamonkey ungoogled-chromium w3m
zypper al chromium elinks falkon links lynx MozillaFirefox seamonkey ungoogled-chromium w3m

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
grep -qF 'alias zypper-autoremove="/root/.zypper-unjammed autoremove"' /root/.bashrc || echo 'alias zypper-autoremove="/root/.zypper-unjammed autoremove"' >> /root/.bashrc

# End of script
echo -e "--------------------
\033[32mIt's time to reboot!\033[0m
--------------------"
