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
#      netapp_server_port           => '80',
#      netapp_size_multiplier       => '1.2',
#      netapp_storage_family        => 'ontap_cluster',
      netapp_storage_protocol      => 'nfs',
#      netapp_transport_type        => 'http',
#      netapp_vfiler                => '',
#      netapp_volume_list           => '',
      netapp_vserver               => $::fuel_settings['cinder_netapp']['netapp_vserver'],
#      expiry_thres_minutes         => '720',
#      thres_avl_size_perc_start    => '20',
#      thres_avl_size_perc_stop     => '60',
      nfs_shares_config            => '/etc/cinder/shares.conf',
#      netapp_copyoffload_tool_path => '',
#      netapp_controller_ips        => '',
#      netapp_sa_password           => '',
#      netapp_storage_pools         => '',
#      netapp_webservice_path       => '/devmgr/v2',
    } ~>
    service { $::cinder::params::volume_service:
    }

}


