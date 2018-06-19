#!/usr/bin/env bash

source bash/project/config.cfg  # TODO: replace relative path #
source bash/project/functions.sh # TODO: replace relative path #

if [[ "$1" == "export" ]]; then
    FILE_TARGET=$DB_NAME.zip

    fileBackup $FILE_TARGET
    rm $FILE_BACKUP

    # mysqlExport
    # zipFile $FILE_DB_DUMP
    # rm $FILE_DB_DUMP

    # fileUpload $FILE_ZIPPED
    # rm $FILE_ZIPPED
elif [[ "$1" = "import" ]]; then
    # Import MySQL dump
    echo "MySQL dump feature will be added later"
else
  userMessage warning "Please, call argument 'export' or 'import'!"
fi
