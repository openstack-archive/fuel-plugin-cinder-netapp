class plugin_cinder_netapp (
  $cinder_netapp = $plugin_cinder_netapp::params::cinder_netapp,
) inherits plugin_cinder_netapp::params {

  $backends = range('1', $cinder_netapp['number_netapp_backends'])

  plugin_cinder_netapp::backend::netapp { $backends : }

  plugin_cinder_netapp::backend::solidfire { $backends : }
}
