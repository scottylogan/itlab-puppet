# IT Lab staff members

class user::itlab-users inherits user::virtual {
  realize(
    User['swl'],
    User['bvincent'],
  )
  
  # ensure that there is a root group with gid 0
  
  group { 'root':
    ensure => present,
    gid    => 0,
  }
  
  User['swl']      { groups => [ 'root' ] }
  User['bvincent'] { groups => [ 'root' ] }
}
