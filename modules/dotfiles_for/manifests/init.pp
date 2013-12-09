define dotfiles_for($user, $user_path) {
  $repo_path = "${user_path}/dotfiles"
  vcsrepo { $repo_path:
    ensure => present,
    provider => git,
    source => 'https://github.com/skelz0r/dotfiles.git',
    revision => 'master',
    user => $user
  }

  exec { "install_dotfiles_for_${user}":
    command => "/bin/bash ./install.sh",
    cwd     => $repo_path,
    user    => $user,
    require => Vcsrepo[$repo_path];
  }
}
