#!/usr/bin/env bash

source $1/config.cfg
source $1/functions.sh

# ----------------------------------------------------------------------
# STEP. Install frontend build scripts
# ----------------------------------------------------------------------
echo -e "\n\e[7m       INSTALL FRONTEND BUILD SCRIPTS (STEP 4/5)       \e[0m\n"
# Configure Webpack and NPM
sed -i "s/THEME_NAME/$PROJECT_NAME/g" ./webpack.config.babel.js ./package.json
if [ $? -eq 0 ]
then
    userMessage success "Webpack and NPM were configured."
else
    userMessage error "Webpack and NPM were not configured!"
fi

# Installing NPM packages
npm i
if [ $? -eq 0 ]
then
    userMessage success "NPM packages were installed."
else
    userMessage error "NPM packages were not installed!"
fi
