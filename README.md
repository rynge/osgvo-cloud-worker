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

Select allocation source and instance size:

![JetStream image find](https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/images/jetstream-instance-launch.png)

Click `Advanced Options`. The first time you start an instance, you have to add a
deployment script. We use this to configure the instance. Once the script has been
added, you can just select it over and over again for new instances.

Add the script as `Raw Text`. Copy and paste the following, and update the settings. At 
a minimum, you have to provide the token (provided by OSG staff as described above), and
set a `Start` expression, which should limit the instance to only run your own jobs. Most
of the time, you can do this by specifying your `ProjectName`, as in the example. You
may also update the `WorkerGroupName` to something unique, as that makes it easier to 
find you instances in the OSG collector.

```
#!/bin/bash
cat >/etc/osg-worker.conf <<EOF
WorkerGroupName = My Test Workers
Token = aaabbb...
Start = TARGET.ProjectName == "TG-NNNNNN"
EOF
```

![JetStream image find](https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/images/jetstream-instance-launch-advanced.png)

Start the instance and wait for it to boot.

## Monitoring

Once an instance has booted, you can query `flock.opensciencegrid.org` to see if it the instance
is there. Query using the `WorkerGroupName` string from the deployment script. Example:

```
condor_status -pool flock.opensciencegrid.org -const 'WorkerGroupName == "My Test Workers"'
```

## Advanced: Setting Up an Image

So far, this document has described the JetStream usecase. However, the code should be usable on 
other clouds as well, providing there is a way to inject the `/etc/osg-worker.conf` file. To set
up the image, start with a CentOS 7 base image, and run:

```
curl -L https://raw.githubusercontent.com/rynge/osgvo-cloud-worker/master/host-system/deploy.sh | bash -
```

