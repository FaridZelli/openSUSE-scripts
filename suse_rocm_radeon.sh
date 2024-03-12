#! /bin/bash

# Script by Farid Zellipour
# https://github.com/FaridZelli

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
This script will install and configure ROCm on your system.
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

tee --append /etc/zypp/repos.d/rocm.repo <<EOF
[ROCm-6.0.2]
name=ROCm6.0.2
baseurl=https://repo.radeon.com/rocm/zyp/6.0.2/main
enabled=1
gpgcheck=1
gpgkey=https://repo.radeon.com/rocm/rocm.gpg.key
EOF

zypper refresh
zypper --gpg-auto-import-keys install rocm-opencl rocm-opencl-devel rocminfo rocm-smi-lib rocm-ocl-icd clinfo

# End of script
echo -e "
--------------------------------------------------
\033[32mIt's time to reboot!\033[0m
--------------------------------------------------"
