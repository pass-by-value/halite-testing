cloud-providers-directory:
  file.directory:
    - name: '/etc/salt/cloud.providers.d/'
    - user: root
    - group: root
    - recurse:
      - user
      - group

cloud-providers-file:
  file.managed:
    - name: '/etc/salt/cloud.providers.d/rackspace.conf'
    - source: salt://salt-cloud/cloud.providers.d/rackspace.conf
    - user: root
    - group: root
    - template: jinja
    - require:
      - file: '/etc/salt/cloud.providers.d/'

cloud-profiles-directory:
  file.directory:
    - name: '/etc/salt/cloud.profiles.d/'
    - user: root
    - group: root
    - recurse:
      - user
      - group

cloud-profiles-file:
  file.managed:
    - name: '/etc/salt/cloud.profiles.d/rackspace.conf'
    - source: salt://salt-cloud/cloud.profiles.d/rackspace.conf
    - user: root
    - group: root
    - template: jinja
    - require:
      - file: '/etc/salt/cloud.profiles.d/'

salt-state-dir:
  file.directory:
    - name: '/srv/salt'
    - user: root
    - group: root
    - recurse:
      - user
      - group

state-tree-dir:
  file.directory:
    - name: '/srv/salt/base'
    - user: root
    - group: root
    - recurse:
      - user
      - group

top-file:
  file.managed:
    - name: '/srv/salt/top.sls'
    - source: salt://minion-state-tree/top.sls
    - user: root
    - group: root
    - require:
      - file: '/srv/salt/base'
 
apache-install:
  file.managed:
    - name: '/srv/salt/apache-formula.sls'
    - source: salt://minion-state-tree/apache-formula.sls
    - user: root
    - group: root
    - require:
      - file: '/srv/salt/base'

curl:
  pkg:
    - installed

build-essential:
  pkg:
    - installed

python-dev:
  pkg:
    - installed

python-pip:
  pkg:
    - installed

git-core:
  pkg:
    - installed

sshpass:
  pkg:
    - installed

https://github.com/saltstack/salt.git:
  git.latest:
    - rev: develop
    - target: /root/salt

salt-pkg:
  pip.installed:
    - editable: '/root/salt'
    - require:
      - pkg: python-pip

copy_file:
  file.copy:
    - name: '/etc/init/salt-master.conf'
    - source: '/root/salt/pkg/salt-master.upstart'
    - user: root
    - group: root

start-salt:
  service.running:
    - name: salt-master
    - require:
      - file: '/etc/init/salt-master.conf'

https://github.com/saltstack/halite.git:
  git.latest:
    - rev: master
    - target: /root/halite

halite-pkg:
  pip.installed:
    - editable: '/root/halite'
    - require:
      - pkg: python-pip

#create_test_minion:
#  cmd.run:
#    - name: 'salt-cloud -y -p rackspace_512 halite_ubuntu_test'
install-nvm:
  cmd.run:
    - name: 'curl https://raw.github.com/creationix/nvm/master/install.sh | sh'
    - require:
      - pkg: curl

#install-node:
#  cmd.run:
#    - name: 'nvm install 0.10'
#    - require:
#      - nvm

#install-halite-deps:
#  cmd.run:
#    - name: 'npm install .'
#    - cwd: /root/halite
#    - require:
#      - pkg: npm
