#!/bin/bash

function get_config_value {
    # extracts a config attribute value from /etc/osg-worker.conf
    # $1 is the attribute key
    KEY="$1"
    VALUE=`(cat /etc/osg-worker.conf | grep "^$KEY " | tail -n 1 | sed "s/^$KEY *= *//") 2>/dev/null`
    echo "$VALUE"
}

if [ `id -u` = 0 ]; then
    echo "Please do not run me as root!"
    exit 1
fi

mkdir -p `condor_config_val EXECUTE`
mkdir -p `condor_config_val LOG`
mkdir -p `condor_config_val LOCK`
mkdir -p `condor_config_val RUN`
mkdir -p `condor_config_val SPOOL`

# token auth
mkdir -p ~/.condor/tokens.d
get_config_value Token >~/.condor/tokens.d/flock.opensciencegrid.org
chmod 600 ~/.condor/tokens.d/flock.opensciencegrid.org

# start expression to limit what jobs we are running
rm ~/.condor/user_config
echo "START = "`get_config_value Start` >>~/.condor/user_config
echo "WorkerGroupName = \""`get_config_value WorkerGroupName`"\"" >>~/.condor/user_config

tail -F `condor_config_val LOG`/MasterLog `condor_config_val LOG`/StartLog &

condor_master -f

