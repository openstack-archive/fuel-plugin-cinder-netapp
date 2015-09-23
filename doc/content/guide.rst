
==============================

Once the Fuel Cinder NetApp  plugin has been installed (following `Installation Guide`_), you can
create OpenStack environments that use NetApp storage as a Cinder Backend.


Configuring NetApp plugin
-------------------------

#. Create an OpenStack environment using the Fuel UI wizard:

   .. image:: images/create_env.png
      :width: 100%

#. Finish environment creation following
   `the instructions <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.

#. Once the environment is created, open the *Settings* tab of the Fuel Web UI
   and scroll down the page.

#. Configure the plugin according to your needs.

   .. image:: images/config_plugin.png
      :width: 100%

  - If you plan to use ONTAP cluster mode, please specify the following parameters:
    
    - Netapp login
    - Netapp password
    - Netapp server hostname
    - NFS share
    - Netapp Vserver
      
  - If you plan to use E-series, please specify the following parameters:

    - Netapp login
    - Netapp password
    - Netapp server hostname
    - Storage pools
    - NetApp SA password

#. Using *Nodes* tab, `add nodes and assign roles to them <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#add-nodes-to-the-environment>`_.
   Please, note that all controller nodes should be configured with Cinder role.

#. Press `Deploy button <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#deploy-changes>`_
   once you are done with environment configuration.

