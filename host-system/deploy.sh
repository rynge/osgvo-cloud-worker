#!/bin/bash

rm -rf /opt/osgvo-cloud-worker
cd /opt
git clone https://github.com/rynge/osgvo-cloud-worker.git

# install salt
curl -L https://bootstrap.saltstack.com | bash -

# configure salt for local execution
echo "file_client: local" >/etc/salt/minion.d/50-osg-cloud-worker.conf

salt-call --local state.apply


