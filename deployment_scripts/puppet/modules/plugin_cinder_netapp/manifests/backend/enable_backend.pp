define plugin_cinder_netapp::backend::enable_backend (
  $config_file = $plugin_cinder_netapp::config_file
) {

  ini_subsetting {"enable_${name}_backend":
    ensure               => present,
    section              => 'DEFAULT',
    key_val_separator    => '=',
    path                 => $config_file,
    setting              => 'enabled_backends',
    subsetting           => $name,
    subsetting_separator => ',',
  }
}
