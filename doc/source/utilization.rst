===========
Utilization
===========

Usage
-----
Since the plugin set up Cinder backend, to operate with plugin functionality you should use Cinder and set one of types ``NetApp_Backend_1``, ``NetApp_Backend_2``, ``NetApp_Backend_3`` for volumes.

To make the types clearer to identify, you can rename them. See the example below, where ``NetApp_Backend_1`` is E-Series storage and ``NetApp_Backend_2`` is SolidFire storage::

  root@node-1:~# cinder type-list
  +--------------------------------------+------------------+-------------+-----------+
  |                  ID                  |       Name       | Description | Is_Public |
  +--------------------------------------+------------------+-------------+-----------+
  | 33c04153-9117-4a00-9531-76eaa768795d | NetApp_Backend_2 |      -      |    True   |
  | 5deec096-0c2d-4d16-bfeb-6c462da1d9d7 | NetApp_Backend_1 |      -      |    True   |
  | 6955d739-b62b-4d60-a79c-93a1ba125e2b |   volumes_lvm    |      -      |    True   |
  +--------------------------------------+------------------+-------------+-----------+
  root@node-1:~# cinder  type-update --name SolidFire --is-public true 33c04153-9117-4a00-9531-76eaa768795d
  +--------------------------------------+-----------+-------------+-----------+
  |                  ID                  |    Name   | Description | Is_Public |
  +--------------------------------------+-----------+-------------+-----------+
  | 33c04153-9117-4a00-9531-76eaa768795d | SolidFire |      -      |    True   |
  +--------------------------------------+-----------+-------------+-----------+
  root@node-1:~# cinder  type-update --name E-Series --is-public true 5deec096-0c2d-4d16-bfeb-6c462da1d9d7
  +--------------------------------------+----------+-------------+-----------+
  |                  ID                  |   Name   | Description | Is_Public |
  +--------------------------------------+----------+-------------+-----------+
  | 5deec096-0c2d-4d16-bfeb-6c462da1d9d7 | E-Series |      -      |    True   |
  +--------------------------------------+----------+-------------+-----------+
  root@node-1:~# cinder type-list
  +--------------------------------------+-------------+-------------+-----------+
  |                  ID                  |     Name    | Description | Is_Public |
  +--------------------------------------+-------------+-------------+-----------+
  | 33c04153-9117-4a00-9531-76eaa768795d |  SolidFire  |      -      |    True   |
  | 5deec096-0c2d-4d16-bfeb-6c462da1d9d7 |   E-Series  |      -      |    True   |
  | 6955d739-b62b-4d60-a79c-93a1ba125e2b | volumes_lvm |      -      |    True   |
  +--------------------------------------+-------------+-------------+-----------+

When you don't need default backend. You can just delete corresponding type. See the example below, where the default backend is volumes_lvm::

  root@node-1:~# cinder type-list
  +--------------------------------------+-------------+-------------+-----------+
  |                  ID                  |     Name    | Description | Is_Public |
  +--------------------------------------+-------------+-------------+-----------+
  | 33c04153-9117-4a00-9531-76eaa768795d |  SolidFire  |      -      |    True   |
  | 5deec096-0c2d-4d16-bfeb-6c462da1d9d7 |   E-Series  |      -      |    True   |
  | 6955d739-b62b-4d60-a79c-93a1ba125e2b | volumes_lvm |      -      |    True   |
  +--------------------------------------+-------------+-------------+-----------+
  root@node-1:~# cinder type-delete 6955d739-b62b-4d60-a79c-93a1ba125e2b
  root@node-1:~# cinder type-list
  +--------------------------------------+-----------+-------------+-----------+
  |                  ID                  |    Name   | Description | Is_Public |
  +--------------------------------------+-----------+-------------+-----------+
  | 33c04153-9117-4a00-9531-76eaa768795d | SolidFire |      -      |    True   |
  | 5deec096-0c2d-4d16-bfeb-6c462da1d9d7 |  E-Series |      -      |    True   |
  +--------------------------------------+-----------+-------------+-----------+

Verification
------------
To perform functional testing you should:

* Create a volume via Cinder and set any available NetApp type
* Attach the volume to any available instance
* Create a snapshot of this volume
* Create a volume using the snapshot

Troubleshooting
---------------
* If anything is not working, first check ``cinder-volume.log`` file on Cinder node. It provides most information you need for troubleshooting
* Enable ``debug`` for Cinder when information in log files is not enough
* When NFS is used, check that nfs shares are mounted and ``cinder`` user has ability to write into
* When iSCSI is used, check network connectivity between iscsi ports on NetApp and Cinder\Compute nodes
