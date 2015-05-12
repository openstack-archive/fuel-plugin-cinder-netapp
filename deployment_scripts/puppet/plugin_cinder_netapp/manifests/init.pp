class plugin_cinder_netapp
{
    include cinder::params

    #TODO: (Dmitry Ukov) improve logic as soon as multibackend is implemented
    if $::fuel_settings['cinder_netapp']['multibackend'] {
      $section = 'cinder_netapp'
    } else {
      $section = 'DEFAULT'
    }

    #Ensure that $ symbole is correctly escaped in netapp password
    $netapp_password = regsubst($::fuel_settings['cinder_netapp']['netapp_password'],'\$','$$','G')

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

    file { '/etc/cinder/shares.conf':
      content => "${::fuel_settings['cinder_netapp']['nfs_server_ip']}:${::fuel_settings['cinder_netapp']['nfs_server_share']}"
    } ->
    cinder::backend::netapp { 'cinder_netapp':
      netapp_login                 => $::fuel_settings['cinder_netapp']['netapp_login'],
      netapp_password              => $netapp_password,
      netapp_server_hostname       => $::fuel_settings['cinder_netapp']['netapp_server_hostname'],
      volume_backend_name          => $section,
      netapp_server_port           => $::fuel_settings['cinder_netapp']['netapp_server_port'],
      netapp_size_multiplier       => $::fuel_settings['cinder_netapp']['netapp_size_multiplier'],
      netapp_storage_family        => $::fuel_settings['cinder_netapp']['netapp_storage_family'],
      netapp_storage_protocol      => $::fuel_settings['cinder_netapp']['netapp_storage_protocol'],
      netapp_transport_type        => $::fuel_settings['cinder_netapp']['netapp_transport_type'],
      netapp_vfiler                => $::fuel_settings['cinder_netapp']['netapp_vfiler'],
      netapp_volume_list           => $::fuel_settings['cinder_netapp']['netapp_volume_list'],
      netapp_vserver               => $::fuel_settings['cinder_netapp']['netapp_vserver'],
      expiry_thres_minutes         => $::fuel_settings['cinder_netapp']['expiry_thres_minutes'],
      thres_avl_size_perc_start    => $::fuel_settings['cinder_netapp']['thres_avl_size_perc_start'],
      thres_avl_size_perc_stop     => $::fuel_settings['cinder_netapp']['thres_avl_size_perc_stop'],
      nfs_shares_config            => '/etc/cinder/shares.conf',
      netapp_copyoffload_tool_path => $::fuel_settings['cinder_netapp']['netapp_copyoffload_tool_path'],
      #netapp_controller_ips        => '',
      #netapp_sa_password           => '',
      #netapp_storage_pools         => '',
      #netapp_webservice_path       => '/devmgr/v2',
    } ~>
    service { $::cinder::params::volume_service:
    }
}
