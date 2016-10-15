#    Copyright 2015 SolidFire, Inc.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#


define plugin_cinder_netapp::backend::solidfire (
  $netapp_backend_name    = "netapp_backend_$name",
  $cinder_netapp          = $plugin_cinder_netapp::params::cinder_netapp,
) {

if ($cinder_netapp["netapp_storage_family$name"] in ['solidfire']) {

  include cinder::params
  include cinder::client

  if ! defined( Package['open-iscsi'] ) {
    package { 'open-iscsi': }
  }

  Cinder::Backend::Solidfire <||> -> Plugin_cinder_netapp::Backend::Enable_backend[$netapp_backend_name] ~> Service <||>

  cinder::backend::solidfire { $netapp_backend_name :
    san_ip                    => $cinder_netapp['solidfire_mvip'],
    san_login                 => $cinder_netapp['solidfire_admin_login'],
    san_password              => $cinder_netapp['solidfire_admin_password'],
    volume_backend_name       => "cinder_netapp_backend_$name",
    sf_emulate_512            => 'true',
    sf_api_port               => $cinder_netapp['solidfire_api_port'],
    sf_account_prefix         => $cinder_netapp['solidfire_account_prefix'],
    sf_allow_template_caching => $cinder_netapp['solidfire_allow_template_caching'],
    sf_template_account_name  => $cinder_netapp['solidfire_template_account'],
    sf_volume_prefix          => $cinder_netapp['solidfire_volume_prefix'],
    extra_options             => { "${netapp_backend_name}/host" => { value => $netapp_backend_name },},
  }

  # Adds the backend in <enabled_backends> parameter
  plugin_cinder_netapp::backend::enable_backend { $netapp_backend_name: }

  if ! defined( Service ) {
    service { $cinder::params::volume_service: }
  }
}
}
