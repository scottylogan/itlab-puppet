# Class: s3file::aws
#
# This class installs cURL and ensures it is installed before
# any S3file resources are evaluated.
class s3file::aws () {
  package { 'python-pip':
    ensure => present
  }

  exec { 'pip aws install':
    command => 'pip install awscli',
    path => [ '/bin', '/usr/bin', '/sbin', '/usr/sbin' ],
    unless => '[ -e /usr/local/bin/aws ]'
  }

  file { 'root aws dir':
    path    => '/root/.aws',
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
  }

  file { 'aws config':
    path    => '/root/.aws/config',
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => 0640,
    content => "[default]\nregion = us-west-2\n",
  }

  Package['python-pip'] -> Exec['pip aws install'] -> File['root aws dir'] -> File['aws config'] -> S3file<| |>

}

