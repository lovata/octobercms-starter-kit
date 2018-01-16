#!/usr/bin/env bash

sudo apt-get update

if $VAGRANT; then
    echo "Install in Vagrant environment…"
else
    echo "Install in local environment…"
fi
