#!/usr/bin/env bash

sudo apt-get install -y apache2
sudo a2enmod rewrite
sudo systemctl reload apache2.service
