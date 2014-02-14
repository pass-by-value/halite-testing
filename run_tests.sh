#!/usr/bin/env bash

salt-cloud -y -p rackspace_512 halite_ubuntu_master
salt halite_ubuntu_master state.highstate
salt halite_ubuntu_master state.sls create-minion
salt halite_ubuntu_master cmd.run 'salt \* state.highstate'
salt halite_ubuntu_master state.sls run-halite-testing
salt halite_ubuntu_master cp.push /root/halite_test_results.xml
salt halite_ubuntu_master state.sls delete-minion
mv /var/cache/salt/master/minions/halite_ubuntu_master/files/root/halite_test_results.xml $HOME/jenkins
salt-cloud -y -d rackspace_512 halite_ubuntu_master
