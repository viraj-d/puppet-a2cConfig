class a2c::config() inherits a2c {
     
    # $bindings = ["http/*:80:${a2c::binding}","https/*:443:${a2c::binding}"]
    $bindings = ['http/*:80:',"https/*:443:${a2c::binding}"]

  if $kernelmajversion == '6.1' {
    $cpuaction = 'NoAction'
  } else {
    $cpuaction = 'Throttle'
  }

  # create the app pool
  iis_apppool {'A2CCore':
    ensure                                   => present,
    managedpipelinemode                      => 'Integrated',
    managedruntimeversion                    => 'v4.0',
    enable32bitapponwin64                    => false,
    queuelength                              => '9000',
    autostart                                => true,
    startmode                                => 'AlwaysRunning',
    cpu_limit                                => $a2c::cpulimit,
    cpu_action                               => $cpuaction,
    cpu_resetinterval                        => '00:05:00',
    cpu_smpaffinitized                       => false,
    cpu_smpprocessoraffinitymask             => '4294967295',
    processmodel_identitytype                => 'SpecificUser',
    processmodel_username                    => $a2c::iisaccount,
    processmodel_password                    => $a2c::iispassword,
    processmodel_loaduserprofile             => false,
    processmodel_idletimeout                 => '00:00:00',
    processmodel_maxprocesses                => '1',
    processmodel_shutdowntimelimit           => '00:01:30',
    processmodel_startuptimelimit            => '00:10:00',
    processmodel_pingingenabled              => true,
    processmodel_pinginterval                => '00:00:30',
    processmodel_pingresponsetime            => '00:01:30',
    failure_orphanworkerprocess              => false,
    failure_loadbalancercapabilities         => 'HttpLevel',
    failure_rapidfailprotection              => false,
    failure_rapidfailprotectioninterval      => '00:05:00',
    failure_rapidfailprotectionmaxcrashes    => '5',
    recycling_disallowoverlappingrotation    => true,
    recycling_disallowrotationonconfigchange => false,
    recycling_logeventonrecycle              => 'Schedule, IsapiUnhealthy, OnDemand, ConfigChange',
    recycling_periodicrestart_memory         => '0',
    recycling_periodicrestart_privatememory  => '0',
    recycling_periodicrestart_time           => '00:00:00'
    #doDynamicCompression                     => true
    #doStaticCompression                      => true
  }

  iis_site {'A2CCore':
    ensure                                => present,
    id                                    => 20,
    serverautostart                       => true,
    applicationdefaults_applicationpool   => 'A2CCore',
    virtualdirectorydefaults_physicalpath => $a2c::sitepath,
    bindings                              => $bindings,
    require                               => Iis_apppool['A2CCore']
  }

  # remove default web site from iis
  iis_site {'Default Web Site':
      ensure => absent,
    }

  iis_app {'A2CCore/':
    ensure => present
  }

  iis_vdir {'A2CCore/':
    ensure       => present,
    iis_app      => "A2CCore/",
    physicalpath => $a2c::sitepath
  }
  
  # set sslFlags for https bindings
  a2c::sslflags {'A2CCoreSSL': 
      binding => $binding,
      sitename => 'A2CCore'
    }

 #add entry to hosts file
  host {$a2c::binding:
    ip => '127.0.0.1'
  }

  # update config files
  $dbserver = $a2c::dbserver

  file{"${a2c::sitepath}\\config\\authentication.config":
    ensure => present,
   content => template('a2c/authentication.config.erb')
  }
  
  #file{"${a2c::sitepath}\\config\\connectionstrings.config":
  #  ensure => present,
  # content => template('a2c/connectionstrings.erb')
  #}

  # file{"${a2c::sitepath}\\config\\sessionState.config":
  #ensure => present,
  #  content => template('a2c/sessionState.erb')
  #}
  
   file{"${a2c::sitepath}\\config\\A2C.Configuration.CommonSetting.config":
  ensure => present,
    content => template('a2c/A2C.Configuration.CommonSetting.erb')
  }
  
  #  file{"${a2c::a2cservicepath}\\config\\connectionstrings.config":
  #  ensure => present,
  #  content => template('a2c/service_connectionstrings.erb')
  #}
  
    file{"${a2c::a2cservicepath}\\config\\A2C.Configuration.CommonSetting.config":
    ensure => present,
    content => template('a2c/A2C.Configuration.CommonSetting.erb')
  }
}
