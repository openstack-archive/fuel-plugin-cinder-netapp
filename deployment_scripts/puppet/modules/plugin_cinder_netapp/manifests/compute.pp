# This can be used to install on compute required depedencies to use netapp volume
#
class plugin_cinder_netapp::compute {

  include cinder::params

  $cinder_hash = $::fuel_settings['cinder']

  case $::osfamily {
    'Debian': {
      package { 'nfs-common':
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
      }
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} currently only supports osfamily RedHat and Debian")
    }
  }

  if $cinder_netapp['nfs_mount_options'] {
    nova_config {
      'DEFAULT/nfs_mount_options': value => "$cinder_netapp['nfs_mount_options']";
    }
  }

}
