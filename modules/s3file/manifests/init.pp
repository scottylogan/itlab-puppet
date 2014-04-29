define s3file (
  $source,
  $ensure = 'latest',
  $s3_bucket = 's3://itlab-puppet'
)
{
  if $ensure == 'absent' {
    # We use a puppet resource here to force the file to absent state
    file { $name:
      ensure => absent
    }
  } else {
    $real_source = "${s3_bucket}/${source}"

    exec { "fetch ${name}":
      path    => ['/bin', '/usr/bin', 'sbin', '/usr/sbin', '/usr/local/bin' ],
      command => "aws s3 cp ${real_source} ${name}"
    }
  }
}

