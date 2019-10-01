# osgvo-cloud-worker

An OSG VO worker node for cloud deployments

 * [Warning About Shutdown State](#warning-about-shutdown-state)
 * [Starting Instances on JetStream](#starting-instances-on-jetStream)
 * [Monitoring](#monitoring)
 * [Advanced: Setting Up an Image](#advanced-setting-up-an-image)


## Warning About Shutdown State

These images are set to auto-shutdown if there are no matching jobs for 
some time (currently 25 minutes). When this happens the images in JetStream 
goes into the `Shutdown` state, but please note that you are still charged
for instances in this state, at 50% the regular charge. To stop this charging
of SUs, please log in to Atmoshere and `Delete` the instances. Please see:
[JetStream Documentation](https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/537460754/Instance+management+actions)
for more information.

## Starting Instances on JetStream

To get started, you first need to obtain a token so that the instances can 
authenticate with the OSG VO central manager (flock.opensciencegrid.org). To obtain
the token, ask for one by open a ticket with support@osgconnect.net . Tokens will
only be provided to users who have OSGConnect accounts or XSEDE allocations.

Once you have a token, log in to the [JetStream Atmosphere interface](https://use.jetstream-cloud.org/)
using your XSEDE credentials. Create a project for your OSG instances, and click the
`New` button, and select `Instance`. In the image search interface, select the
`Show All` tab and search for `OSG Cloud Worker`. The result should look something like:

![JetStream image find](https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/images/jetstream-find-image.png)


![JetStream image find](https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/images/jetstream-instance-launch.png)

When starting the image, add a startup script via the launch web interface like:

```
#!/bin/bash
cat >/etc/osg-worker.conf <<EOF
WorkerGroupName = My Test Workers
Token = aaabbb...
Start = TARGET.ProjectName == "TG-NNNNNN"
EOF
```

![JetStream image find](https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/images/jetstream-instance-launch-advanced.png)

## Monitoring

```
condor_status -pool flock.opensciencegrid.org -const 'WorkerGroupName == "My Test Workers"'
```

## Advanced: Setting Up an Image

CentOS 7

```
curl -L https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/host-system/deploy.sh | bash -
```

