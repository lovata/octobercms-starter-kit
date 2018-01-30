#!/usr/bin/env bash

source $1/config.cfg

# ----------------------------------------------------------------------
# STEP. Install October CMS
# ----------------------------------------------------------------------

sleep 0.5

# Move October CMS source code from temporary directory and delete it
function moveSourceAndRemoveDir {
    shopt -s dotglob
    cp -r october/* ./
    rm -rf october/*
    shopt -u dotglob
    rmdir october

    if [ $? -eq 0 ]
    then
        echo -e "\n\e[32m✓ Source code temporary directory has been found and deleted!\e[0m\n"
    else
        echo -e "\n\e[34m🛈  No existing source code directory has been found. There's nothing to delete.\e[0m\n"
    fi
}

if [[ "$OC_GIT_INSTALL" = false ]]; then
    # Install source code with Composer and inform user
    echo -e "\n\e[7m       INSTALL OCTOBER CMS WITH COMPOSER (STEP 3/7)       \e[0m\n"
    composer create-project october/october:$OC_VERSION october

    if [ $? -eq 0 ]
    then
        echo -e "\n\e[32m✓ Composer package has been installed!\e[0m\n"
    else
        echo -e "\n\e[31m❌ \e[3mCan't install Composer package!\e[0m\n"
    fi

    # Move October CMS source code from temporary directory and delete it
    moveSourceAndRemoveDir
else
    echo -e "\n\e[7m       INSTALL OCTOBER CMS FROM GIT (STEP 4/7)       \e[0m\n"

    TEMP_DIR=./october

    # Delete temporary directory if existing
    if [ -d "$TEMP_DIR" ]; then
        rm -r $TEMP_DIR
        echo -e "\n\e[32m✓ Existing temporary directory has been found and deleted!\e[0m\n"
    else
        echo -e "\n\e[34m🛈  No existing temporary directory has been found. There's nothing to delete.\e[0m\n"
    fi

    # Clone source code from Git repository and inform user
    git clone git@github.com:octobercms/october.git october

    if [ $? -eq 0 ]
    then
        echo -e "\n\e[32m✓ Source code has been cloned from repository!\e[0m\n"
    else
        echo -e "\n\e[31m❌ \e[3mCan't clone source code from Git!\e[0m\n"
    fi

    # Delete from source code .git directory if existing
    SOURCE_CODE_GIT_DIR=october/.git
    sleep 0.5
    if [ -d "$SOURCE_CODE_GIT_DIR" ]; then
        sudo rm -r $SOURCE_CODE_GIT_DIR
        echo -e "\n\e[32m✓ Source code .git directory has been found and deleted!\e[0m\n"
    else
        echo -e "\n\e[34m🛈  No existing source code .git directory has been found. There's nothing to delete.\e[0m\n"
    fi

    # Move October CMS source code from temporary directory and delete it
    moveSourceAndRemoveDir

    # Install Composer dependencies
    composer install

    if [ $? -eq 0 ]
    then
        echo -e "\n\e[32m✓ Composer dependencies have been installed!\e[0m\n"
    else
        echo -e "\n\e[31m❌ \e[3mCan't install Composer dependencies!\e[0m\n"
    fi
fi

# Setup October CMS local environment
sleep 0.5
ENV_FILE=.env
ENV_SED_RESULT=true

function envSetup {
    sed -i "1i APP_ASSETS=dev" $ENV_FILE
    if [[ $? -ne 0 ]]; then
        ENV_SED_RESULT=false
    fi

    ENV_DATABASE="DB_DATABASE=database"
    ENV_DATABASE_SET="DB_DATABASE=$DB_NAME"
    sed -i "s/$ENV_DATABASE/$ENV_DATABASE_SET/" $ENV_FILE
    if [[ $? -ne 0 ]]; then
        ENV_SED_RESULT=false
    fi

    ENV_PASSWORD="DB_PASSWORD="
    ENV_PASSWORD_SET="DB_PASSWORD=$DB_PASSWORD"
    sed -i "s/$ENV_PASSWORD/$ENV_PASSWORD_SET/" $ENV_FILE
    if [[ $? -ne 0 ]]; then
        ENV_SED_RESULT=false
    fi
}

if [ -e $ENV_FILE ]; then
    envSetup

    if [[ "$ENV_SED_RESULT" = true ]]; then
        echo -e "\n\e[32m✓ .env file has been found and was configured!\e[0m\n"
    else
        echo -e "\n\e[31m❌ \e[3m.env file has been found but wasn't configured!\e[0m\n"
    fi
else
    function envCreateSetup {
        php artisan october:env
        if [[ $? -ne 0 ]]; then
            ENV_SED_RESULT=false
        fi

        APP_KEY='APP_KEY=CHANGE_ME!!!!!!!!!!!!!!!!!!!!!!!'
        APP_KEY_RANDOM=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
        APP_KEY_CHANGE='s/'$APP_KEY'/APP_KEY='$APP_KEY_RANDOM'/'
        sed -i $APP_KEY_CHANGE .env
        if [[ $? -ne 0 ]]; then
            ENV_SED_RESULT=false
        fi

        envSetup
    }

    envCreateSetup

    if [[ "$ENV_SED_RESULT" = true ]]; then
        echo -e "\n\e[32m✓ .env file hasn't been found, was created and configured.\e[0m\n"
    else
        echo -e "\n\e[31m❌ \e[3m.env file hasn't been found and wasn't created or configured!\e[0m\n"
    fi
fi

# Create new database and drop old if exist
sudo mysql -p$DB_PASSWORD -u$DB_USER -e "DROP DATABASE IF EXISTS \`$DB_NAME\`; CREATE DATABASE \`$DB_NAME\` CHARACTER SET $DB_CHARACTER_SET COLLATE $DB_COLLATION;"

if [[ $? -eq 0 ]]; then
    echo -e "\n\e[32m✓ New database has been created (old was dropped if existed)!\e[0m\n"
else
    echo -e "\n\e[31m❌ Can't create new database.\e[0m\n"
fi

# Install October CMS
php artisan october:up
if [[ $? -eq 0 ]]; then
    echo -e "\n\e[32m✓ October CMS has been installed!\e[0m\n"
else
    echo -e "\n\e[31m❌ October CMS hasn't been installed!\e[0m\n"
fi

# Installing project theme

if [[ "$THEME_DRAFT_INSTALL" = true ]]; then

    THEMES_DIR=./themes
    THEME_DIR=./$THEMES_DIR/$PROJECT_NAME
    THEME_DIR_TEMP=./$THEMES_DIR/THEME_NAME/
    THEME_GIT_DIR=./$THEMES_DIR/.git

    sleep 0.5

    if [ -d "$THEME_DIR_TEMP" ]; then
        shopt -s dotglob
        rm -rf $THEME_DIR_TEMP
        shopt -u dotglob
        echo -e "\n\e[32m✓ Existed project theme was deleted!\e[0m\n"
    elif [ -d "$THEME_DIR" ]; then
        shopt -s dotglob
        rm -rf $THEME_DIR
        shopt -u dotglob
        echo -e "\n\e[32m⚠ Existed project theme was deleted!\e[0m\n"
    else
        echo -e "\n\e[34m🛈  Nothing to delete!\e[0m\n"
    fi

    sleep 0.5
    php artisan october:fresh

    git clone $THEME_GIT_PATH $THEMES_DIR

    if [[ $? -eq 0 ]]; then
        shopt -s dotglob
        rm -rf $THEME_GIT_DIR
        rm $THEMES_DIR/LICENSE
        rm $THEMES_DIR/README.md
        mv $THEME_DIR_TEMP $THEME_DIR
        shopt -u dotglob
        echo -e "\n\e[32m✓ Draft theme is ready to install!\e[0m\n"
    else
        echo -e "\n\e[31m❌ Can't clone draft theme!\e[0m\n"
    fi

    if [ -d "$THEME_DIR" ]; then
        sed -i "s/THEME_NAME/$PROJECT_NAME/g" $THEME_DIR/layouts/main.htm $THEME_DIR/theme.yaml
        if [[ $? -eq 0 ]]; then
            php artisan theme:use $PROJECT_NAME
            echo -e "\n\n\e[32m✓ Draft theme is installed!\e[0m\n"
        else
            echo -e "\n\e[31m❌ Can't install draft theme!\e[0m\n"
        fi
    else
        echo -e "\n\e[34m🛈  Nothing to delete!\e[0m\n"
    fi
fi
