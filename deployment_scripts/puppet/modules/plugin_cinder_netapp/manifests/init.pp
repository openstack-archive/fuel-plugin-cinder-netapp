class plugin_cinder_netapp  {

  $config_file = '/etc/cinder/cinder.conf'
  $cinder_netapp = hiera_hash('cinder_netapp', {})
  $storage_hash  = hiera_hash('storage', {})
  $netapp_backend_class = 'plugin_cinder_netapp::backend::netapp'
  $solidfire_backend_class = 'plugin_cinder_netapp::backend::solidfire'

  # if Netapp is using iSCSI or SolidFire we need to install iscsi
  if ($cinder_netapp['netapp_storage_protocol']) == 'iscsi' or $cinder_netapp['solidfire_enabled'] {
    package { 'open-iscsi': }
  }

  if ($cinder_netapp['netapp_enabled']) {
    class { $netapp_backend_class:
       backend_name => 'netapp'
    }
  }
  if ($cinder_netapp['solidfire_enabled']) {
    class { $solidfire_backend_class:
       backend_name => 'solidfire',
    }
  }

  service { $cinder::params::volume_service: }

}
