# The plugin_cinder_netapp class is able to inder to use netapp as a storage backend
# (7Mode and cluster mode storage familly). If the multibackend option is checked
# cinder will used the netapp backend and the ceph or lvm (according to intial configuration)
# as multibackend storage
#
class plugin_cinder_netapp::controller
inherits plugin_cinder_netapp::params {

    cinder_config {
      "DEFAULT/host": value => "str:netapp";
    }

    $cinder_hash = $::fuel_settings['cinder']
    if $::fuel_settings['cinder_netapp']['multibackend'] {
      class { 'plugin_cinder_netapp::multibackend_controller':
        cinder_user_password => $cinder_hash[user_password],
        auth_host            => hiera('management_vip', undef)
      } 
    } else {
      $section = 'DEFAULT'
      plugin_cinder_netapp::backend::netapp{ "cinder_netapp":
        section => $section
      } 
   }
}
