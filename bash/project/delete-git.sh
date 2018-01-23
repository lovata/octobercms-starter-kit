#!/usr/bin/env bash

sleep 0.5
echo
echo -e "\e[7m       DELETE STARTER KIT GIT FILES (STEP 2/7)       \e[0m"
echo

GIT_DIRECTORY=./.git
sleep 0.5
if [ -d "$GIT_DIRECTORY" ]; then
    rm -rf ./.git
    echo -e "\e[32m✓ OK!\e[0m"
else
    echo
    echo -e "\e[34m🛈  Nothing to delete!\e[0m"
    echo
fi
