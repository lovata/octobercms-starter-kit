#!/usr/bin/env bash

source bash/project/config.cfg  # TODO: replace relative path #
source bash/project/functions.sh # TODO: replace relative path #

DIR_META=meta
DIR_CONTENT=content
DIR_UPLOADS=uploads
DIR_MEDIA=media

PATH_THEMES=themes/$PROJECT_NAME
PATH_STORAGE=storage/app

# Import meta directory
staticFilesImport $DIR_META

# # Import content directory
staticFilesImport $DIR_CONTENT

# # Import uploads directory
staticFilesImport $DIR_UPLOADS

# # Import media directory
staticFilesImport $DIR_MEDIA

# Export meta directory
staticFilesExport $DIR_META $PATH_THEMES

# Export content directory
staticFilesExport $DIR_CONTENT $PATH_THEMES

# Export uploads directory
staticFilesExport $DIR_UPLOADS $PATH_STORAGE

# Export media directory
staticFilesExport $DIR_MEDIA $PATH_STORAGE