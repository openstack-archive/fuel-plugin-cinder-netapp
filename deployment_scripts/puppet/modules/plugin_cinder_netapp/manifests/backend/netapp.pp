define plugin_cinder_netapp::backend::netapp (
  $netapp_backend_name = $name,
  $cinder_netapp       = $plugin_cinder_netapp::params::cinder_netapp,
  $default_backend     = undef,
) {

  include plugin_cinder_netapp::params
  include cinder::client

  # Ensure that $ symbole is correctly escaped in netapp password
  $netapp_password = regsubst($cinder_netapp['netapp_password'],'\$','$$','G')

  cinder::backend::netapp { "$netapp_backend_name":
    volume_backend_name          => 'cinder_netapp',
    netapp_login                 => $cinder_netapp['netapp_login'],
    netapp_password              => $netapp_password,
    netapp_server_hostname       => $cinder_netapp['netapp_server_hostname'],
    netapp_server_port           => $cinder_netapp['netapp_server_port'],
    netapp_transport_type        => $cinder_netapp['netapp_transport_type'],
    netapp_storage_family        => $cinder_netapp['netapp_storage_family'],
    netapp_storage_protocol      => $cinder_netapp['netapp_storage_protocol'],
    netapp_vserver               => $cinder_netapp['netapp_vserver'],
    netapp_controller_ips        => $cinder_netapp['netapp_controller_ips'],
    netapp_sa_password           => $cinder_netapp['netapp_sa_password'],
    netapp_storage_pools         => $cinder_netapp['netapp_storage_pools'],
    netapp_size_multiplier       => $cinder_netapp['netapp_size_multiplier'],
    netapp_vfiler                => $cinder_netapp['netapp_vfiler'],
    netapp_volume_list           => $cinder_netapp['netapp_volume_list'],
    expiry_thres_minutes         => $cinder_netapp['expiry_thres_minutes'],
    thres_avl_size_perc_start    => $cinder_netapp['thres_avl_size_perc_start'],
    thres_avl_size_perc_stop     => $cinder_netapp['thres_avl_size_perc_stop'],
    netapp_copyoffload_tool_path => $cinder_netapp['netapp_copyoffload_tool_path'],
    nfs_mount_options            => $cinder_netapp['nfs_mount_options'],
  }

  cinder_config {
    'DEFAULT/host': value => 'str:netapp';
  }

  if ($cinder_netapp['mutlibackend']) {
    cinder_config {
      'DEFAULT/enabled_backends': value => "${default_backend},${netapp_backend_name}";
    }
  }

  if ($cinder_netapp['netapp_storage_protocol']) == 'nfs' {
    package { 'nfs-common':
      before => Cinder::Backend::Netapp[$netapp_backend_name],
    }

    $index = $cinder_netapp['nb_share']
    plugin_cinder_netapp::backend::share { "share-$index":
      index         => $index,
      cinder_netapp => $cinder_netapp,
    }
  }

}
