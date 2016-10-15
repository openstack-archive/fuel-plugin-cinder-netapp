class plugin_cinder_netapp::params (
) {

  $config_file = '/etc/cinder/cinder.conf'
  $cinder_netapp = hiera_hash('cinder_netapp', {})
}
