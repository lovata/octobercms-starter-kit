#!/usr/bin/env bash

source $1/config.cfg
source $1/functions.sh

# ----------------------------------------------------------------------
# STEP. Install frontend build scripts
# ----------------------------------------------------------------------
echo -e "\n\e[7m       INSTALL FRONTEND BUILD SCRIPTS (STEP 4/7)       \e[0m\n"
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

# Backup October CMS README.md
mv ./README.md ./README.OCTOBER.md
if [ $? -eq 0 ]
then
    userMessage success "Backup of October CMS README.md was created."
else
    userMessage warning "Backup of October CMS README.md wasn't created!"
fi

# Restore project README.md
mv ./README.STARTERKIT.md ./README.md
if [ $? -eq 0 ]
then
    userMessage success "October CMS README.md was restored."
else
    userMessage warning "October CMS README.md wasn't restored! Don't forget to add it later!"
fi
