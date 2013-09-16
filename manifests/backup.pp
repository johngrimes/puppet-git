define git::backup (
    $user,
    $group,
    $git_root,
    $s3_dir,
    $aws_access_key,
    $aws_secret_key,
    $gpg_passphrase,
    $gpg_encryption_key,
    $git_log_dir = '/var/log/git'
  ) {
  include s3cmd

  file { "${git_root}/backup.sh":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => '740',
    content => template('git/backup.sh.erb')
  }

  file { $git_log_dir:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '640'
  }

  s3cmd::user { $user:
    aws_access_key => $aws_access_key,
    aws_secret_key => $aws_secret_key,
    gpg_passphrase => $gpg_passphrase
  }

  cron { 'backup-git':
    command => "nice ${git_root}/backup.sh >> ${git_log_dir}/backup.log 2>&1",
    user    => 'git',
    minute  => '5',
    hour    => '0'
  }
}
