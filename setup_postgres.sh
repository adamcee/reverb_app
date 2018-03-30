#!/bin/bash
# Note: This was mostly copied from the Cairn Labs install_ubuntu script on 3/31/18
set -x

# Create postgres user and db for project
sudo -u postgres bash -c "psql -c \"CREATE USER reverb_app_dev WITH PASSWORD 'password';\""
sudo -u postgres bash -c "createdb reverb_app_dev -O reverb_app_dev"
