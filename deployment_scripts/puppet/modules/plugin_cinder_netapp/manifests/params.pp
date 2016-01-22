class plugin_cinder_netapp::params {

  include cinder::params

  $cinder_hash  = $::fuel_settings['cinder']
  $storage_hash = $::fuel_settings['storage']

  case $::osfamily {
    'Debian': {
      package { 'nfs-common':
        before => Cinder::Backend::Netapp['cinder_netapp'],
      }
    }
    'RedHat': {
      package { 'nfs-utils': } ->
      service {'rpcbind':
        ensure => running,
      } ->
      service {'rpcidmapd':
        ensure => running,
      } ->
      service {'nfs':
        ensure => running,
        before => Cinder::Backend::Netapp['cinder_netapp'],
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }
  if ($storage_hash['volumes_lvm']) {
    $backends      = 'cinder_isci'
    $backend_class = 'plugin_cinder_netapp::backend::iscsi'
  } elsif ($storage_hash['volumes_ceph']) {
    $backends = 'cinder_rbd'
    $backend_class = 'plugin_cinder_netapp::backend::rbd'
  }
}
