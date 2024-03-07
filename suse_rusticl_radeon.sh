#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli

# Check the current user
USER=$(whoami)
if [ "$USER" == "root" ]; then
  # Welcome text
  echo -e "\033[32mYou are logged in as root.\033[0m"
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

zypper refresh
zypper in Mesa-libRusticlOpenCL clinfo

echo -e "
--------------------------------------------------
\033[33mDone! Now exit root and run the following command as the primary user:\033[0m
mkdir ~/.config/environment.d && echo "RUSTICL_ENABLE=radeonsi" > ~/.config/environment.d/rusticl.conf
--------------------------------------------------"
