#!/usr/bin/env bash

# Getting the path of the executable script
CFG_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $CFG_PATH/config.cfg

# Checking settings variables initialization
echo
echo -e "\e[7m          CHECK PROJECT SETTINGS (STEP 1/7)          \e[0m"
echo

CHECK_PASSED=true

sleep 0.5
for VARIABLE in PROJECT_NAME PROJECTS_DIR VIRTUALHOST_NAME DB_NAME DB_USER DB_PASSWORD DB_CHARACTER_SET DB_COLLATION OCTOBER_GIT_INSTALL
do
    if [ -n "${!VARIABLE}" ]; then
        echo -e "\e[32m✓ \e[3m$VARIABLE is defined as \e[39m\e[3m${!VARIABLE}\e[0m"
    else
        # sleep 0.5
        echo -e "\e[31m❌ \e[3m$VARIABLE is not defined!\e[0m"
        CHECK_PASSED=false
    fi
done

# Checking the validity of all checks
if $CHECK_PASSED; then
    sleep 0.5
    echo
    read -p "Do you want to continue? [Y/n]" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then

        # Deleting October CMS Starter Kit Git files
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

        echo "Backuping README file of Starter kit…"
        mv ./README.md ./README.STARTERKIT.md

        bash $CFG_PATH/october.sh $CFG_PATH
        bash $CFG_PATH/webpack.sh $CFG_PATH

    elif [[ $REPLY =~ ^[n]$ ]]; then
        echo
        echo -e "\e[38;5;208m\e[7m          Installation canceled by user!          \e[0m"
        echo
    fi
else
    sleep 0.5
    echo
    echo -e "\e[31m\e[7m          Installation canceled by script!           \e[0m"
    echo -e "\e[31m\e[7m           Please, fix the errors above!             \e[0m"
    echo
fi
