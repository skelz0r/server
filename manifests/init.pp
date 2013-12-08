Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
  environment => "HOME=/root" 
}

# Fill the host name here
node 'vagrant-ubuntu-raring-64' {
  $ruby_version   = '2.0.0-p353'
  $user           = 'skelz0r'
  $zsh_bin_path   = "/usr/bin/zsh"

  $user_home      = "/home/${user}"

  package {
    ["silversearcher-ag", "tmux", "htop", "git", "vim", "tree", "zsh"]:
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
  include rvm::passenger::apache

  rvm_system_ruby {
    $ruby_version:
      ensure => 'present',
      default_use => true;
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
    require => [Rvm_system_ruby[$ruby_version], Package["zsh"], Apache];
  }

  dotfiles_for { $user:
    user => $user,
    path => $user_home
  }

  dotfiles_for { 'root':
    user => 'root',
    path => '/root'
  }
}
