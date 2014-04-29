# Accounts of people who need to login to IT Lab servers

class user::virtual {

  @user { 'swl':
    ensure  => 'present',
    uid     => '9656',
    gid     => '0',
    comment => 'Scotty Logan',
    home    => '/home/swl',
    shell   => '/bin/bash',
  }

  @user { 'bvincent':
    ensure  => 'present',
    uid     => '18247',
    gid     => '0',
    comment => 'Bruce Vincent',
    home    => '/home/bvincent',
    shell   => '/bin/bash',
  }

  @user { 'admin':
    ensure  => 'present',
    uid     => '1000',
    gid     => '1000',
    comment => 'AWS Admin',
    home    => '/home/admin',
    shell   => '/bin/bash',
  }

  @user { 'vagrant':
    ensure  => 'present',
    uid     => '1000',
    gid     => '1000',
    comment => 'Vagrant Admin',
    home    => '/home/vagrant',
    shell   => '/bin/bash',
  }


