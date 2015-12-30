class a2c (
    $binding  = $a2c::params::binding,
    $iisaccount = $a2c::params::iisaccount,
    $iispassword = $a2c::params::iispassword,
    $sitepath = $a2c::params::sitepath,
    $drive = $a2c::params::drive,
    $cpulimit = $a2c::params::cpulimit,
    $a2cdb =$a2c::params::a2cdbname,
    $a2cservername = $a2c::params::a2cservername,
    $a2cuserid = $a2c::params::a2cuserid,
    $a2cpassword  = $a2c::params::a2cpassword,
    $a2cservicepath = $a2c::params::a2cservicepath)

    inherits a2c::params {
 
   
    # copy certificate to target location
    include a2c::installCert
    
    # install certificate on target
    include a2c::storessl

    # create application pool and a2c-website
    include a2c::iis
         
}
