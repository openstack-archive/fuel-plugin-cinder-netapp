class plugin_cinder_netapp (
  $cinder_netapp = $plugin_cinder_netapp::params::cinder_netapp,
) inherits plugin_cinder_netapp::params {

  if ($cinder_netapp['multibackend']) {
    class { 'plugin_cinder_netapp::multibackend': }
  } else {
    plugin_cinder_netapp::backend::netapp { 'DEFAULT': }
  }

}
