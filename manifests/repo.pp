define git::repo (
    $remote,
    $revision,
    $identity,
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
    ensure   => present,
    provider => git,
    revision => $revision,
    source   => $remote,
    identity => $identity,
    user     => $user,
    owner    => $user,
    require  => Package['git']
  }
}
