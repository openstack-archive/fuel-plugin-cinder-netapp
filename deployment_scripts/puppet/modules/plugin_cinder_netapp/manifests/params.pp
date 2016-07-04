class plugin_cinder_netapp::params (
) {

  $config_file = '/etc/cinder/cinder.conf'

  $cinder_netapp = hiera_hash('cinder_netapp', {})
  $storage_hash  = hiera_hash('storage', {})

  if ($storage_hash['volume_backend_names']['volumes_lvm']) {
    $backend_type        = $storage_hash['volume_backend_names']['volumes_lvm']
    $backend_name        = 'cinder_iscsi'
    $volume_backend_name = 'volumes_lvm'
    $backend_class       = 'plugin_cinder_netapp::backend::iscsi'
  } elsif ($storage_hash['volume_backend_names']['volumes_ceph']) {
    $backend_type        = $storage_hash['volume_backend_names']['volumes_ceph']
    $backend_name        = 'cinder_rbd'
    $volume_backend_name = 'volumes_ceph'
    $backend_class       = 'plugin_cinder_netapp::backend::rbd'
  }

  $netapp_backend_class = 'plugin_cinder_netapp::backend::netapp'
}
