..
 This work is licensed under a Creative Commons Attribution 3.0 Unported
 License.

 http://creativecommons.org/licenses/by/3.0/legalcode

=======================================
Fuel Cinder NetApp plugin specification
=======================================

Overview
--------
The plugin doesn't replace Cinder default backend in MOS but work in parallel. ``LVM over iSCSI`` and ``Ceph`` are two choices, which can be used as a default backend for Cinder. The plugin does not overwrite ``enabled_backends`` option that allows to use it with other plugins for Cinder backends. The plugin supports using up to 3 NetApp devices simultaneously. 7-Mode ONTAP Data support is disabled by default.

This repo contains all necessary files to build Cinder NetApp Fuel plugin.

Problem description
-------------------
This integration should be supported with the upstream version of Fuel product. Mirantis Openstack 9.1 release has Pluggable Architecture feature, that prevents developers from bringing any changes to the core product. Instead, the NetApp integration functionality can be implemented as a plugin for Fuel.

The plugin support following storage families:
 - Clustered Data ONTAP
 - SolidFire
 - E-Series/EF-Series
 - 7-Mode ONTAP Data (disabled by default)

User Story 1: Clustered Data ONTAP devices with NFS and iSCSI modes
-------------------------------------------------------------------
This case will provide availability to configure OpenStack compute instances to access Clustered Data ONTAP storage systems.
To enable this functionality following changes should be added.

Clustered Data ONTAP via NFS:
=============================
 * All cinder hosts should have following configuration in *<cinder.conf>*::

    [cinder_netapp]
      volume_backend_name = cinder_netapp
      volume_driver = cinder.volume.drivers.netapp.common.NetAppDriver
      netapp_login = LOGIN
      netapp_password = PASSWORD
      netapp_server_hostname = SERVER_HOSTNAME
      netapp_server_port =
      netapp_transport_type = TRANSPORT_TYPE
      netapp_storage_family = ontap_cluster
      netapp_storage_protocol = nfs
      nfs_shares_config = /etc/cinder/shares.conf
      netapp_vserver = VSERVER

  Where ``netapp_login``, ``netapp_password``, ``$netapp_server_hostname``, ``netapp_transport_type``, ``netapp_storage_family``, ``netapp_storage_protocol``, ``netapp_vserver`` should be configured through the Fuel Web UI in Cinder and NetApp integration section of the **Settings** tab.

 * All compute hosts should satisfy following requirements:

   - ``nfs-common`` should be installed
   - Ensure that ``nfs`` service is enabled and running in the system

Clustered Data ONTAP via iSCSI:
===============================
 * All cinder hosts should have following configuration in *<cinder.conf>*::

    [cinder_netapp]
      volume_backend_name = cinder_netapp
      volume_driver = cinder.volume.drivers.netapp.common.NetAppDriver
      netapp_login = LOGIN
      netapp_password = PASSWORD
      netapp_server_hostname = SERVER_HOSTNAME
      netapp_server_port =
      netapp_transport_type = TRANSPORT_TYPE
      netapp_storage_family = ontap_cluster
      netapp_storage_protocol = iscsi
      netapp_vserver = VSERVER

  Where ``netapp_login``, ``netapp_password``, ``$netapp_server_hostname``, ``netapp_transport_type``, ``netapp_storage_family``, ``netapp_storage_protocol``, ``netapp_vserver`` should be configured through the Fuel Web UI in Cinder and NetApp integration section of the **Settings** tab.

 * All compute hosts should satisfy following requirements:

   - ``open-iscsi`` and ``multipath-tools`` should be installed

User Story 2: Data ONTAP 7-Mode devices with NFS and iSCSI modes
----------------------------------------------------------------
This case will provide availability to configure OpenStack compute instances to access Data ONTAP 7-Mode storage systems. To enable this functionality following changes should be added:

Data ONTAP 7-Mode via NFS:
==========================
 * All cinder hosts should have following configuration in *<cinder.conf>*::

    [cinder_netapp]
      volume_backend_name = cinder_netapp
      volume_driver = cinder.volume.drivers.netapp.common.NetAppDriver
      netapp_login = LOGIN
      netapp_password = PASSWORD
      netapp_server_hostname = SERVER_HOSTNAME
      netapp_server_port =
      netapp_transport_type = TRANSPORT_TYPE
      netapp_storage_family = ontap_7mode
      netapp_storage_protocol = nfs
      nfs_shares_config = /etc/cinder/shares.conf
      netapp_vfiler = VFILTER

  Where ``netapp_login``, ``netapp_password``, ``$netapp_server_hostname``, ``netapp_transport_type``, ``netapp_storage_family``, ``netapp_storage_protocol``, ``netapp_vfilter`` should be configured through the Fuel Web UI in Cinder and NetApp integration section of the **Settings** tab.

 * All compute hosts should satisfy following requirements:

   - ``nfs-common`` should be installed.
   - Ensure that ``nfs`` service is enabled and running in the system

Data ONTAP 7-Mode via iSCSI:
============================
 * All cinder hosts should have following configuration in *<cinder.conf>*::

    [cinder_netapp]
      volume_backend_name = cinder_netapp
      volume_driver = cinder.volume.drivers.netapp.common.NetAppDriver
      netapp_login = LOGIN
      netapp_password = PASSWORD
      netapp_server_hostname = SERVER_HOSTNAME
      netapp_server_port =
      netapp_transport_type = TRANSPORT_TYPE
      netapp_storage_family = ontap_7mode
      netapp_storage_protocol = iscsi
      netapp_vfiler = VFILTER

  Where ``netapp_login``, ``netapp_password``, ``$netapp_server_hostname``, ``netapp_transport_type``, ``netapp_storage_family``, ``netapp_storage_protocol``, ``netapp_vfiler`` should be configured through the Fuel Web UI in Cinder and NetApp integration section of the **Settings** tab.

 * All compute hosts should satisfy following requirements:

   - ``open-iscsi`` and ``multipath-tools`` should be installed


User Story 3: SolidFire devices with iSCSI mode
--------------------------------------------------------
This case will provide availability to configure OpenStack compute instances to access SolidFire storage systems. To enable this functionality, the following changes should be added:

SolidFire via iSCSI:
=============================
 * All cinder hosts should have following configuration in *<cinder.conf>*::


    [cinder_netapp]
      sf_api_port = CLUSTER_ENDPOINT_PORT
      sf_svip =
      sf_volume_prefix = SF_VOLUME_PREFIX
      sf_enable_vag = False
      sf_account_prefix =
      sf_allow_template_caching = TEMPLATE_CACHING
      san_login = LOGIN
      sf_template_account_name = TEMPLATE_ACCOUNT
      san_password = PASSWORD
      sf_emulate_512 = True
      volume_driver = cinder.volume.drivers.solidfire.SolidFireDriver
      backend_host = str:netapp
      san_ip = CLUSTER_MVIP
      sf_enable_volume_mapping = True
      volume_backend_name = cinder_netapp_backend_2
      sf_allow_tenant_qos = False

  Where ``san_ip``, ``san_password``, ``san_login``  should be configured through the Fuel Web UI in Cinder and NetApp integration section of the **Settings** tab.


User Story 4: E-Series/EF-Series devices with iSCSI mode
--------------------------------------------------------
This case will provide availability to configure OpenStack compute instances to access E-Series/EF-Series storage systems. To enable this functionality following changes should be added:

E-Series/EF-Series via iSCSI:
=============================
 * All cinder hosts should have following configuration in *<cinder.conf>*::

    [cinder_netapp]
      volume_backend_name = cinder_netapp
      volume_driver = cinder.volume.drivers.netapp.common.NetAppDriver
      netapp_login = LOGIN
      netapp_password = PASSWORD
      netapp_server_hostname = SERVER_HOSTNAME
      netapp_server_port =
      netapp_transport_type = TRANSPORT_TYPE
      netapp_storage_family = eseries
      netapp_storage_protocol = iscsi
      netapp_host_type = linux_dm_mp
      netapp_controller_ips = CONTROLLER_IPS
      netapp_sa_password = SA_PASSWORD
      netapp_webservice_path= /devmgr/v2

  Where ``netapp_login``, ``netapp_password``, ``$netapp_server_hostname``, ``netapp_transport_type``, ``netapp_storage_family``, ``netapp_storage_protocol``, ``netapp_controller_ips``, ``netapp_sa_password`` should be configured through the Fuel Web UI in Cinder and NetApp integration section of the **Settings** tab.

 * All compute hosts should satisfy following requirements:

   - ``open-iscsi`` and ``multipath-tools`` should be installed


Affects
-------

REST API impact
===============
None.

Upgrade impact
==============
Upgrading should be tested explicitly with this plugin installed and NetApp storage enabled.

Security impact
===============
This plugin uses credentials that were used during NetApp storage setup. No impact on OpenStack services.

Notifications impact
====================
None.

Other end user impact
=====================
None.

Plugin impact
=============
This plugin should not impact other plugins until they do not modify the same settings for Cinder configuration.

Other deployer impact
=====================

Developer impact
================

Documentation Impact
====================
Reference to this plugin should be added to main Fuel documentation.

Implementation
--------------

Work Items
==========
* Create fuel-plugin-cinder-netapp plugin
* Develop the Fuel Web UI part of the plugin
* Add puppet support for all configuration cases
* Write documentation (User Guide)

Dependencies
============
* Ubuntu 14.04 support in MOS

Testing
-------
Plugin should pass functional tests executed manually.

Alternatives
---------------
There are no known alternatives for this plugin, although all steps can be performed manually.

References
----------
[1] http://netapp.github.io/openstack-deploy-ops-guide/liberty/content/section_cinder-configuration.html

[2] https://blueprints.launchpad.net/fuel/+spec/support-ubuntu-trusty
