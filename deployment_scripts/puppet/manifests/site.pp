notice('MODULAR: fuel-plugin-cinder-netapp')

# The manifest is executed on nodes with cinder role or on nodes with controller role when Ceph is used.
if ('cinder' in hiera('roles')) or (!empty(filter_nodes(hiera('nodes'), 'role', 'ceph-osd'))) {
  class { 'plugin_cinder_netapp': }
}
