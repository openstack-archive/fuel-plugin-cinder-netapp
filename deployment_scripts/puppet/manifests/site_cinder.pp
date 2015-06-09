$fuel_settings 			= parseyaml(file('/etc/astute.yaml'))
class {'plugin_cinder_netapp::cinder': }
