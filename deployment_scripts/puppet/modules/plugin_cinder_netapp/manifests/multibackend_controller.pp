# this can be used to insert into cinder_iscsi section lvm configuration parameters
# and setup multibaclend configuration conttroller
#
# [$cinder_user_password] password of the cinder user
# [$keystone_tenant] tenant services
# [$keystone_user] name of the cinder user
# [$keystone_auth_protocol] auth protocol for keystone
# [$auth_host] ip/hostname for kauthentication endpoint
# [$keystone_auth_port] nport for keystone
#
# === Examples
#
#  class { 'plugin_cinder_netapp::backend::iscsi':
#    $cinder_user_password   = 'password',
#    $keystone_tenant        = 'services',
#    $keystone_user          = 'cinder',
#    $keystone_auth_protocol = 'http',
#    $auth_host              = '127.0.0.1',
#    $keystone_auth_port     = '35357',  ,
#  }
#
class plugin_cinder_netapp::multibackend_controller(
  $cinder_user_password,
  $keystone_tenant        = 'services',
  $keystone_user          = 'cinder',
  $keystone_auth_protocol = 'http',
  $auth_host,
  $keystone_auth_port     = '35357',
  $os_region_name         = 'RegionOne',
)inherits plugin_cinder_netapp::params {
    include cinder::params
    $os_auth_url  = "${keystone_auth_protocol}://${auth_host}:${keystone_auth_port}/v2.0/"
    Plugin_cinder_netapp::Cinder::Type {
      os_password     => $cinder_user_password,
      os_tenant_name  => $keystone_tenant,
      os_username     => $keystone_user,
      os_auth_url     => $os_auth_url,
      os_region_name  => $os_region_name
    }
    #TODO use type from cinder module when bug 1461485 is fix
    class { $plugin_cinder_netapp::params::backend_class :} ->
    plugin_cinder_netapp::backend::netapp{ "cinder_netapp":
        backends => $plugin_cinder_netapp::params::backends,
        mutlibackends => true
    }->
    plugin_cinder_netapp::cinder::type {'netapp':
      set_key   => 'volume_backend_name',
      set_value => 'cinder_netapp'
    }->
    plugin_cinder_netapp::cinder::type {"${plugin_cinder_netapp::params::backends}":
      set_key   => 'volume_backend_name',
      set_value => "${plugin_cinder_netapp::params::backends}",
    }
}
