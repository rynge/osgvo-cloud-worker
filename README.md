# osgvo-cloud-worker

An OSG VO worker node for cloud deployments

 * [Warning About Shutdown State](#warning-about-shutdown-state)
 * [Starting Instances on JetStream](#starting-instances-on-jetStream)
 * [Monitoring](#monitoring)
 * [Advanced: Setting Up an Image](#advanced-setting-up-an-image)


## Warning About Shutdown State


## Starting Instances on JetStream

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

## Advanced: Setting Up an Image

CentOS 7

```
curl -L https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/host-system/deploy.sh | bash -
```

