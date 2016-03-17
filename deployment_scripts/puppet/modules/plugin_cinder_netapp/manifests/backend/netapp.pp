define plugin_cinder_netapp::backend::netapp (
  $netapp_backend_name = $name,
  $cinder_netapp       = $plugin_cinder_netapp::params::cinder_netapp,
  $backend_name        = undef,
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
    netapp_vfiler                => $cinder_netapp['netapp_vfiler'],
    netapp_controller_ips        => $cinder_netapp['netapp_controller_ips'],
    netapp_sa_password           => $cinder_netapp['netapp_sa_password'],
    thres_avl_size_perc_start    => $cinder_netapp['thres_avl_size_perc_start'],
    thres_avl_size_perc_stop     => $cinder_netapp['thres_avl_size_perc_stop'],
    expiry_thres_minutes         => $cinder_netapp['expiry_thres_minutes'],
    netapp_copyoffload_tool_path => $cinder_netapp['netapp_copyoffload_tool_path'],
    nfs_mount_options            => $cinder_netapp['nfs_mount_options'],
  }

  # Use it while NetApp driver changes are not implemented in Fuel-library
  if ($cinder_netapp['netapp_storage_family']) == 'eseries' {
    $host_type = $cinder_netapp['netapp_eseries_host_type']
  } else {
    $host_type = $cinder_netapp['netapp_host_type']
  }

  if ($cinder_netapp['netapp_lun_space_reservation']) {
    $lun_space_reservation = 'enabled'
  } else {
    $lun_space_reservation = 'disabled'
  }

  cinder_config {
    "$netapp_backend_name/host":                            value => 'str:netapp'; # for NetApp HA
    "$netapp_backend_name/netapp_host_type":                value => $host_type;
    "$netapp_backend_name/netapp_lun_space_reservation":    value => $lun_space_reservation;
    "$netapp_backend_name/netapp_lun_ostype":               value => $cinder_netapp['netapp_lun_ostype'];
    "$netapp_backend_name/use_multipath_for_image_xfer":    value => $cinder_netapp['use_multipath_for_image_xfer'];
    "$netapp_backend_name/netapp_enable_multiattach":       value => $cinder_netapp['netapp_enable_multiattach'];
    "$netapp_backend_name/netapp_pool_name_search_pattern": value => $cinder_netapp['netapp_pool_name_search_pattern'];
    "$netapp_backend_name/reserved_percentage":             value => $cinder_netapp['reserved_percentage'];
    "$netapp_backend_name/max_oversubscription_ratio":      value => $cinder_netapp['max_oversubscription_ratio'];
  }
  # ^^^

  if ($cinder_netapp['multibackend']) {
    cinder_config {
      'DEFAULT/enabled_backends': value => "${backend_name},${netapp_backend_name}";
      'DEFAULT/scheduler_driver': value => 'cinder.scheduler.filter_scheduler.FilterScheduler';
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

  # To create a root volume during an instance spawning
  if ($cinder_netapp['netapp_storage_protocol']) == 'iscsi' {
    package { 'open-iscsi':
      before => Cinder::Backend::Netapp[$netapp_backend_name],
    }
  }

}
