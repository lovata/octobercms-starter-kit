#!/usr/bin/env bash

source $1/config.cfg
source $1/functions.sh

# ----------------------------------------------------------------------
# STEP. Pepare project directory for install
# ----------------------------------------------------------------------

sleep 0.5
echo -e "\n\e[7m       PREPARE PROJECT DIRECTORY FOR INSTALL (STEP 2/5)       \e[0m\n"

# Delete October CMS Starter Kit Git directory if exists
GIT_DIR=./.git
sleep 0.5
if [ -d "$GIT_DIR" ]; then
    rm -rf ./.git
    userMessage success "Git directory was deleted."
else
    userMessage info "No Git directory to delete."
fi