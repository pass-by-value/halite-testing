###Halite Testing:

SLS files for setting up Halite integration setup. This document describes general steps in running Halite's functional tests.

####What it does:

Install Halite, Salt Master and Salt Cloud related files.

The top file calls salt-cloud.sls (TODO: should be split into multiple files) which installs Salt Master (salt-master) on the minion. Salt Cloud files are also installed on the minion. The provided example (Rackspace) config file sets the master dynamically. A state tree is setup on the newly installed master (currently Halite tests install apache server on the minion) so it can install actual testing deps.

Finally Halite is installed and compiled from source. Any related deps are also installed.

There are more State (sls) files that create with creation and deletion of minions.

####Installation Steps:

* Make sure that your /srv/salt has the start tree provided by this project
* Run highstate (the top file calls salt-cloud)
* Run create-minion.sls to create the test minions
* Run perform-test.sls to do the tests 
* Run delete-minion.sls to delete the test minion
* The server can now be deleted by the Jenkin's server
