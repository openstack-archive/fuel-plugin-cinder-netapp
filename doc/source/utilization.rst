Utilization
===========


Using
-----
Since the plugin set up Cinder backend, to operate with plugin functionality you should use Cinder and set type ``netapp`` for volumes.


Verification
------------
To perform functional testing you should:

* Create a volume via Cinder and set type as ``netapp``
* Attach the volume to any available instance
* Create a snapshot of this volume
* Create a volume using the snapshot


Troubleshooting
---------------
* If anything is not working, first check ``cinder-volume.log`` file on Cinder node. It provides most information you need for troubleshooting
* Enable ``debug`` for Cinder when information in log files is not enough
* When NFS is used, check that nfs shares are mounted and ``cinder`` user has ability to write into
* When iSCSI is used, check network connectivity between iscsi ports on NetApp and Cinder\Compute nodes
