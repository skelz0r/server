Minimal configuration for own server
====================================

Run as **root** porc flavor.

Puppet modules to install:

* maestrodev/rvm
* puppetlabs/vcsrepo
* puppetlabs/apache
* puppetlabs/concat

You can run `./install_modules.sh`

Install:

aptitude update && aptitude upgrade
puppet apply --verbose --modulepath=./modules:~/.puppet/modules
manifests/init.pp
