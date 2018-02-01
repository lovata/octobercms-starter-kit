#!/usr/bin/env bash

# Standard user information message
function userMessage {
    case "$1" in
        success)
            echo -e "\n\e[32m✓ $2\e[0m\n"
            ;;
        warning)
            echo -e "\n\e[38;5;166m⚠ $2\e[0m\n"
            ;;
        error)
            echo -e "\n\e[31m❌ $2\e[0m\n"
            ;;
        info)
            echo -e "\n\e[34m🛈 $2\e[0m\n"
            ;;
    esac
}

# Generate Apache project virtualhost config
function vhostCreate {
    VHOST_DIR=/etc/apache2/sites-available
    # Generate Apache project virtualhost config
    sudo echo "<VirtualHost *:80>
        ServerName $VIRTUALHOST_NAME
        ServerAlias *.$VIRTUALHOST_NAME
        DocumentRoot $PROJECTS_DIR/$PROJECT_NAME/www
        <Directory $PROJECTS_DIR/$PROJECT_NAME/www/>
            Options Indexes FollowSymLinks
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>" >> ./$VIRTUALHOST_NAME.conf
    # Move Apache project virtualhost config to Apache directory
    sudo mv ./$VIRTUALHOST_NAME.conf $VHOST_DIR/$VIRTUALHOST_NAME.conf
    # Check for successful moving of Apache project virtualhost config
    if [[ -e $VHOST_FILE ]]; then
        VHOST_FILE_ENABLED=/etc/apache2/sites-enabled/$VIRTUALHOST_NAME.conf
        # Check for Apache project virtualhost config isn't enabled allready
        if [[ ! -e $VHOST_FILE_ENABLED ]]; then
            # Enable Apache project virtualhost config
            sudo a2ensite $VIRTUALHOST_NAME.conf
            if [ $? -eq 0 ]; then
                apacheReload
            else
                userMessage warning "Apache default virtualhost was disabled but Apache can't reload! Reload it manually!"
            fi
        else
            apacheReload
        fi
    else
        userMessage error "Apache project virtualhost wasn't created! Create and enable it manually and reload Apache!"
    fi
}

# Reload Apache
function apacheReload {
    sudo service apache2 reload
    if [ $? -eq 0 ]; then
        userMessage success "Apache project virtualhost was created and enabled."
    else
        userMessage error "Apache project virtualhost was created but wasn't enabled! Reload Apache manually!"
    fi
}

# Create example of the .env file
function envExampleCreate {
    # Check for existing .env.example
    ENV_EXAMPLE_FILE=.env.example
    if [[ -e $ENV_EXAMPLE_FILE ]]; then
        # Delete existing .env.example
        rm $ENV_EXAMPLE_FILE
        if [[ $? -ne 0 ]]; then
            userMessage warning "Can't delete existing '.env.example' file. Clear its content, copy content of the .env file and clear values for these variables: APP_ASSETS, DB_DATABASE, DB_PASSWORD!"
        fi
    fi

    # Copy .env as an example
    cp $ENV_FILE $ENV_EXAMPLE_FILE
    if [ $? -eq 0 ]; then
        # Add assets variable
        sed -i "1i APP_ASSETS=" $ENV_FILE
        if [ $? -eq 0 ]; then
            userMessage success "Example of the .env file was created '.env.example'."
        else
            userMessage warning "Example of the .env file was created as '.env.example' but 'APP_ASSETS=' wasn't added! Add it manually to the first line!"
        fi
    else
        userMessage warning "Example of the .env file wasn't created. Do it manually as '.env.example' and 'APP_ASSETS=' to the first line!"
    fi
}
