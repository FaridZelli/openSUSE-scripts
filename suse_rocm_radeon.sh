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
read -p "This script will install and configure ROCm on your system. Do you want to continue? (Y/N) " ANSWER
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
echo -e "--------------------
\033[32mIt's time to reboot!\033[0m
--------------------"
