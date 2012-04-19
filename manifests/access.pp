define pam::access (
  $permission,
  $entity,
  $origin,
  $ensure     = present,
  $priority   = '10'
) {
  include pam

  if ! ($osfamily in ['Debian']) {
    fail("pam::access does not support osfamily $osfamily")
  }

  if ! ($permission in ['+', '-']) {
    fail("Permission must be + or - ; recieved $permission")
  }

  realize Concat['/etc/security/access.conf']

  concat::fragment { $entity:
    ensure  => $ensure,
    target  => '/etc/security/access.conf',
    content => "${permission}:${entity}:${origin}\n",
    order   => $priority,
  }

}
