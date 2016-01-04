
class a2c::db inherits a2c {

  file { 'DBUpdates':
    ensure => directory,
    path   => "${drive}DBUpdates"
  }

  file { 'DBUpdates-Packages':
    ensure  => directory,
    path    => "${drive}DBUpdates\\packages",
    source  => 'puppet:///modules/a2creleases/A2CDatabase/packages',
    recurse => true
  }
}
