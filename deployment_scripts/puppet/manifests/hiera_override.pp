# Since Fuel 8.0 has its own task to set Cinder volume-types. We add our modifications before this task is executed.

notice('MODULAR: netapp-hiera-override')

$cinder_netapp   = hiera_hash('cinder_netapp', {})

$hiera_dir    = '/etc/hiera/plugins'
$plugin_yaml  = 'cinder_netapp.yaml'
$plugin_name  = 'cinder_netapp'

file { $hiera_dir:
  ensure => directory,
}

file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file,
  content => template('plugin_cinder_netapp/cinder_netapp.yaml.erb'),
}
