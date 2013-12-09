#!/bin/sh
# Install script

modules_path="/etc/puppet/modules/"
./install_modules.sh 
puppet apply --verbose --modulepath=./modules/:$modules_path manifests/init.pp
