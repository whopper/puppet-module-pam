# PAM module for Puppet

## Description
Puppet module for managing /etc/security/access.conf

## Usage

    pam::access {
      "root":
        permission  => "+",
        entity      => "root",
        origin      => "ALL",
        priority    => "10";
      "ALL":
        permission  => "-",
        entity      => "ALL",
        origin      => "ALL",
        priority    => "50";
    }
