# openSUSE-scripts 🦎
This repository contains various installation and setup scripts for **openSUSE Tumbleweed**.

**Note:** All scripts must be run as **root**.

## Information:
---
- **suse_rocm_radeon.sh**
> Performs a lightweight **ROCm** installation for **Radeon GPUs**.
---
- **suse_rusticl_radeon.sh**
> Installs and configures **Rusticl** for **Radeon GPUs**.
---
- **suse_modern_gnome.sh**
> This script creates a modern **GNOME** experience by removing obsolete packages and replacing legacy apps with their newer equivalants. It is intended to be used on a fresh installation with online repositories enabled. You must install a web browser via **Flatpak** after the first boot. For example:
> ```
> flatpak install flathub-beta org.mozilla.firefox
> ```
> Also includes [zypper-unjammed](https://github.com/makesourcenotcode/zypper-unjammed), and sets up an alias for zypper-autoremove.
> - <img src="images/screenshot_appmenu.png" alt="" width="65%" align="center">
> - <img src="images/screenshot_appmenu_folders.png" alt="" width="65%" align="center">
   
---
