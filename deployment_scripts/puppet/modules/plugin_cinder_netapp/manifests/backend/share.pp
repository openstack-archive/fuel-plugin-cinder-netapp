define plugin_cinder_netapp::backend::share (
  $index,
  $shares = undef,
  $cinder_netapp,
) {

  $ip = $cinder_netapp['nfs_server_ip']
  $share = $cinder_netapp["nfs_server_share${index}"]
  $minus1 = $index - 1

  if ($minus1 == '0') {
    # last share is reached, write information into shares.conf
    file { '/etc/cinder/shares.conf':
      content => "${ip}:${share}\n${shares}",
      notify  => Service["$cinder::params::volume_service"],
    }
  } else {
    # recurse until index 1 is reached
    plugin_cinder_netapp::backend::share { "share-${minus1}":
      index         => $minus1,
      shares        => "${ip}:${share}\n${shares}",
      cinder_netapp => $cinder_netapp,
    }
  }
}
