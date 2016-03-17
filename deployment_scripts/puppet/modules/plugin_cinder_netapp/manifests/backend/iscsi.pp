class plugin_cinder_netapp::backend::iscsi (
  $volume_group     = 'cinder',
  $iscsi_helper     = $::cinder::params::iscsi_helper,
  $backend_type,
) inherits cinder::params {

  $network_scheme = hiera_hash('network_scheme', {})
  prepare_network_config($network_scheme)

  $storage_address  = get_network_role_property('cinder/iscsi', 'ipaddr')

  cinder_config {
    'cinder_iscsi/volume_backend_name': value => $backend_type;
    'cinder_iscsi/volume_driver':       value => 'cinder.volume.drivers.lvm.LVMVolumeDriver';
    'cinder_iscsi/iscsi_helper':        value => $iscsi_helper;
    'cinder_iscsi/volume_group':        value => $volume_group;
    'cinder_iscsi/iscsi_ip_address':    value => $storage_address;
    'cinder_iscsi/backend_host':        value => $storage_address;
  }
}
