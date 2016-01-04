# $confdir/modules/progresso/sites/manifests/sslflags.pp

define a2c::sslflags($binding,$sitename) {
  if $binding =~ /^.*net$/ {
    exec {$sitename:
      command   => template('a2c/set_sslflags.ps1.erb'),
      onlyif    => template('a2c/check_sslflags.ps1.erb'),
      logoutput => false,
      provider  => powershell
    }
  }
}
