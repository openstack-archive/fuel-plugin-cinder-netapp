=========================
Configuring NetApp plugin
=========================

Once the Fuel Cinder NetApp plugin has been installed, you can create OpenStack environments that use NetApp storage as a Cinder backend.

#. Create an OpenStack environment using the Fuel UI wizard:

   .. image:: images/create_env.png
      :width: 90%

#. Finish environment creation following `the instructions`_.

#. Once the environment is created, open the **Settings** tab of the Fuel Web UI
   and then **Storage**. Scroll down the page. Select the **Cinder and NetApp integration**
   checkbox:

   .. image:: images/select-checkbox.png
      :width: 40%

#. Choose the number of NetApp backends to use:

   .. image:: images/netapp_backends_number.png
      :width: 40%

#. Choose storage family and storage protocol. Several options are available. For details consult `Cinder NetApp driver configuration`_.

   - If you plan to use Clustered Data mode through NFS, click **Clustered Data ONTAP/ONTAP 9**
     radio button and select *NFS* option in **NetApp Storage Protocol**.
     You should also choose NetApp transport type (http or https).

     Specify the following parameters in the text fields:

     - Username
     - Password
     - NetApp Storage Hostname/IP
     - CDOT Data LIF IP address
     - CDOT FlexVol volume junction path
     - Storage Virtual Machine

     .. image:: images/cmode_nfs.png
        :width: 100%

   - If you plan to use Clustered Data mode through iSCSI, click **Clustered Data ONTAP/ONTAP 9**
     radiobutton and select *iSCSI* option in **NetApp Storage Protocol**.
     You should also choose NetApp transport type (http or https).

     Specify the following parameters in the text fields:

     - Username
     - Password
     - NetApp Storage Hostname/IP
     - Storage Virtual Machine

     .. image:: images/cmode_iscsi.png
        :width: 100%

   - If you plan to use E-Series or EF-Series, click **E-Series/EF-Series**
     radiobutton and select the only available *iSCSI* option in **NetApp Storage Protocol**.
     You should also choose NetApp transport type (http or https).
     Specify the following parameters in the text fields:

     - Username
     - Password
     - NetApp Storage Hostname/IP
     - Controller IPs
     - Storage Array Password

     .. image:: images/eseries.png
        :width: 100%

   - If you plan to use SolidFire, click **SolidFire**
     radiobutton and select the only available *iSCSI* option in **NetApp Storage Protocol**.
     Specify the following parameters in the text fields:

     - Login for Cluster Admin account
     - Password for Cluster Admin account
     - Cluster MVIP

     .. image:: images/solidfire.png
        :width: 100%

#. When you use Clustered Data ONTAP or E-Series, you can configure additional options. These options are global, and will affect all the devices.

  Global Options are Hidden:

  .. image:: images/global_opts_hidden.png
     :width: 40%

  Global Options are Shown:

  .. image:: images/global_opts_shown.png
     :width: 40%

#. Using *Nodes* tab, `add nodes and assign roles to them`_.

#. This step is needed only when local fuel mirrors are used
   Following packages ``nfs-common``, ``open-iscsi``, ``multipath-tools`` aren't included by default when local mirror is created. To have these packages available during deploy you have to add them into  ``/usr/share/fuel-mirror/ubuntu.yaml`` file in ``packages: &packages`` section.

   .. code-block:: ruby

      packages: &packages
        - "nfs-common
        - "open-iscsi"
        - "multipath-tools"

#. Press `Deploy button`_ once you are done with environment configuration.

#. When the deployment is done, you may perform functional testing.
   You can find instructions in `NetApp Mirantis Unlocked Reference Architecture`_, paragraph 8.3. 

   .. NOTE::
      Only if using Ceph. Do not be confused by error when
      removing Ceph OSD node. For details see `Fuel bug`_.

.. _the instructions: http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/create-environment/start-create-env.html
.. _add nodes and assign roles to them: http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/configure-environment/add-nodes.html
.. _Deploy button: http://docs.openstack.org/developer/fuel-docs/userdocs/fuel-user-guide/deploy-environment/deploy-changes.html
.. _NetApp Mirantis Unlocked Reference Architecture: http://content.mirantis.com/Mirantis-NetApp-Reference-Architecture-Landing-Page.html
.. _Fuel bug: https://bugs.launchpad.net/fuel/+bug/1604386
.. _Cinder NetApp driver configuration: https://netapp.github.io/openstack-deploy-ops-guide/mitaka/content/section_cinder-configuration.html
