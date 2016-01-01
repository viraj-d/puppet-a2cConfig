


class a2c::config1 inherits a2c{

 # update authenticatiom config file
  file{"${a2c::sitepath}\\config\\authentication.config":
    ensure => present,
    content => template('a2c/authentication.config.erb')
  }

 # update common settings config file
  file{"${a2c::sitepath}\\config\\A2C.Configuration.CommonSetting.config":
    ensure => present,
    content => template('a2c/A2C.Configuration.CommonSetting.erb')
  }
 
  file{"${a2c::a2cservicepath}\\config\\A2C.Configuration.CommonSetting.config":
    ensure => present,
    content => template('a2c/A2C.Configuration.CommonSetting.erb')
  }

}
