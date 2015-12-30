
class a2c::storessl inherits a2c{
 
   sslcertificate{'*.progresso.net' :
     			  name       => '_.progresso.net.pfx',
    			  password   => '_.progresso.net.pfx',
   			  location   => "${drive}certs\\",
   		          root_store => 'LocalMachine',
    		 	  thumbprint => 'A680186B0836CC6A1F1B268210E147AE3576E944'
                 }
}