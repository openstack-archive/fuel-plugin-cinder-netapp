class plugin_cinder_netapp (
  $cinder_netapp        = $plugin_cinder_netapp::params::cinder_netapp,
  $backend_name         = $plugin_cinder_netapp::params::backend_name,
  $backend_type         = $plugin_cinder_netapp::params::backend_type,
  $backend_class        = $plugin_cinder_netapp::params::backend_class,
  $netapp_backend_class = $plugin_cinder_netapp::params::netapp_backend_class,
  $solidfire_backend_class = $plugin_cinder_netapp::params::solidfire_backend_class,
) inherits plugin_cinder_netapp::params {

  if ($cinder_netapp['default_backend']) {

    Class[$backend_class] -> Class[$netapp_backend_class]

    class { $backend_class:
      backend_type => $backend_type,
      backend_name => $backend_name,
    }
  }

  if ($cinder_netapp['netapp_enabled']) {
    plugin_cinder_netapp::backend::netapp { 'netapp': 
       backend_name => 'netapp',
    }
  }
  if ($cinder_netapp['solidfire_enabled']) {
    plugin_cinder_netapp::backend::solidfire { 'solidfire':
       backend_name => 'solidfire',
    }
  }
}
