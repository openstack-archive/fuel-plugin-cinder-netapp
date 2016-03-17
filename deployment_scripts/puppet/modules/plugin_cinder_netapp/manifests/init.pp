class plugin_cinder_netapp (
  $cinder_netapp = $plugin_cinder_netapp::params::cinder_netapp,
  $volume_backend_name = $plugin_cinder_netapp::params::volume_backend_name,
) inherits plugin_cinder_netapp::params {


  if ($cinder_netapp['multibackend']) {
    class { 'plugin_cinder_netapp::multibackend': }
  } else {
    plugin_cinder_netapp::hiera_override { "$volume_backend_name":
    } ->
    plugin_cinder_netapp::backend::netapp { 'DEFAULT': }
  }

}
