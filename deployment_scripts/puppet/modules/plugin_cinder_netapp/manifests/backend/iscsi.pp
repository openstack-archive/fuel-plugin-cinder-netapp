class plugin_cinder_netapp::backend::iscsi (
  $volume_group = 'cinder',
  $iscsi_helper = 'tgtadm',
  $backend_type,
  $backend_name,
) {

  # Get IP address in storage subnet
  $network_scheme = hiera_hash('network_scheme', {})
  prepare_network_config($network_scheme)
  $storage_address = get_network_role_property('cinder/iscsi', 'ipaddr')

  # Creates separate section for <LVM over iSCSI> backend
  cinder_config {
    "$backend_name/volume_backend_name": value => $backend_type;
    "$backend_name/volume_driver":       value => 'cinder.volume.drivers.lvm.LVMVolumeDriver';
    "$backend_name/iscsi_helper":        value => $iscsi_helper;
    "$backend_name/volume_group":        value => $volume_group;
    "$backend_name/iscsi_ip_address":    value => $storage_address;
    "$backend_name/backend_host":        value => $storage_address;
  }

  # Adds the backend in <enabled_backends> parameter
  plugin_cinder_netapp::backend::enable_backend { $backend_name: }
}
