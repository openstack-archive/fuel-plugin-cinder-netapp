notice('MODULAR: netapp-compute')

include nova::params

$cinder_netapp = hiera_hash('cinder_netapp', {})

Nova_config <||> ~> service { "$nova::params::compute_service_name": }

if ($cinder_netapp['netapp_storage_protocol']) == 'iscsi' and ($cinder_netapp['use_multipath_for_image_xfer']) {
  package { 'multipath-tools': }

  nova_config {
    'libvirt/iscsi_use_multipath': value => true;
  }
}

if ($cinder_netapp['netapp_storage_protocol']) == 'nfs' {
  package { 'nfs-common': }

  if $cinder_netapp['nfs_mount_options'] {
    nova_config {
      'libvirt/nfs_mount_options': value => $cinder_netapp['nfs_mount_options'];
    }
  }
}
