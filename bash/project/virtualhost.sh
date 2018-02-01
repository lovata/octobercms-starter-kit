#!/usr/bin/env bash

source $1/config.cfg
source $1/functions.sh

# ----------------------------------------------------------------------
# STEP. Install October CMS
# ----------------------------------------------------------------------

echo -e "\n\e[7m       CONFIGURING APACHE VIRTUALHOSTS (STEP 5/5)       \e[0m\n"

# Disable Apache default virtualhost
VHOST_FILE_DEFAULT_ENABLED=/etc/apache2/sites-enabled/000-default.conf
if [[ -e $VHOST_FILE_DEFAULT_ENABLED ]]; then
    # Disable Apache default virtualhost
    sudo a2dissite 000-default.conf
    if [ $? -eq 0 ]; then
        # Reload Apache
        sudo service apache2 reload
        if [ $? -eq 0 ]; then
            userMessage success "Apache default virtualhost was disabled."
        else
            userMessage warning "Apache default virtualhost was disabled but Apache can't reload! Reload it manually!"
        fi
    else
        userMessage error "Apache default virtualhost wasn't disabled! Disable it manually!"
    fi
else
    userMessage info "Apache default virtualhost is already disabled."
fi

# Check for existing Apache project virtualhost config
VHOST_FILE="/etc/apache2/sites-available/$VIRTUALHOST_NAME.conf"

if [[ -e $VHOST_FILE ]]; then
    # Delete existing Apache project virtualhost config
    sudo rm $VHOST_FILE
    if [ ! -e $VHOST_FILE ]; then
        # Create new Apache project virtualhost config
        vhostCreate
    else
        userMessage error "Can't delete existing Apache project virtualhost! Delete it manually and restart install process!"
    fi
else
    # Create new Apache project virtualhost config
    vhostCreate
fi

# Add local address to hosts
HOSTS_FILE=/etc/hosts
sudo sed -i "1i 127.0.0.1       $VIRTUALHOST_NAME" $HOSTS_FILE
if [ $? -eq 0 ]; then
    userMessage success "Project local URL was added to hosts."
else
    userMessage warning "Project local URL wasn't added to hosts. Add it manually!"
fi
