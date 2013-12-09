#!/bin/sh
# Install puppet modules
for module in 'maestrodev-rvm' 'puppetlabs-stdlib' 'puppetlabs-vcsrepo' 'puppetlabs-apache' 'puppetlabs-concat' ; do
  echo "Install $module module:"
  puppet module install $module --force
done
