class plugin_cinder_netapp (
  $cinder_netapp        = $plugin_cinder_netapp::params::cinder_netapp,
  $netapp_backend_class = $plugin_cinder_netapp::params::netapp_backend_class,
) inherits plugin_cinder_netapp::params {

  # If not selected disable default MOS backends
  if ! $cinder_netapp['default_backend'] {

    Cinder_config['DEFAULT/enabled_backends'] -> Class[$netapp_backend_class]

    cinder_config {
      'DEFAULT/enabled_backends': ensure => absent;
    }
  }

  class { $netapp_backend_class: }
}
