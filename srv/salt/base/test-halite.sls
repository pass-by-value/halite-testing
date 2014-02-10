runprep-dist:
  cmd.script:
    - source: salt://prep_dist.sh
    - cwd: /root/halite

run-halite-tests:
  cmd.script:
    - source: salt://halite_test.sh
    - cwd: /root/halite
