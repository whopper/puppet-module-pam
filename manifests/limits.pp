define pam::limits (
  $domain,
  $type,
  $item,
  $value,
  $ensure   = present,
  $priority = '10'
) {
  include pam

  if ! ($osfamily in ['Debian']) {
    fail("pam::limits does not support osfamily $osfamily")
  }

  realize Concat['/etc/security/limits.conf']

  concat::fragment { "${domain}-${type}-${item}-${value}":
    ensure  => $ensure,
    target  => '/etc/security/limits.conf',
    content => "${domain} ${type} ${item} ${value}\n",
    order   => $priority,
  }

}
