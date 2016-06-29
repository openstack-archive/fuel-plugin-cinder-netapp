# Defined type form upstream puppet cinder module is not used because is outdated and doesn't support last changes in Cinder NetApp driver.

class plugin_cinder_netapp::backend::netapp (
  $backend_name 	  = 'netapp',
  $cinder_netapp          = $plugin_cinder_netapp::cinder_netapp,
  $nfs_shares_config      = '/etc/cinder/shares.conf',
  $netapp_webservice_path = '/devmgr/v2',
) {

  include cinder::params

  #compatibility
  $netapp_backend_name    = $backend_name
  # Sets correct parameter for <host_type> depending on storage family
  if ($cinder_netapp['netapp_storage_family']) == 'eseries' {
    $host_type = $cinder_netapp['netapp_eseries_host_type']
  } else {
    $host_type = $cinder_netapp['netapp_host_type']
  }

  # NetApp driver does not understand boolean types for <lun_space_reservation> parameter
  if ($cinder_netapp['netapp_lun_space_reservation']) {
    $lun_space_reservation = 'enabled'
  } else {
    $lun_space_reservation = 'disabled'
  }

  # Sets up NFS shares
  if ($cinder_netapp['netapp_storage_protocol']) == 'nfs' {
    package { 'nfs-common': }

    $shares = get_nfs_shares($cinder_netapp)

    file { $nfs_shares_config:
      content => $shares,
      notify  => Service["$cinder::params::volume_service"],
    }
  }

  # We need following packages to create a root volume during an instance spawning
  if ($cinder_netapp['netapp_storage_protocol']) == 'iscsi' {
#    package { 'open-iscsi': }

    if ($cinder_netapp['use_multipath_for_image_xfer']) {
      package { 'multipath-tools': }
    }
  }

  # To be ensure that $ symbol is correctly escaped in netapp password
  $netapp_password = regsubst($cinder_netapp['netapp_password'],'\$','$$','G')


  Cinder_config <||> -> Plugin_cinder_netapp::Backend::Enable_backend[$netapp_backend_name] ~> Service <||>

  cinder_config {
    "$netapp_backend_name/volume_backend_name":             value => $backend_name;
    "$netapp_backend_name/volume_driver":                   value => 'cinder.volume.drivers.netapp.common.NetAppDriver';
    "$netapp_backend_name/netapp_login":                    value => $cinder_netapp['netapp_login'];
    "$netapp_backend_name/netapp_password":                 value => $netapp_password;
    "$netapp_backend_name/netapp_server_hostname":          value => $cinder_netapp['netapp_server_hostname'];
    "$netapp_backend_name/netapp_server_port":              value => $cinder_netapp['netapp_server_port'];
    "$netapp_backend_name/netapp_transport_type":           value => $cinder_netapp['netapp_transport_type'];
    "$netapp_backend_name/netapp_storage_family":           value => $cinder_netapp['netapp_storage_family'];
    "$netapp_backend_name/netapp_storage_protocol":         value => $cinder_netapp['netapp_storage_protocol'];
    "$netapp_backend_name/netapp_vserver":                  value => $cinder_netapp['netapp_vserver'];
    "$netapp_backend_name/netapp_vfiler":                   value => $cinder_netapp['netapp_vfiler'];
    "$netapp_backend_name/netapp_controller_ips":           value => $cinder_netapp['netapp_controller_ips'];
    "$netapp_backend_name/netapp_sa_password":              value => $cinder_netapp['netapp_sa_password'];
    "$netapp_backend_name/netapp_webservice_path":          value => $netapp_webservice_path;
    "$netapp_backend_name/nfs_shares_config":               value => $nfs_shares_config;
    "$netapp_backend_name/thres_avl_size_perc_start":       value => $cinder_netapp['thres_avl_size_perc_start'];
    "$netapp_backend_name/thres_avl_size_perc_stop":        value => $cinder_netapp['thres_avl_size_perc_stop'];
    "$netapp_backend_name/expiry_thres_minutes":            value => $cinder_netapp['expiry_thres_minutes'];
    "$netapp_backend_name/netapp_copyoffload_tool_path":    value => $cinder_netapp['netapp_copyoffload_tool_path'];
    "$netapp_backend_name/netapp_host_type":                value => $host_type;
    "$netapp_backend_name/netapp_lun_space_reservation":    value => $lun_space_reservation;
    "$netapp_backend_name/netapp_lun_ostype":               value => $cinder_netapp['netapp_lun_ostype'];
    "$netapp_backend_name/use_multipath_for_image_xfer":    value => $cinder_netapp['use_multipath_for_image_xfer'];
    "$netapp_backend_name/netapp_enable_multiattach":       value => $cinder_netapp['netapp_enable_multiattach'];
    "$netapp_backend_name/netapp_pool_name_search_pattern": value => $cinder_netapp['netapp_pool_name_search_pattern'];
    "$netapp_backend_name/reserved_percentage":             value => $cinder_netapp['reserved_percentage'];
    "$netapp_backend_name/max_oversubscription_ratio":      value => $cinder_netapp['max_oversubscription_ratio'];
    "$netapp_backend_name/nfs_mount_options":               value => $cinder_netapp['nfs_mount_options'];
    "$netapp_backend_name/backend_host":                    value => 'str:netapp'; # for NetApp HA
  }

  # Adds the backend in <enabled_backends> parameter
  plugin_cinder_netapp::backend::enable_backend { $netapp_backend_name: }
}
