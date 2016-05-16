NetApp plugin
=============

NetApp plugin provides support of ONTAP and E-series storage clusters to Cinder.
NetApp plugin uses NetApp unified driver; the latter is a
block storage driver that supports multiple storage families and protocols.
A storage family corresponds to storage systems built on different NetApp technologies
such as clustered Data ONTAP, Data ONTAP operating in 7-Mode,
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
* ONTAP Clustered Mode as a backend for Cinder with NFS or iSCSI data-transfer protocols
* ONTAP 7 Mode as a backend for Cinder with NFS or iSCSI data-transfer protocols
* E-Series as a backend for Cinder with iSCSI data-transfer protocol
* Multibackend: A supported NetApp storage with any default Cinder backend, either LVM over iSCSI or Ceph
* Supports all NetApp driver options to be configured


Requirements
------------
======================= =================================
Requirement             Version/Comment
======================= =================================
Fuel                    8.0
ONTAP or E-Series       All storage family is supported.
======================= =================================


Prerequisites
-------------
* If you plan to use the plugin with **ONTAP**, please make sure that it
  is configured, up and running. For instructions, see `the official
  NetApp ONTAP documentation  <http://mysupport.netapp.com/documentation/productlibrary/index.html?productID=30092>`_.


* If you plan to use the plugin with **E-Series**, please make sure that it
  is configured, up and running. For instructions, see `the official
  NetApp E-Series documentation <https://mysupport.netapp.com/info/web/ECMP1658252.html>`_.

Release Nodes
-------------
* The plugin has been totally refactored to accordance with changes in OpenStack Liberty and MOS 8.0
* All documented features of NetApp Cinder Driver are configurable
* Plugin can change Cinder settings after deployment with wrong parameters. It requires manual actions

Limitations
-----------
* All controller nodes should be configured with Cinder role
* Only one NetApp backend can be configured to work with Cinder
* Before creating Ubuntu repository's mirrors in Fuel, you have to manually add to /usr/share/fuel-mirror/ubuntu.yaml following packages:
  * nfs-common
  * open-iscsi
  * multipath-tools
