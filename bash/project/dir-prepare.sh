#!/usr/bin/env bash

source $1/config.cfg

# ----------------------------------------------------------------------
# STEP. Pepare project directory for install
# ----------------------------------------------------------------------

sleep 0.5
echo -e "\n\e[7m       PREPARE PROJECT DIRECTORY FOR INSTALL (STEP 2/7)       \e[0m\n"

# Delete October CMS Starter Kit Git directory if exists
GIT_DIR=./.git
sleep 0.5
if [ -d "$GIT_DIR" ]; then
    rm -rf ./.git
    echo -e "\n\e[32m✓ Git directory was deleted.\e[0m\n"
else
    echo -e "\n\e[34m🛈  No Git directory to delete.\e[0m\n"
fi

# Prevent October CMS Starter Kit README from replacement
README_FILE="./README.md"
sleep 0.5
if [[ -e $README_FILE ]]; then
    mv ./README.md ./README.STARTERKIT.md
    echo -e "\n\e[32m✓ Backup of project README.md was created.\e[0m\n"
else
    echo -e "\n\e[38;5;166m⚠  No project README.md was a found for backup! Don't forget to add it later!\e[0m\n"
fi
