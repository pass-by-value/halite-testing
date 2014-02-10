source /root/.nvm/nvm.sh
nvm use 0.10
export PYTHONPATH=$HOME/halite/halite
nosetests
