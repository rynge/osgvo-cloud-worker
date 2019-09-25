#!/bin/bash

rm -rf /opt/osgvo-cloud-worker
cd /opt
git clone https://github.com/rynge/osgvo-cloud-worker.git

# install salt
curl -L https://bootstrap.saltstack.com | bash -

# configure salt for local execution
rm -f /srv/salt
ln -s /opt/osgvo-cloud-worker/host-system/salt /srv/salt
echo "file_client: local" >/etc/salt/minion.d/50-osg-cloud-worker.conf

salt-call --local state.apply
salt-call --local state.apply


