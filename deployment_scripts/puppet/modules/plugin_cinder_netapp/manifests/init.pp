class plugin_cinder_netapp (
) inherits plugin_cinder_netapp::params {

  class { $netapp_backend_class: }
}
