#!/usr/bin/env bash

source $1/config.cfg

echo "Configuring Webpack…"
sed -i "s/THEME_NAME/$PROJECT_NAME/g" ./webpack.config.babel.js ./package.json

echo "Installing NPM packages…"
npm i

echo "Backuping README file of October…"
mv ./README.md ./README.OCTOBER.md

echo "Setting up project README file…"
mv ./README.OCTOBER.md ./README.md
