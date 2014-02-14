source /root/.nvm/nvm.sh
nvm use 0.10
export PYTHONPATH=$HOME/halite/halite
nosetests --with-xunit --xunit-file /root/halite_test_results.xml
