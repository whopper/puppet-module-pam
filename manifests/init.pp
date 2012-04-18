class pam {
  include concat::setup

 @concat { "/etc/security/access.conf":
    owner  => "root",
    group  => "root",
    mode   => "0644",
  }

 @concat { "/etc/security/limits.conf":
    owner  => "root",
    group  => "root",
    mode   => "0644",
  }
}
