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


Requirements
------------

======================= =================================
Requirement             Version/Comment
======================= =================================
Fuel                    7.0
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
