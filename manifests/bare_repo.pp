define git::bare_repo (
    $user,
    $group
  ) {

  file { $title:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '660',
    recurse => true,
    require => Vcsrepo[$title]
  }

  vcsrepo { $title:
    ensure   => bare,
    provider => git,
    owner    => $user,
    group    => $group,
    require  => Package['git']
  }
}
