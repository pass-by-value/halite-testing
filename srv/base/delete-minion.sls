create_test_minion:
  cmd.run:
    - name: 'salt-cloud -y -d rackspace_512 halite_ubuntu_test'
