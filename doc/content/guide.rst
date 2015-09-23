
Once the Fuel Cinder NetApp  plugin has been installed, you can
create OpenStack environments that use NetApp storage as a Cinder backend.


Configuring NetApp plugin
-------------------------

#. Create an OpenStack environment using the Fuel UI wizard:

   .. image:: images/create_env.png
      :width: 90%

#. Finish environment creation following
   `the instructions <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#create-a-new-openstack-environment>`_.*

#. Once the environment is created, open the **Settings** tab of the Fuel Web UI
   and scroll down the page. Select the **Cinder and NetApp integration**
   checkbox:

   .. image:: images/select-checkbox.png
      :width: 40%

#. Configure the plugin.Select **Multibackend enabled** checkbox
   if you would like NetApp driver to be used as the Cinder Multibackend feature:

   .. image:: images/multibackend.png
       :width: 50%

#. Choose storage family and storage protocol. Several options are available.

   - If you plan to use ONTAP cluster mode through iSCSI, click **Ontap Cluster**
     radiobutton and select *iscsi* or *nfs* option in **Netapp storage protocol**.
     You should also choose NetApp transport type (http or https).
     Specify the following parameters in the text fields:

    - Netapp username
    - Netapp password
    - Netapp server hostname
    - Netapp Vserver

    .. image:: images/cmode_iscsi.png
       :width: 100%

  - If you plan to use ONTAP 7 mode through NFS, click **Ontap 7mode**
    radiobutton and select *nfs* option in **Netapp storage protocol**.
    You should also choose NetApp transport type (http or https).
    Specify the following parameters in the text fields:

    - Netapp username
    - Netapp password
    - Netapp server hostname
    - NFS server
    - NFS share(s)

    .. image:: images/7mode_nfs.png
       :width: 100%

  -  If you plan to use ONTAP 7 mode through iSCSI, click **Ontap 7mode**
     radiobutton and select *iscsi* option in **Netapp storage protocol**.
     You should also choose NetApp transport type (http or https).
     Specify the following parameters in the text fields:

    - Netapp username
    - Netapp password
    - Netapp server hostname

    .. image:: images/7mode_iscsi.png
       :width: 100%
      
  - If you plan to use E-series, click **E-Series**
    radiobutton and select the only available *iscsi* option in **Netapp storage protocol**.
    You should also choose NetApp transport type (http or https).
    Specify the following parameters in the text fields: please specify the following parameters:

    - Netapp username
    - Netapp password
    - Netapp server hostname
    - Netapp controller IPs
    - Netapp SA password
    - Storage pools

    .. image:: images/eseries.png
       :width: 100%

#. Using *Nodes* tab, `add nodes and assign roles to them <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#add-nodes-to-the-environment>`_.
   Please, note that all controller nodes should be configured with Cinder role.

#. Press `Deploy button <https://docs.mirantis.com/openstack/fuel/fuel-7.0/user-guide.html#deploy-changes>`_
   once you are done with environment configuration.

