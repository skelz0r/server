define dotfiles_for($user, $path) {
  vcsrepo { $path:
    ensure => present,
    provider => git,
    source => 'https://github.com/skelz0r/dotfiles.git',
    revision => 'master',
    user => $user
  }

  exec { "install_dotfiles_for_${user}":
    command => "cd ${path} && ./install.sh",
    require => Vcsrepo[$path];
  }
}
