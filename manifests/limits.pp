define pam::limits (
  $ensure   = "present",
  $domain   = undef,
  $type     = undef,
  $item     = undef,
  $value    = undef,
  $priority = 10,
) {
  include pam

  case $osfamily {
    "Debian": {
    if $domain == undef {
      fail("Domain field must be specified")
    } elsif $type == undef {
      fail("Type field must be specified")
    } elsif $item == undef {
      fail("Item field must be specified")
    } elsif $value == undef {
      fail("Value field must be specified")
    }

    realize Concat["/etc/security/limits.conf"]

    concat::fragment { "${domain}-${type}-${item}-${value}":
      ensure  => $ensure,
      target  => "/etc/security/limits.conf",
      content => "${domain} ${type} ${item} ${value}\n",
      order   => $priority,
    }
  }
    default: {
      fail("Module does not support $osfamily")
    }
  }
}
