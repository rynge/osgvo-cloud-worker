#!/bin/bash

rm -rf /opt/osgvo-cloud-worker
cd /opt
git clone https://github.com/rynge/osgvo-cloud-worker.git

# install salt
curl -L https://bootstrap.saltstack.com | bash -
cat >/etc/yum.repos.d/saltstack.repo <<EOF
[saltstack]
name=SaltStack latest Release Channel for RHEL/CentOS \$releasever
baseurl=https://repo.saltstack.com/yum/redhat/7/\$basearch/2018.3/
skip_if_unavailable=True
gpgcheck=1
gpgkey=https://repo.saltstack.com/yum/redhat/7/\$basearch/2018.3/SALTSTACK-GPG-KEY.pub
enabled=1
enabled_metadata=1
EOF
yum install -y epel-release salt salt-minion

# configure salt for local execution
rm -f /srv/salt
ln -s /opt/osgvo-cloud-worker/host-system/salt /srv/salt
echo "file_client: local" >/etc/salt/minion.d/50-osg-cloud-worker.conf

salt-call --local state.apply
systemctl restart autofs
salt-call --local state.apply


