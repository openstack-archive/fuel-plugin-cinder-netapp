# this can be used to insert into cinder_iscsi section lvm configuration parameters
#
# [iscsi_ip_address] The IP address that the iSCSI daemon is listening on
# [iscsi_helper] iSCSI target user-land tool to use
# [volume_group] Name for the VG that will contain exported volumes
#
# === Examples
#
#  class { 'plugin_cinder_netapp::backend::iscsi':
#  $iscsi_ip_address = '127.0.0.1',
#  $iscsi_helper,
#  $volume_group     = 'cinder' ,
#  }
#
class plugin_cinder_netapp::backend::iscsi (
  $volume_group     = 'cinder',
  $iscsi_ip_address =  $::internal_address,
  $iscsi_helper     =  $::cinder::params::iscsi_helper,
) {

  cinder_config {
    'cinder_iscsi/volume_backend_name': value => 'cinder_iscsi';
    'cinder_iscsi/iscsi_ip_address':    value => $iscsi_ip_address;
    'cinder_iscsi/iscsi_helper':        value => $iscsi_helper;
    'cinder_iscsi/volume_group':        value => $volume_group;
  }

}
