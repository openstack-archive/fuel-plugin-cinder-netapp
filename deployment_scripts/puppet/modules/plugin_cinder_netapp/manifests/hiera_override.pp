define plugin_cinder_netapp::hiera_override (
  $volume_backend_name = $name,
  $backend = undef,
) {

  $hiera_dir    = '/etc/hiera/override'
  $plugin_yaml  = 'cinder_netapp.yaml'
  $plugin_name  = 'cinder_netapp'
  $backend_name = regsubst($backend, 'cinder_', '', 'G')

  $content = inline_template('
storage_hash:
  volume_backend_names:
    <%= @volume_backend_name %>: false
    netapp: cinder_netapp
<% if @backend -%>
    <%= @backend_name %>: <%= @backend %>
<% end -%>
')

  file { "$hiera_dir":
    ensure  => directory,
  }

  file { "${hiera_dir}/${plugin_yaml}":
    ensure  => file,
    content => $content,
    require => File[$hiera_dir],
  }

  file_line {"${plugin_name}_hiera_override":
    path  => '/etc/hiera.yaml',
    line  => "    - override/${plugin_name}",
    after => '    - "override/module/%{calling_module}"',
  }
}
