notice('MODULAR: netapp-compute')

include nova::params

$cinder_netapp = hiera_hash('cinder_netapp', {})

Nova_config <||> ~> Service <||>

package { 'multipath-tools': }
package { 'nfs-common': }

nova_config {
  'libvirt/iscsi_use_multipath': value => $cinder_netapp['use_multipath_for_image_xfer'];
}

if $cinder_netapp['nfs_mount_options'] {
  nova_config {
    'libvirt/nfs_mount_options': value => $cinder_netapp['nfs_mount_options'];
  }
}

service { "$nova::params::compute_service_name": }
