# Defined type form upstream puppet cinder module is not used because is outdated and doesn't support last changes in Cinder NetApp driver.
# It's actual for Mitaka upstream puppet cinder module

define plugin_cinder_netapp::backend::netapp (
  $netapp_backend_name    = "netapp_backend_${name}",
  $cinder_netapp          = $plugin_cinder_netapp::params::cinder_netapp,
  $nfs_shares_config      = "/etc/cinder/shares_${name}.conf",
  $netapp_webservice_path = '/devmgr/v2',
) {

if ($cinder_netapp["netapp_storage_family${name}"] in ['eseries', 'ontap_cluster']) {

  include plugin_cinder_netapp::params
  include cinder::params

  # Sets correct parameter for <host_type> depending on storage family
  if ($cinder_netapp["netapp_storage_family${name}"]) == 'eseries' {
    $host_type = $cinder_netapp["netapp_eseries_host_type${name}"]
  } else {
    $host_type = $cinder_netapp["netapp_host_type${name}"]
  }

  # NetApp driver does not understand boolean types for <lun_space_reservation> parameter
  if ($cinder_netapp["netapp_lun_space_reservation${name}"]) {
    $lun_space_reservation = 'enabled'
  } else {
    $lun_space_reservation = 'disabled'
  }

  # Sets up NFS shares
  if ($cinder_netapp["netapp_storage_protocol${name}"]) == 'nfs' {
    if ! defined( Package['nfs-common'] ) {
      package { 'nfs-common': }
    }

    $shares = get_nfs_shares($cinder_netapp, $name)

    file { $nfs_shares_config:
      content => $shares,
      notify  => Service[${cinder::params::volume_service}],
    }
  }

  # We need following packages to create a root volume during an instance spawning
  if ($cinder_netapp["netapp_storage_protocol${name}"]) == 'iscsi' {
    if ! defined( Package['open-iscsi'] ) {
      package { 'open-iscsi': }
    }

    if ($cinder_netapp['use_multipath_for_image_xfer']) {
      if ! defined( Package['multipath-tools'] ) {
        package { 'multipath-tools': }
      }
    }
  }

  # To be ensure that $ symbol is correctly escaped in netapp password
  $netapp_password = regsubst($cinder_netapp["netapp_password${name}"],'\$','$$','G')


  Cinder_config <||> -> Plugin_cinder_netapp::Backend::Enable_backend[$netapp_backend_name] ~> Service <||>
  Cinder_config <||> ~> Service <||>

  cinder_config {
    "$netapp_backend_name/volume_backend_name":             value => "cinder_netapp_backend_${name}";
    "$netapp_backend_name/volume_driver":                   value => 'cinder.volume.drivers.netapp.common.NetAppDriver';
    "$netapp_backend_name/netapp_login":                    value => $cinder_netapp["netapp_login${name}"];
    "$netapp_backend_name/netapp_password":                 value => $netapp_password;
    "$netapp_backend_name/netapp_server_hostname":          value => $cinder_netapp["netapp_server_hostname${name}"];
    "$netapp_backend_name/netapp_server_port":              value => $cinder_netapp["netapp_server_port${name}"];
    "$netapp_backend_name/netapp_transport_type":           value => $cinder_netapp["netapp_transport_type${name}"];
    "$netapp_backend_name/netapp_storage_family":           value => $cinder_netapp["netapp_storage_family${name}"];
    "$netapp_backend_name/netapp_storage_protocol":         value => $cinder_netapp["netapp_storage_protocol${name}"];
    "$netapp_backend_name/netapp_vserver":                  value => $cinder_netapp["netapp_vserver${name}"];
    "$netapp_backend_name/netapp_vfiler":                   value => $cinder_netapp["netapp_vfiler${name}"];
    "$netapp_backend_name/netapp_controller_ips":           value => $cinder_netapp["netapp_controller_ips${name}"];
    "$netapp_backend_name/netapp_sa_password":              value => $cinder_netapp["netapp_sa_password${name}"];
    "$netapp_backend_name/netapp_webservice_path":          value => $netapp_webservice_path;
    "$netapp_backend_name/nfs_shares_config":               value => $nfs_shares_config;
    "$netapp_backend_name/thres_avl_size_perc_start":       value => $cinder_netapp["thres_avl_size_perc_start${name}"];
    "$netapp_backend_name/thres_avl_size_perc_stop":        value => $cinder_netapp["thres_avl_size_perc_stop${name}"];
    "$netapp_backend_name/expiry_thres_minutes":            value => $cinder_netapp["expiry_thres_minutes${name}"];
    "$netapp_backend_name/netapp_copyoffload_tool_path":    value => $cinder_netapp["netapp_copyoffload_tool_path${name}"];
    "$netapp_backend_name/netapp_host_type":                value => $host_type;
    "$netapp_backend_name/netapp_lun_space_reservation":    value => $lun_space_reservation;
    "$netapp_backend_name/netapp_lun_ostype":               value => $cinder_netapp["netapp_lun_ostype${name}"];
    "$netapp_backend_name/use_multipath_for_image_xfer":    value => $cinder_netapp["use_multipath_for_image_xfer"];
    "$netapp_backend_name/netapp_enable_multiattach":       value => $cinder_netapp["netapp_enable_multiattach${name}"];
    "$netapp_backend_name/netapp_pool_name_search_pattern": value => $cinder_netapp["netapp_pool_name_search_pattern${name}"];
    "$netapp_backend_name/reserved_percentage":             value => $cinder_netapp["reserved_percentage${name}"];
    "$netapp_backend_name/max_oversubscription_ratio":      value => $cinder_netapp["max_oversubscription_ratio${name}"];
    "$netapp_backend_name/nfs_mount_options":               value => $cinder_netapp["nfs_mount_options"];
    "$netapp_backend_name/backend_host":                    value => 'str:netapp'; # for NetApp HA
  }

  # Adds the backend in <enabled_backends> parameter
  plugin_cinder_netapp::backend::enable_backend { $netapp_backend_name : }

  if ! defined( Service ) {
    service { ${cinder::params::volume_service}: }
  }
}
}
