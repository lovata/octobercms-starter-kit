#!/usr/bin/env bash

sudo apt-get update

echo "Install in Vagrant environment…"
bash /vagrant/bash/environment/zipunzip.sh
bash /vagrant/bash/environment/apache.sh
bash /vagrant/bash/environment/curl.sh
bash /vagrant/bash/environment/php.sh
bash /vagrant/bash/environment/composer.sh
bash /vagrant/bash/environment/mysql.sh
bash /vagrant/bash/environment/nodejs.sh
