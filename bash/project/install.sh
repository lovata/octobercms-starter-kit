#!/usr/bin/env bash

# Get the path of the executable script
CFG_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CFG_PATH/config.cfg

# Call reusable functions
source $CFG_PATH/functions.sh

# ----------------------------------------------------------------------
# STEP. Check settings variables initialization
# ----------------------------------------------------------------------
echo -e "\n\e[7m          CHECK PROJECT SETTINGS (STEP 1/5)          \e[0m\n"

CFG_DIR=./bash/project
CFG_FILE=./bash/project/config.cfg
CFG_EXAMPLE_FILE=./bash/project/config.cfg.example
if [ -e $CFG_FILE ]; then

    # Define check status of config variables
    CHECK_PASSED=true

    # Check config variables for initialization
    sleep 0.5
    userMessage success "config.cfg file was found."
    echo -e "In case of errors or mistakes in project settings fix them in \e[3m./bash/project/config.cfg\e[0m.\n"
    for VARIABLE in PROJECT_NAME PROJECTS_DIR VIRTUALHOST_NAME DB_NAME DB_USER DB_PASSWORD DB_CHARACTER_SET DB_COLLATION OC_GIT_INSTALL THEME_DRAFT_INSTALL
    do
        if [ -n "${!VARIABLE}" ]; then
            echo -e "\e[32m✓ \e[3m$VARIABLE\e[0m is defined as \e[39m\e[3m${!VARIABLE}\e[0m"
        else
            echo -e "\e[31m❌ \e[3m$VARIABLE\e[0m is not defined!\e[0m"
            CHECK_PASSED=false
        fi
    done

    # Check the validity of all checks
    if $CHECK_PASSED; then
        sleep 0.5
        read -p $'\x0aDo you want to continue? [Y/n]\x0a' -n 1 -r

        # Confirm the start of the install
        if [[ $REPLY =~ ^[Yy]$ ]]; then

            # Pepare project directory for install
            bash $CFG_PATH/dir-prepare.sh $CFG_PATH

            # Install October CMS
            bash $CFG_PATH/october.sh $CFG_PATH

            # Install frontend build script
            bash $CFG_PATH/webpack.sh $CFG_PATH

        # Decline the start of the install
        elif [[ $REPLY =~ ^[n]$ ]]; then
            echo -e "\n\e[38;5;208m\e[7m          Installation canceled by user!          \e[0m\n"
        fi
    else
        sleep 0.5
        echo -e "\n\e[31m\e[7m          Installation canceled by script!           \n           Please, fix the errors above!             \e[0m\n"
    fi
else
    sleep 0.5
    cp $CFG_EXAMPLE_FILE $CFG_DIR/config.cfg
    if [ $? -eq 0 ]; then
        userMessage warning "config.cfg file was not found and was created from an example. It must be configured!"
    else
        userMessage error "config.cfg file was not found and can't be created from an example. Create and configure it manually!"
    fi
fi
