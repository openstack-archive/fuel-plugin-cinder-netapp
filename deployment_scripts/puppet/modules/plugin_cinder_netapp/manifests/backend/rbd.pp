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
) {

  cinder_config {
    'cinder_rbd/volume_backend_name':              value => $backend_type;
    'cinder_rbd/volume_driver':                    value => 'cinder.volume.drivers.rbd.RBDDriver';
    'cinder_rbd/rbd_ceph_conf':                    value => $rbd_ceph_conf;
    'cinder_rbd/rbd_user':                         value => $rbd_user;
    'cinder_rbd/rbd_pool':                         value => $rbd_pool;
    'cinder_rbd/rbd_max_clone_depth':              value => $rbd_max_clone_depth;
    'cinder_rbd/rbd_flatten_volume_from_snapshot': value => $rbd_flatten_volume_from_snapshot;
    'cinder_rbd/host':                             value => "rbd:${rbd_pool}";
  }

}
