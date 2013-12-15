Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  environment => "HOME=/root" 
}

# Fill the host name here
node 'vagrant-ubuntu-raring-64' {
  $ruby_version   = '2.0.0-p353'
  $passenger_version = '4.0.27'
  $user           = 'skelz0r'
  $zsh_bin_path   = "/usr/bin/zsh"
  $hostname       = 'skelz0r.fr'

  $user_home      = "/home/${user}"

  package {
    ["tmux", "htop", "git", "vim", "tree", "zsh"]:
      ensure => present;
  }

  package {
    ["pry", "hub"]:
      ensure => present,
      provider => gem,
      require => Rvm_system_ruby[$ruby_version];
  }

  include rvm
  include apache
  class { 'rvm::passenger::apache':
    version      => $passenger_version,
    ruby_version => $ruby_version
  }

  rvm_system_ruby {
    $ruby_version:
      ensure => 'present',
      default_use => true;
  }

  class {
    'vhost_rails':
      hostname => $hostname,
      require => Class['rvm::passenger::apache'];
  }

  class {
    'rvm::passenger::apache':
      version => '3.0.11',
      ruby_version => 'ruby-1.9.2-p290';
  }

  user { 'root':
    ensure => present,
    shell  => $zsh_bin_path;
  }

  user { $user:
    ensure     => present,
    home       => $user_home,   
    managehome => true,            
    shell      => $zsh_bin_path,
    groups     => ['rvm', 'www-data'],
    password   => '',
    require => [Rvm_system_ruby[$ruby_version], Package["zsh"], Class['apache']];
  }

  dotfiles_for { "${user}":
    user => $user,
    user_path => $user_home,
    require => User[$user];
  }

  dotfiles_for { 'root':
    user => 'root',
    user_path => '/root'
  }
}
