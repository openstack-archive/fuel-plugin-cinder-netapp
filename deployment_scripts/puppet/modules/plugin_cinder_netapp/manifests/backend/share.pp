# this can be used to create recursively in shares for netapp volume backend
# [index] index of the current share
# [shares] shares previously created of the following format <ip>:<share1>\n><ip>:<share2>\n....
#
# === Examples
#
#  plugin_cinder_netapp::backend::share{ 'share1':
#    index => 1,
#    shares => 192.168.0.3:/vol1\n
#  }
#
define plugin_cinder_netapp::backend::share (
  $index,
  $shares = '',
) {

  $ip = $::fuel_settings['cinder_netapp']['nfs_server_ip']
  $share = $::fuel_settings['cinder_netapp']["nfs_server_share${index}"]
  $minus1 = inline_template('<%= index.to_i - 1 %>')

  if ($minus1 == '0') {
    # last share is reached, write information into shares.conf
    file { '/etc/cinder/shares.conf':
      content => "${ip}:${share}\n${shares}"
    } ~>
    service { $::cinder::params::volume_service: }
  } else {
    # recurse until index 1 is reached
    plugin_cinder_netapp::backend::share { "share-${minus1}":
      index  => $minus1,
      shares => "${ip}:${share}\n${shares}",
    }
  }
}
