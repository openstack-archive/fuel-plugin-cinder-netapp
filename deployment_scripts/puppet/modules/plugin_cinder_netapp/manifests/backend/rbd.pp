# this can be used to insert into cinder_rbd section rbd configuration parameters
#
# [rbd_pool] The RADOS pool where rbd volumes are stored
# [rbd_user] The RADOS client name for accessing rbd volumes
# [rbd_ceph_conf] Path to the ceph configuration file
# [rbd_flatten_volume_from_snapshot] Flatten volumes created from snapshots to remove dependency
# [rbd_secret_uuid] The libvirt uuid of the secret for the rbd_user volumes
# [volume_tmp_dir]  Directory where temporary image files are stored when the
# volume driver does not write them directly to the volume)
# [rbd_max_clone_depth] Maximum number of nested volume clones that are taken before
# a flatten occurs. Set to 0 to disable cloning.
# [glance_api_version] Version of the glance API to use
#
# === Examples
#
#  class { 'plugin_cinder_netapp::backend::rbdi':
#  $rbd_pool                         = 'volumes',
#  $rbd_user                         = 'volumes',
#  $rbd_ceph_conf                    = '/etc/ceph/ceph.conf',
#  $rbd_flatten_volume_from_snapshot = false,
#  $rbd_secret_uuid                  = 'a5d0dd94-57c4-ae55-ffe0-7e3732a24455',
#  $volume_tmp_dir                   = false,
#  $rbd_max_clone_depth              = '5',
#  $glance_api_version               = undef,
#  }
#
class plugin_cinder_netapp::backend::rbd (
  $rbd_pool                         = 'volumes',
  $rbd_user                         = 'volumes',
  $rbd_ceph_conf                    = '/etc/ceph/ceph.conf',
  $rbd_flatten_volume_from_snapshot = false,
  $rbd_secret_uuid                  = 'a5d0dd94-57c4-ae55-ffe0-7e3732a24455',
  $volume_tmp_dir                   = false,
  $rbd_max_clone_depth              = '5',
  $glance_api_version               = undef,
) {

  cinder_config {
    'cinder_rbd/volume_backend_name':              value => 'cinder_rbd';
    'cinder_rbd/volume_driver':                    value => 'cinder.volume.drivers.rbd.RBDDriver';
    'cinder_rbd/rbd_ceph_conf':                    value => $rbd_ceph_conf;
    'cinder_rbd/rbd_user':                         value => $rbd_user;
    'cinder_rbd/rbd_pool':                         value => $rbd_pool;
    'cinder_rbd/rbd_max_clone_depth':              value => $rbd_max_clone_depth;
    'cinder_rbd/rbd_flatten_volume_from_snapshot': value => $rbd_flatten_volume_from_snapshot;
    'cinder_rbd/host':                             value => "rbd:${rbd_pool}";
  }

}
