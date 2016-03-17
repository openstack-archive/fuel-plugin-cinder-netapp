class plugin_cinder_netapp::multibackend (
  $volume_backend_name = $plugin_cinder_netapp::params::volume_backend_name,
  $default_backend     = $plugin_cinder_netapp::params::default_backend,
  $backend_class       = $plugin_cinder_netapp::params::backend_class,
) inherits plugin_cinder_netapp::params {

  plugin_cinder_netapp::hiera_override { "$volume_backend_name":
    backend => $default_backend,
  } ->
  class { "$backend_class": } ->
  plugin_cinder_netapp::backend::netapp { 'cinder_netapp':
    default_backend => $default_backend,
  }
}
