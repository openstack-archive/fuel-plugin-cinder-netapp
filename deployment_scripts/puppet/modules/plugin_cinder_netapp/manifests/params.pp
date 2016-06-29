class plugin_cinder_netapp::params (
) {

  $config_file = '/etc/cinder/cinder.conf'

  $cinder_netapp = hiera_hash('cinder_netapp', {})
  $storage_hash  = hiera_hash('storage_hash', {})

  if ($storage_hash['volume_backend_names']['lvm']) {
    $backend_type        = $storage_hash['volume_backend_names']['lvm']
    $backend_name        = 'lvm'
    $volume_backend_name = 'lvm'
    $backend_class       = 'plugin_cinder_netapp::backend::iscsi'
  } elsif ($storage_hash['volume_backend_names']['ceph']) {
    $backend_type        = $storage_hash['volume_backend_names']['ceph']
    $backend_name        = 'ceph'
    $volume_backend_name = 'ceph'
    $backend_class       = 'plugin_cinder_netapp::backend::rbd'
  }

  $netapp_backend_class = 'plugin_cinder_netapp::backend::netapp'
  $solidfire_backend_class = 'plugin_cinder_netapp::backend::solidfire'
}
