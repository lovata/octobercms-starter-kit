#!/usr/bin/env bash

source $1/config.cfg

if [ "$OCTOBER_GIT_INSTALL" ]
then
    echo "Installing October via Git…"
    git clone git@github.com:octobercms/october.git october

    sudo rm -r october/.git
    shopt -s dotglob
    mv october/* ./
    shopt -u dotglob
    rmdir october

    echo "Installing October dependencies…"
    composer install

    sudo rm -r modules/backend/.git
    sudo rm -r modules/cms/.git
    sudo rm -r modules/system/.git
else
    echo "Installing October via Composer…"
    composer create-project october/october october

    shopt -s dotglob
    mv october/* ./
    shopt -u dotglob
    rmdir october
fi
sed -i "1i APP_ASSETS=dev" .env

echo "Setting up the database…"

sudo mysql -p$DB_PASSWORD -u$DB_USER -e "DROP DATABASE IF EXISTS \`$DB_NAME\`; CREATE DATABASE \`$DB_NAME\` CHARACTER SET $DB_CHARACTER_SET COLLATE $DB_COLLATION;"

ENV_DATABASE="DB_DATABASE=database"
ENV_DATABASE_SET="DB_DATABASE=$DB_NAME"
sed -i "s/$ENV_DATABASE/$ENV_DATABASE_SET/" .env

ENV_PASSWORD="DB_PASSWORD="
ENV_PASSWORD_SET="DB_PASSWORD=$DB_PASSWORD"
sed -i "s/$ENV_PASSWORD/$ENV_PASSWORD_SET/" .env

echo "Installing October…"
php artisan october:up

echo "Installing project theme…"
mv $1/temp/THEME_NAME ./themes/$PROJECT_NAME
rm -R $1/temp/

sed -i "s/THEME_NAME/$PROJECT_NAME/g" ./themes/$PROJECT_NAME/layouts/main.htm ./themes/$PROJECT_NAME/theme.yaml

php artisan theme:use $PROJECT_NAME
php artisan october:fresh
