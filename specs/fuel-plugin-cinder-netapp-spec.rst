..
 This work is licensed under a Creative Commons Attribution 3.0 Unported
 License.

 http://creativecommons.org/licenses/by/3.0/legalcode

=======================================
Fuel Cinder NetApp plugin specification
=======================================

Overview
--------

NetApp plugin can replace the Cinder LVM backend by Cinder Netapp Backend or work in parallel when deployed with multi-backend enabled. LVM is the default volume backend that uses local volumes managed by LVM.

This repo contains all necessary files to build Cinder NetApp Fuel plugin.

Problem description
===================

This integration should be supported with the upstream version of Fuel product. Mirantis Openstack 8.0 release has Pluggable Architecture feature, that prevents developers from bringing any changes to the core product. Instead, the NetApp integration functionality can be implemented as a plugin for Fuel.

The plugin support following storage famillies:
 - ONTAP with Cluster Mode and 7 Mode
 - E-series

User Story 1: ONTAP devices with all modes
---------------------------------------------------

This case will provide availability to configure OpenStack compute instances to access Data ONTAP storage systems. To enable this functionality following changes should be added:

ONTAP with Cluster Mode via NFS:

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

ONTAP with Cluster Mode via iSCSI:

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

ONTAP with 7 Mode via NFS:

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

ONTAP with 7 Mode via iSCSI:

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

User Story 2: E-series devices
-------------------------------------------------------------

This case will provide availability to configure OpenStack compute instances to access E-series storage systems. To enable this functionality following changes should be added:

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

Alternatives
---------------

There are no known alternatives for this plugin, although all steps can be performed manually.

REST API impact
---------------

None.

Upgrade impact
--------------

Upgrading should be tested explicitly with this plugin installed and NetApp storage cluster enabled.

Security impact
---------------

This plugin uses credentials that were used during NetApp cluster setup. No inpact on OpenStack services.

Notifications impact
--------------------

None.

Other end user impact
---------------------

None.

Plugin impact
-------------

This plugin should not impact other plugins until they do not modify the same settings for Cinder configuration.

Other deployer impact
---------------------

Developer impact
----------------


Implementation
==============

Work Items
----------

* Create fuel-plugin-cinder-netapp plugin

* Develop the Fuel Web UI part of the plugin

* Add puppet support for all configuration cases

* Write documentation (User Guide)

Dependencies
============

* Ubuntu 14.04 support in MOS

Testing
========

Plugin should pass tempest framework tests.

Documentation Impact
====================

Reference to this plugin should be added to main Fuel documentation.

References
==========

[1] http://docs.openstack.org/icehouse/config-reference/content/netapp-volume-driver.html
[2] https://blueprints.launchpad.net/fuel/+spec/support-ubuntu-trusty
