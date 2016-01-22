# this can be used to insert into cinder_iscsi section lvm configuration parameters
#

class plugin_cinder_netapp::multibackend_cinder {

  include plugin_cinder_netapp::params
  include cinder::params

  class { $plugin_cinder_netapp::params::backend_class: } ->
  plugin_cinder_netapp::backend::netapp{ 'cinder_netapp':
    backends      => $plugin_cinder_netapp::params::backends,
    mutlibackends => true,
    cinder_node   => true,
  }

}
