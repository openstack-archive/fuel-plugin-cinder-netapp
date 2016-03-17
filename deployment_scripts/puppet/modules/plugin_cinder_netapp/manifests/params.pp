class plugin_cinder_netapp::params (
) {

  $cinder_netapp = hiera_hash('cinder_netapp', {})
  $storage_hash  = hiera_hash('storage_hash', {})

  if ($storage_hash['volume_backend_names']['volumes_lvm']) {
    $default_backend     = 'cinder_iscsi'
    $volume_backend_name = 'volumes_lvm'
    $backend_class       = 'plugin_cinder_netapp::backend::iscsi'
  } elsif ($storage_hash['volume_backend_names']['volumes_ceph']) {
    $default_backend     = 'cinder_rbd'
    $volume_backend_name = 'volumes_ceph'
    $backend_class       = 'plugin_cinder_netapp::backend::rbd'
  }
}
