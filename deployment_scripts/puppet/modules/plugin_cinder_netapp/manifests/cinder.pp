# The plugin_cinder_netapp class is able to inder to use netapp as a storage backend
# (7Mode and cluster mode storage familly). If the multibackend option is checked
# cinder will used the netapp backend and the ceph or lvm (according to intial configuration)
# as multibackend storage
#
class plugin_cinder_netapp::cinder
inherits plugin_cinder_netapp::params {
    $cinder_hash = $::fuel_settings['cinder']
    if $::fuel_settings['cinder_netapp']['multibackend'] {
      class { 'plugin_cinder_netapp::multibackend_cinder':} 
    } else {
      $section = 'DEFAULT'
      plugin_cinder_netapp::backend::netapp{ "cinder_netapp":
        section => $section,
        cinder_node  => true
      } 
   }
}
