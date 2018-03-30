#!/bin/bash
# Note: This was mostly copied from the Cairn Labs install_ubuntu script on 3/31/18
set -x

# Install postgres 9.5
source /etc/os-release
case $UBUNTU_CODENAME in
    trusty)
        sudo add-apt-repository "deb https://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main"
        sudo apt-get update
        sudo apt-get install postgresql-9.5 postgresql-contrib-9.5 postgresql-server-dev-9.5
        ;;
    xenial)
        sudo apt-get install postgresql-9.5 postgresql-contrib-9.5 postgresql-server-dev-9.5
        ;;
    yakkety)
        sudo apt-get install postgresql-9.5 postgresql-contrib-9.5 postgresql-server-dev-9.5
        ;;
    loki)
        sudo apt-get install postgresql-9.5 postgresql-contrib-9.5 postgresql-server-dev-9.5
        ;;
    zesty)
        sudo apt install postgresql-server-dev-all postgresql-contrib postgresql
        ;;
    *)
        echo "This install script works only with Ubuntu 14.04, 16.04, and 16.10"
        exit 1
        ;;
esac
