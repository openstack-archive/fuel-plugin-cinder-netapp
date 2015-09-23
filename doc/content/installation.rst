
Installation Guide
==================

Configure OnTapp cluster
------------------------

Pre setup
~~~~~~~~~
1. Using VMware ESX or VMware player, create 2 networks called VM Network and Cluster Network.

2. Untar the vsim and add it to your VMware ESX inventory/VMware Player inventory.

NOTE: The VM will have 4 NICs. The first 2 e0a and e0b are connected to Cluster  
Network and the second 2 (e0c and e0d) are connected to the VM Network. The VM  
Network   should   be   the   regular   VMware   vSwitch   that   is   bridged   onto   the   lab   network.  
The Cluster Network is a vSwitch that's connected to nothing. The purpose of the  
Cluster Network is the following: when you have multiple vsims you want to cluster  
together, they use this private network to talk to each other. The point is not in  
clustering vsims (this will not be done), so this network will be unused, but you should  
still create it. You should only take into consideration that e0a and e0b are connected to  
a fake network so you should not use them; use e0c and e0d exclusively.  
OS setup

OS setup
~~~~~~~~
1. Start up the VM with the console open. 
2. Press Ctrl­C when the message about the boot menu appears (you only get about 15 seconds to do this so do not miss it). 
3. Select option 4 (Clean configuration and initialize all disks). 
4. Answer Yes to the next 2 questions. 
5. The VM will reboot and do some work. 

Cluster setup
~~~~~~~~~~~~~

1. When it asks if you want to join or create a cluster, select Create. 
2. Answer Yes when it asks about a single node cluster. 
3. Enter the cluster name: <cluster_name>­cluster. 
4. Enter cluster base license key. Do not enter any more license keys. 
5. Enter the admin password twice. 
6. Cluster management interface. 
 
Port: e0c

IP address: 192.168.4.10

Netmask: 255.255.255.128

Default gateway 192.168.4.1

DNS domain name: <name>.netapp.com

Nameserver IP: 192.18.4.1

Location: <location_name>

7. Node management interface. 
 
Port: e0c

IP address: 192.168.4.12

Netmask: 255.255.255.128

Default gateway 192.168.4.1


8. Press enter to acknowledge the autosupport notification 

Cluster configuration
~~~~~~~~~~~~~~~~~~~~~

1. You can either continue through the VMware console, or switch to SSH at this point. If you SSH, connect to the cluster management interface (in our case, that is 192.168.4.10).

2. Login at the prompt using <admin_name> and <password>.

3. Add the unassigned disks to the node by entering the following command: storage disk assign -all true -node <cluster_name>-cluster-01

4. Create an aggregate using 10 disks: storage aggregate create -aggregate aggr1 -diskcount 10

5. Create a vserver:

  ``vserver create -vserver <server_name>-vserver -rootvolume vol1 -aggregate aggr1 -ns-switch file -rootvolume-security-style unix``
 
6. Create a data LIF:

  ``network interface create -vserver bswartz-vserver -lif bswartz-data -role data -home-node <cluster_name>-cluster-01 -home-port e0d -address <192.168.4.15>-netmask <255.255.255.128>``

7. Add a rule to the default export policy:

  ``vserver export-policy rule create -vserver <server_name>-vserver -policyname default -clientmatch 0.0.0.0/0 -rorule any -rwrule any -superuser any -anon 0``

8. Enable NFS on the vServer:
 
  ``vserver nfs create -vserver <server_name>-vserver -access true``
 
9. Create a volume with some free space:

  ``volume create -vserver <server_name>-vserver -volume vol<volume_number> -aggregate aggr1 -size 5g -junction-path /vol<volume_number>``


Configure E-Series cluster
------------------------

Pre setup
~~~~~~~~~

1. Install e-series emulator
2. Assign IP range to the hodt machine with emulator using script: ``SetupOutOfBandIPAddresses.sh``
3. Run the scrtipt ``StartSimBP.sh`` it will run a wizard and create out of band emulator configuration as shown in the ppicture below

.. image:: images/e-series_emulator-setup.jpg
   :width: 100%

4. Once emaultor is created run it from the wizard:

.. image:: images/e-series.jpg
   :width: 100%

5. Manually discover storage array using IP addresses from the setp 3

Installing NetApp plugin
========================

To install the Cinder Netapp plugin, follow these steps:

#. Download it from the `Fuel Plugins Catalog`_

#. Copy the plugin's RPM to the Fuel Master node (if you don't
   have the Fuel Master node, please see the official
   Mirantis OpenStack documentation)::

      [root@home ~]# scp cinder_netapp-2.0-2.0.0-1.noarch.rpm root@fuel-master:/tmp

#. Log into Fuel Master node and install the plugin using the
   `Fuel CLI <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#using-fuel-cli>`_:

   ::

      [root@fuel-master ~]# fuel plugins --install cinder_netapp-2.0-2.0.0-1.noarch.rpm 

#. Verify that the plugin is installed correctly::


     [root@fuel-master ~]# fuel plugins
     id | name          | version | package_version
     ---|---------------|---------|----------------
     1  | cinder_netapp | 2.0.0   | 3.0.0


.. _Fuel Plugins Catalog: https://www.mirantis.com/products/openstack-drivers-and-plugins/fuel-plugins/
