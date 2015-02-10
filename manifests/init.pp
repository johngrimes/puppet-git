class git {
  if !defined(Package['git-core']) {
    package { 'git':
      name   => 'git-core',
      ensure => 'present'
    }
  }
}
