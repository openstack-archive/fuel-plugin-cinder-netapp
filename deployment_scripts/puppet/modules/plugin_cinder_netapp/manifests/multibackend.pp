class plugin_cinder_netapp::multibackend (
  $backend_name  = $plugin_cinder_netapp::params::backend_name,
  $backend_type  = $plugin_cinder_netapp::params::backend_type,
  $backend_class = $plugin_cinder_netapp::params::backend_class,
) inherits plugin_cinder_netapp::params {

  class { "$backend_class":
    backend_type => $backend_type,
  } ->
  plugin_cinder_netapp::backend::netapp { 'cinder_netapp':
    backend_name => $backend_name,
  }

}
