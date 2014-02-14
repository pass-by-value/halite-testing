###Halite Testing:

SLS files for setting up Halite integration setup. This document describes general steps in running Halite's functional tests.

####What it does:

Install Halite, Salt Master and Salt Cloud related files.

The top file calls salt-cloud.sls (TODO: should be split into multiple files) which installs Salt Master (salt-master) on the minion. Salt Cloud files are also installed on the minion. The provided example (Rackspace) config file sets the master dynamically. A state tree is setup on the newly installed master (currently Halite tests install apache server on the minion) so it can install actual testing deps.

Finally Halite is installed and compiled from source. Any related deps are also installed.

There are more State (sls) files that deal with creation and deletion of minions.

####Installation Steps:

* Make sure that your /srv/salt has the state tree provided by this project
* Change authentication credentials as shown by the [example](https://github.com/pass-by-value/halite-testing/blob/master/srv/pillar/data.sls) pillar data

####Running:
* There is only one file that needs to run (run_test.sh) that file will
  1. Create the master for test
  1. Install the state tree on the newly created master
  1. Create minion that connects to the newly created master
  1. Runs highstate on the newly created master so that Apache is installed on the minion
  1. Runs tests
  1. Copies the results to $HOME/jenkins
  1. Delete minion
  1. Delete master created for test
