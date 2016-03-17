notice('MODULAR: netapp-hiera-override')

$cinder_netapp = hiera_hash('cinder_netapp', {})
$multibackend  = $cinder_netapp['multibackend']

$hiera_dir    = '/etc/hiera/plugins'
$plugin_yaml  = 'cinder_netapp.yaml'
$plugin_name  = 'cinder_netapp'


$content = inline_template('
storage_hash:
  volume_backend_names:
    netapp: cinder_netapp
<% if ! @multibackend -%>
    volumes_lvm: false
    volumes_ceph: false
<% end -%>
')

file { "$hiera_dir":
  ensure => directory,
}

file { "${hiera_dir}/${plugin_yaml}":
  ensure  => file,
  content => $content,
  require => File[$hiera_dir],
}
