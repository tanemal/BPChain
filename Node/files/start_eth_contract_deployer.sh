#!/bin/bash
geth --datadir=~/.ethereum/devchain init "/root/files/blockchain_files/genesis.json"
geth --datadir=~/.ethereum/devchain --password <(echo -n 123)  account new
BOOTSTRAP_IP=`getent hosts bootstrap | cut -d" " -f1`
GETH_OPTS=${@/IPAddress/$BOOTSTRAP_IP}
python3 -m root.files.node &
geth $GETH_OPTS &
cd /root/files/METAScenario;
node startMigration.js &
cd /root/files/scripts/python_sources
pip install -r requirements.txt
python3 -m python_sources.master_node.run_threads


