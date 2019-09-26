# osgvo-cloud-worker

An OSG VO worker node for cloud deployments

## Atmosphere

When starting the image, add a startup script via the launch web interface like:

```
#!/bin/bash
cat >/etc/osg-worker.conf <<EOF
OSG_WORKER_NAME = Test Worker
TOKEN = fobar
START = TARGET.ProjectName == "OSG-STAFF"
EOF
```

## Deploy

```
curl -L https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/host-system/deploy.sh | bash -
```

