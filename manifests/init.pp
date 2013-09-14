class git {
  package { 'git':
    name   => 'git-core',
    ensure => 'present'
  }
}
