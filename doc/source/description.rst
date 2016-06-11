=============
NetApp plugin
=============

The plugin provides support of ``Clustered Data ONTAP``, ``Data ONTAP 7-Mode`` and ``E-series`` storage clusters to Cinder.
The plugin uses NetApp unified driver, the latter is a
block storage driver that supports multiple storage families and protocols.
A storage family corresponds to storage systems built on different NetApp technologies
such as Clustered Data ONTAP, Data ONTAP operating in 7-Mode,
and E-Series.
The storage protocol refers to the protocol used to initiate data
storage and access operations on those storage systems like iSCSI and NFS.
The NetApp unified driver can be configured to provision and manage OpenStack volumes
on the given storage family using the specified storage protocol.
The OpenStack volumes can then be used for accessing and storing data with
the storage protocol on the storage family system.
The NetApp unified driver is an extensible interface that can support new
storage families and protocols.

Features
--------
* Clustered Data ONTAP as a backend for Cinder with NFS or iSCSI data-transfer protocols
* Data ONTAP 7-Mode as a backend for Cinder with NFS or iSCSI data-transfer protocols
* E-Series or EF-Series as a backend for Cinder with iSCSI data-transfer protocol
* Supports multi backend feature. The plugin does not overwrite ``enabled_backends`` option
  thereby allowing use other plugins for Cinder.
* Allows using NetApp as a backend for Cinder along with MOS default backends - ``LVM over iSCSI`` or ``Ceph``
* Supports all configuration options of NetApp Cinder driver for Liberty


Requirements
------------
======================= =================================
Requirement             Version/Comment
======================= =================================
Fuel                    8.0
NetApp Storage System   Clustered ONTAP Data

                        Data ONTAP 7-Mode

                        E-Series or EF-Series
======================= =================================


Prerequisites
-------------
* If you plan to use the plugin with **Data ONTAP 7-Mode** or **Clustered ONTAP Data**, please make sure
  that it is configured, up and running. For instructions, see `the official NetApp ONTAP documentation`_.


* If you plan to use the plugin with **E-Series** or **EF-Series**, please make sure that it
  is configured, up and running. For instructions, see `the official NetApp E-Series documentation`_.

Release Notes
-------------
* Added true support of multi backends
* Legacy of CentOS support for iSCSI was removed
* Added comments to source code
* Documentation is updated\fixed

Limitations
-----------
* Deployment fails if ``cinder`` role is not assigned to ``controller`` nodes
* Only one NetApp backend can be configured to work with Cinder
* Before creating Ubuntu repository's mirrors in Fuel, you have to manually add to /usr/share/fuel-mirror/ubuntu.yaml following packages:
  * nfs-common
  * open-iscsi
  * multipath-tools

.. _the official NetApp ONTAP documentation: http://mysupport.netapp.com/documentation/productlibrary/index.html?productID=30092
.. _the official NetApp E-Series documentation: https://mysupport.netapp.com/info/web/ECMP1658252.html
