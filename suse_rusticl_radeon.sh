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
read -p "This script will install and configure Rusticl for Radeon on your system. Do you want to continue? (Y/N) " ANSWER
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

zypper refresh
zypper in Mesa-libRusticlOpenCL clinfo

echo -e "--------------------
\033[33mDone! Now exit root and run the following command as the primary user:\033[0m
mkdir ~/.config/environment.d && echo "RUSTICL_ENABLE=radeonsi" > ~/.config/environment.d/rusticl.conf
--------------------"
