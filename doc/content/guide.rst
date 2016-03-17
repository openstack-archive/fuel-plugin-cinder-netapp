
Once the Fuel Cinder NetApp  plugin has been installed, you can
create OpenStack environments that use NetApp storage as a Cinder backend.


Configuring NetApp plugin
-------------------------

#. Create an OpenStack environment using the Fuel UI wizard:

   .. image:: images/create_env.png
      :width: 90%

#. Finish environment creation following
   `the instructions <https://docs.mirantis.com/openstack/fuel/fuel-8.0/user-guide.html#create-a-new-openstack-environment>`_.

#. Once the environment is created, open the **Settings** tab of the Fuel Web UI
   and then **Storage**. Scroll down the page. Select the **Cinder and NetApp integration**
   checkbox:

   .. image:: images/select-checkbox.png
      :width: 40%

#. Configure the plugin.Select **Multibackend enabled** checkbox
   if you would like NetApp driver to be used as the Cinder Multibackend feature:

   .. image:: images/multibackend.png
       :width: 50%

#. Choose storage family and storage protocol. Several options are available.

   - If you plan to use ONTAP cluster mode through NFS, click **Ontap Cluster**
     radiobutton and select *nfs* option in **Netapp storage protocol**.
     You should also choose NetApp transport type (http or https).
     Specify the following parameters in the text fields:

     - Netapp username
     - Netapp password
     - Netapp server hostname
     - NFS server
     - NFS share(s)
     - Netapp Vserver

     .. image:: images/cmode_nfs.png
        :width: 100%

   - If you plan to use ONTAP cluster mode through iSCSI, click **Ontap Cluster**
     radiobutton and select *iscsi* option in **Netapp storage protocol**.
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

     .. image:: images/eseries.png
        :width: 100%

#. Using *Nodes* tab,
   `add nodes and assign roles to them <https://docs.mirantis.com/openstack/fuel/fuel-8.0/user-guide.html#add-nodes-to-the-environment>`_.
   Please, note that all controller nodes should be configured with Cinder role.

#. This step is needed only when local fuel mirrors are used
   Following packages ``nfs-common``, ``open-iscsi``, ``multipath-tools`` aren't included by default when local mirror is created. To have these packages available during deploy you have to add them into  ``/usr/share/fuel-mirror/ubuntu.yaml`` file in ``packages: &packages`` section.

   .. code-block:: ruby

      packages: &packages
        - "nfs-common
        - "open-iscsi"
        - "multipath-tools"

#. Press `Deploy button <https://docs.mirantis.com/openstack/fuel/fuel-8.0/user-guide.html#deploy-changes>`_
   once you are done with environment configuration.

#. When the deployment is done, you may perform functional testing.
   You can find instructions in `NetApp Mirantis Unlocked Reference Architecture <http://content.mirantis.com/Mirantis-NetApp-Reference-Architecture-Landing-Page.html>`_, paragraph 8.3. 
