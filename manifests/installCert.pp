class a2c::installcert inherits a2c {
#Install ssl certificate to Local machine
  file{"${drive}certs":
    ensure  => directory,
    source  => 'puppet:///modules/a2c/certs',
    recurse => true,
    purge   => true
  }
}