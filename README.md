Cinder NetApp plugin
====================

This repo contains all necessary files to build Cinder NetApp Fuel plugin.
Currently the only supported Fuel version is 6.0.

Building the plugin
-------------------

1. Clone the fuel-plugins repo from https://github.com/stackforge/fuel-plugins
2. Install Fuel Plugin Builder using documentation from the fuel-plugins repo
3. Clone the fuel-plugin-cinder-netapp repo from https://github.com/stackforge/fuel-plugin-cinder-netapp
4. Execute fpb --build <path>, where <path> is the path to the plugin's main
   folder (fuel-plugin-cinder-netapp)
5. cinder\_netapp-1.0.0.fp plugin file will be created
6. Move this file to the Fuel master node and install it using
   the following command: fuel plugins --install cinder\_netapp-1.0.0.fp
7. Plugin is ready to use and can be enabled via Fuel WebUI ('Settings' tab)

Deployment details
------------------

Cinder NetApp driver will replace LVM Cinder driver

#### Prerequisites

1. NetApp applience is deployed and configured
2. NetApp applience is reachable via one of MOS networks

#### Limitations
1. Cinder volume is not highly available
2. Only one Cinder node should be deployed

#### Deployment procedure
1. Create environment with default Cinder backend (LVM)
2. Enable Cinder NetApp plugin under Settings tab
3. Do a plugin configuration
4. Assign Cinder role to one of the nodes


Accessing Cinder NetApp functionality
------------------------------

Please use official Openstack documentation to obtain more information:
- http://docs.openstack.org/juno/config-reference/content/netapp-volume-driver.html
