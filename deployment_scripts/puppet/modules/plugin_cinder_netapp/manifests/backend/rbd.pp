class plugin_cinder_netapp::backend::rbd (
  $rbd_pool                         = 'volumes',
  $rbd_user                         = 'volumes',
  $rbd_ceph_conf                    = '/etc/ceph/ceph.conf',
  $rbd_flatten_volume_from_snapshot = false,
  $rbd_secret_uuid                  = 'a5d0dd94-57c4-ae55-ffe0-7e3732a24455',
  $volume_tmp_dir                   = false,
  $rbd_max_clone_depth              = '5',
  $glance_api_version               = undef,
  $backend_type,
  $backend_name,
) {

  # Creates separate section for Ceph backend
  cinder_config {
    "$backend_name/volume_backend_name":              value => $backend_type;
    "$backend_name/volume_driver":                    value => 'cinder.volume.drivers.rbd.RBDDriver';
    "$backend_name/rbd_ceph_conf":                    value => $rbd_ceph_conf;
    "$backend_name/rbd_user":                         value => $rbd_user;
    "$backend_name/rbd_pool":                         value => $rbd_pool;
    "$backend_name/rbd_max_clone_depth":              value => $rbd_max_clone_depth;
    "$backend_name/rbd_flatten_volume_from_snapshot": value => $rbd_flatten_volume_from_snapshot;
    "$backend_name/backend_host":                     value => "rbd:${rbd_pool}";
  }

  # Adds the backend in <enabled_backends> parameter
  plugin_cinder_netapp::backend::enable_backend { $backend_name: }
}
