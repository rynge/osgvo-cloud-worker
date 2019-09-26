# osgvo-cloud-worker

An OSG VO worker node for cloud deployments

## Atmosphere

When starting the image, add a startup script via the launch web interface like:

```
#!/bin/bash
cat >/etc/osg-worker.conf <<EOF
WorkerGroupName = My Test Workers
Token = aaabbb...
Start = TARGET.ProjectName == "OSG-Staff"
EOF
```

## Monitoring

```
condor_status -pool flock.opensciencegrid.org -const 'WorkerGroupName == "My Test Workers"'
```

## Deploy

```
curl -L https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/host-system/deploy.sh | bash -
```

