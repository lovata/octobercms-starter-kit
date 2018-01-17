#!/usr/bin/env bash

GIT_DIRECTORY=/vagrant/.git
echo $GIT_DIRECTORY
if [ -d "$GIT_DIRECTORY" ]; then
    echo "Delete Starter Kit Git directory…"
    rm -rf ./.git
fi

echo "Reading config…"
CFG_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Backuping README file of Starter kit…"
mv ./README.md ./README.STARTERKIT.md

bash $CFG_PATH/october.sh $CFG_PATH
bash $CFG_PATH/webpack.sh $CFG_PATH
