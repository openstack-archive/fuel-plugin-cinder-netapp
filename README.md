Cinder NetApp plugin for Fuel
=============================

Overview
--------

The plugin configures NetApp backend for Cinder using multibackend feature.


The plugin support following storage families:
 - Clustered Data ONTAP
 - Data ONTAP 7-Mode
 - E-Series/EF-Series

This repo contains all necessary files to build Cinder NetApp Fuel plugin.


Requirements
------------

| Requirement                                                                              | Version/Comment                                                        |
|------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| Mirantis Openstack compatibility                                                         | 9.0                                                                    |
| Netapp filer or appliance is reachable via one of the Mirantis OpenStack networks        | Data ONTAP or E-Series/EF-Series storage family with NFS\iSCSI enabled |


Release Notes
-------------

**5.0.0**

* Added MOS 9.0 support

* Removed code related to MOS backends

* Added MOS LCM support (Experimental)

**4.2.1**

* Documentation has been updated and fixed

**4.2.0**

* Added full support of multi backends

* The code has been refactored and commented, slightly

* Added small changes to get free allocation of roles

**4.1.1**

* Fixed bug with multi backend when Ceph is used (bug: 1581028)

**4.1.0**

* Rewrited fields in UI

**4.0.0**

* Added MOS 8.0 support

**3.2.0**

* Added E-Series storage family support

* Fixed the plugin UI

**3.1.0**

* Added high availability of operations with Volumes

**3.0.0**

* The plugin was migrated from 2.0.0 to 3.0.0 package version

**2.0.0**

* The plugin was migrated from 1.0.0 to 2.0.0 package version

**1.2.0**

* Added multi backend support

* Added missing dependencies on compute node

* Added capacity to deploy cinder role on a non controller node

**1.1.0**

* Added 7 mode storage family support

**1.0.0**

* Initial release of the plugin

