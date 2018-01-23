#!/usr/bin/env bash

sleep 0.5
echo
echo -e "\e[7m       BACKUP STARTER KIT README (STEP 3/7)       \e[0m"
echo
README_FILE="./README.md"
sleep 0.5
if [[ -e $README_FILE ]]; then
    mv ./README.md ./README.STARTERKIT.md
    echo
    echo -e "\e[32m✓ OK!\e[0m"
    echo
else
    echo
    echo -e "\e[34m🛈  Nothing to rename!\e[0m"
    echo
fi
