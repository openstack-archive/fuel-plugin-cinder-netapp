# this can be used to create a netapp volume backend for cinder
#
# [section] name of the section of cinder.conf on which netapp parameters should be inserted
# [backends] name of the other backends in a multibackend config (optional)
#
# === Examples
#
#  plugin_cinder_netapp::backend::netapp{ 'netapp':
#    backends => Lvm1,
#  }
#
define plugin_cinder_netapp::backend::netapp (
  $section       = $name,
  $backends      = '',
  $backend_name  = 'cinder_netapp',
  $mutlibackends = false,
  $cinder_node   = false,
) {

  include cinder::client

  # Ensure that $ symbole is correctly escaped in netapp password
  $netapp_password = regsubst($::fuel_settings['cinder_netapp']['netapp_password'],'\$','$$','G')

  cinder::backend::netapp { $backend_name:
    volume_backend_name          => $section,
    netapp_login                 => $::fuel_settings['cinder_netapp']['netapp_login'],
    netapp_password              => $netapp_password,
    netapp_server_hostname       => $::fuel_settings['cinder_netapp']['netapp_server_hostname'],
    netapp_server_port           => $::fuel_settings['cinder_netapp']['netapp_server_port'],
    netapp_transport_type        => $::fuel_settings['cinder_netapp']['netapp_transport_type'],
    netapp_storage_family        => $::fuel_settings['cinder_netapp']['netapp_storage_family'],
    netapp_storage_protocol      => $::fuel_settings['cinder_netapp']['netapp_storage_protocol'],
    netapp_vserver               => $::fuel_settings['cinder_netapp']['netapp_vserver'],
    netapp_controller_ips        => $::fuel_settings['cinder_netapp']['netapp_controller_ips'],
    netapp_sa_password           => $::fuel_settings['cinder_netapp']['netapp_sa_password'],
    netapp_storage_pools         => $::fuel_settings['cinder_netapp']['netapp_storage_pools'],
    netapp_size_multiplier       => $::fuel_settings['cinder_netapp']['netapp_size_multiplier'],
    netapp_vfiler                => $::fuel_settings['cinder_netapp']['netapp_vfiler'],
    netapp_volume_list           => $::fuel_settings['cinder_netapp']['netapp_volume_list'],
    expiry_thres_minutes         => $::fuel_settings['cinder_netapp']['expiry_thres_minutes'],
    thres_avl_size_perc_start    => $::fuel_settings['cinder_netapp']['thres_avl_size_perc_start'],
    thres_avl_size_perc_stop     => $::fuel_settings['cinder_netapp']['thres_avl_size_perc_stop'],
    netapp_copyoffload_tool_path => $::fuel_settings['cinder_netapp']['netapp_copyoffload_tool_path'],
    nfs_mount_options            => $::fuel_settings['cinder_netapp']['nfs_mount_options'],
  }

  $index = $::fuel_settings['cinder_netapp']['nb_share']

  if $mutlibackends {
    cinder_config {
      'DEFAULT/enabled_backends': value => "${backends},${backend_name}";
    }
  } else {
    cinder_config {
      'DEFAULT/enabled_backends': value => "${backend_name}";
    }
  }

  if $cinder_node {
    plugin_cinder_netapp::backend::share{ "share-${index}":
      index => $index
    }
  }

}
