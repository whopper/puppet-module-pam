define pam::access (
  $ensure     = "present",
  $permission = undef,
  $entity     = undef,
  $origin     = undef,
  $priority   = 10,
) {
  include pam

  case $osfamily {
    "Debian": {
    if $permission == undef {
      fail("Permission (+ or -) must be provided")
    } elsif $entity == undef {
      fail("Entity must be provided")
    } elsif $origin == undef {
      fail("Origin must be provided")
    }

    realize Concat["/etc/security/access.conf"]

    concat::fragment { "$entity":
      ensure  => $ensure,
      target  => "/etc/security/access.conf",
      content => "${permission}:${entity}:${origin}\n",
      order   => $priority,
    }
  }
    default: {
      fail("Module does not support $osfamily")
    }
  }
}
