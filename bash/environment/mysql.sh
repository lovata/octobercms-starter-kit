#!/usr/bin/env bash

sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password lovata"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password lovata"

sudo apt-get install -y mysql-server
sudo apt-get install -y mysql-client
