class pam {
  include concat::setup

 @concat { "/etc/security/access.conf":
    owner  => "root",
    group  => "root",
    mode   => '0644',
  }
}
